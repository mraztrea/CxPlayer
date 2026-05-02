package com.cxplayer.subtitle

import android.util.Log
import com.cxplayer.data.model.SonioxConfig
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.StateFlow
import okhttp3.*
import okio.ByteString
import okio.ByteString.Companion.toByteString
import org.json.JSONObject

/**
 * Trạng thái kết nối WebSocket.
 */
enum class ConnectionState {
    IDLE, CONNECTING, ACTIVE, ERROR, RECONNECTING, FAILED
}

internal data class SonioxChunk(
    val finalizedOriginalText: String = "",
    val finalizedTranslationText: String = "",
    val provisionalOriginalText: String = "",
    val sourceLanguage: String? = null,
    val startMs: Long? = null,
    val endMs: Long? = null,
    val hasEndToken: Boolean = false
)

/**
 * WebSocket client kết nối Soniox STT API.
 * Xử lý: connect, sendAudio, parse response, session management, keepalive, auto-reconnect.
 */
class SonioxClient(private val scope: CoroutineScope) {
    private val client = OkHttpClient()
    private var ws: WebSocket? = null
    private var config: SonioxConfig? = null
    private var reconnectAttempts = 0
    private var hasValidatedSession = false
    private var sessionStartTime = 0L
    private var keepaliveJob: Job? = null
    private var sessionResetJob: Job? = null
    private var lastTranslationContext = StringBuilder()

    private val _chunkFlow = MutableSharedFlow<SonioxChunk>(extraBufferCapacity = 64)
    internal val chunkFlow: SharedFlow<SonioxChunk> = _chunkFlow

    private val _connectionState = MutableStateFlow(ConnectionState.IDLE)
    val connectionState: StateFlow<ConnectionState> = _connectionState

    companion object {
        private const val TAG = "SonioxClient"
        private const val WS_URL = "wss://stt-rt.soniox.com/transcribe-websocket"
        private const val SESSION_DURATION_MS = 3 * 60 * 1000L // 3 phút
        private const val KEEPALIVE_INTERVAL_MS = 15_000L
        private const val MAX_RECONNECT_ATTEMPTS = 3
        private const val CONTEXT_MAX_CHARS = 500
        private val RECONNECT_DELAYS_MS = longArrayOf(2000, 4000, 6000)
    }

    fun connect(config: SonioxConfig) {
        this.config = config
        reconnectAttempts = 0
        openConnection()
    }

    fun sendAudio(pcmData: ByteArray) {
        if (_connectionState.value != ConnectionState.ACTIVE) return
        val sent = ws?.send(pcmData.toByteString()) ?: false
        if (!sent) {
            Log.w(TAG, "sendAudio: WebSocket send failed, dropped ${pcmData.size} bytes")
        }
    }

    fun disconnect() {
        keepaliveJob?.cancel()
        sessionResetJob?.cancel()
        ws?.close(1000, "stopped")
        ws = null
        hasValidatedSession = false
        _connectionState.value = ConnectionState.IDLE
    }

    private fun openConnection() {
        hasValidatedSession = false
        _connectionState.value = ConnectionState.CONNECTING
        val request = Request.Builder().url(WS_URL).build()
        ws = client.newWebSocket(request, object : WebSocketListener() {
            override fun onOpen(webSocket: WebSocket, response: Response) {
                Log.d(TAG, "WebSocket connected")
                sendConfig(webSocket)
                _connectionState.value = ConnectionState.ACTIVE
                sessionStartTime = System.currentTimeMillis()
                startKeepalive()
                startSessionResetTimer()
            }

            override fun onMessage(webSocket: WebSocket, text: String) {
                Log.d(TAG, "onMessage: ${text.take(200)}")
                handleResponse(text)
            }

            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                Log.e(TAG, "WebSocket failure: ${t.message}")
                _connectionState.value = ConnectionState.ERROR
                attemptReconnect()
            }

            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                Log.d(TAG, "WebSocket closed: $code $reason")
                if (_connectionState.value == ConnectionState.ACTIVE) {
                    _connectionState.value = ConnectionState.ERROR
                    attemptReconnect()
                }
            }
        })
    }

    private fun sendConfig(webSocket: WebSocket) {
        val cfg = config ?: return
        val json = JSONObject().apply {
            put("api_key", cfg.apiKey)
            put("model", "stt-rt-v4")
            put("audio_format", "pcm_s16le")
            put("sample_rate", 16000)
            put("num_channels", 1)
            put("enable_speaker_diarization", true)
            put("enable_language_identification", true)
            put("translation", JSONObject().apply {
                put("type", "one_way")
                put("target_language", cfg.targetLanguage)
            })
            // Context carryover từ phiên trước
            val contextText = lastTranslationContext.toString()
            if (contextText.isNotEmpty()) {
                put("context", JSONObject().apply {
                    put("text", contextText)
                })
            }
        }
        Log.d(TAG, "sendConfig: ${json.toString().replace(cfg.apiKey, "***")}")
        webSocket.send(json.toString())
    }

    private fun handleResponse(text: String) {
        try {
            val json = JSONObject(text)

            // Xử lý error response từ server
            val errorCode = json.optInt("error_code", 0)
            if (errorCode != 0) {
                val errorMsg = json.optString("error_message", "unknown")
                Log.e(TAG, "Server error: code=$errorCode, message=$errorMsg")
                _connectionState.value = ConnectionState.ERROR
                ws?.close(1000, "server_error")
                attemptReconnect()
                return
            }

            if (!hasValidatedSession) {
                hasValidatedSession = true
                reconnectAttempts = 0
            }

            val tokens = json.optJSONArray("tokens") ?: return
            val finalizedOriginal = StringBuilder()
            val finalizedTranslation = StringBuilder()
            val provisionalOriginal = StringBuilder()
            var sourceLanguage: String? = null
            var startMs: Long? = null
            var endMs: Long? = null
            var hasEndToken = false

            for (i in 0 until tokens.length()) {
                val token = tokens.getJSONObject(i)
                val tokenText = token.optString("text", "")
                if (tokenText.isEmpty()) continue
                if (tokenText == "<end>") {
                    hasEndToken = true
                    continue
                }

                val translationStatus = token.optString("translation_status", "none")
                val isFinal = token.optBoolean("is_final", false)
                if (sourceLanguage == null && translationStatus != "translation" && token.has("language")) {
                    sourceLanguage = token.optString("language")
                }
                if (!token.isNull("start_ms")) {
                    val tokenStartMs = token.optLong("start_ms")
                    if (startMs == null || tokenStartMs < startMs) {
                        startMs = tokenStartMs
                    }
                }
                if (!token.isNull("end_ms")) {
                    val tokenEndMs = token.optLong("end_ms")
                    if (endMs == null || tokenEndMs > endMs) {
                        endMs = tokenEndMs
                    }
                }

                when {
                    !isFinal && translationStatus != "translation" -> provisionalOriginal.append(tokenText)
                    translationStatus == "translation" && isFinal -> finalizedTranslation.append(tokenText)
                    translationStatus == "original" && isFinal -> finalizedOriginal.append(tokenText)
                    translationStatus == "none" && isFinal -> finalizedOriginal.append(tokenText)
                }
            }

            if (finalizedTranslation.isNotEmpty()) {
                lastTranslationContext.append(finalizedTranslation)
                if (lastTranslationContext.length > CONTEXT_MAX_CHARS) {
                    val excess = lastTranslationContext.length - CONTEXT_MAX_CHARS
                    lastTranslationContext.delete(0, excess)
                }
            }

            val chunk = SonioxChunk(
                finalizedOriginalText = finalizedOriginal.toString(),
                finalizedTranslationText = finalizedTranslation.toString(),
                provisionalOriginalText = provisionalOriginal.toString(),
                sourceLanguage = sourceLanguage,
                startMs = startMs,
                endMs = endMs,
                hasEndToken = hasEndToken
            )
            if (chunk.finalizedOriginalText.isNotEmpty() ||
                chunk.finalizedTranslationText.isNotEmpty() ||
                chunk.provisionalOriginalText.isNotEmpty() ||
                chunk.hasEndToken
            ) {
                Log.d(
                    TAG,
                    "chunk: finalOriginal=\"${previewText(chunk.finalizedOriginalText)}\", " +
                        "finalTranslation=\"${previewText(chunk.finalizedTranslationText)}\", " +
                        "provisional=\"${previewText(chunk.provisionalOriginalText)}\", hasEnd=${chunk.hasEndToken}"
                )
                _chunkFlow.tryEmit(chunk)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Parse error: ${e.message}")
        }
    }

    private fun previewText(text: String): String {
        return text.replace('\n', ' ').trim().take(80)
    }

    private fun startKeepalive() {
        keepaliveJob?.cancel()
        keepaliveJob = scope.launch {
            while (isActive) {
                delay(KEEPALIVE_INTERVAL_MS)
                ws?.send("""{"type":"keepalive"}""")
            }
        }
    }

    private fun startSessionResetTimer() {
        sessionResetJob?.cancel()
        sessionResetJob = scope.launch {
            delay(SESSION_DURATION_MS)
            performSessionReset()
        }
    }

    /**
     * Make-before-break session reset: mở WebSocket mới trước khi đóng cũ.
     */
    private fun performSessionReset() {
        Log.d(TAG, "Session reset (make-before-break)")
        val oldWs = ws
        val request = Request.Builder().url(WS_URL).build()
        ws = client.newWebSocket(request, object : WebSocketListener() {
            override fun onOpen(webSocket: WebSocket, response: Response) {
                hasValidatedSession = false
                sendConfig(webSocket)
                sessionStartTime = System.currentTimeMillis()
                // Đóng WebSocket cũ sau khi mới đã sẵn sàng
                oldWs?.close(1000, "session_reset")
                startSessionResetTimer()
            }

            override fun onMessage(webSocket: WebSocket, text: String) {
                handleResponse(text)
            }

            override fun onFailure(webSocket: WebSocket, t: Throwable, response: Response?) {
                Log.e(TAG, "Session reset failure: ${t.message}")
                // Fallback: giữ WebSocket cũ
                ws = oldWs
                startSessionResetTimer()
            }

            override fun onClosed(webSocket: WebSocket, code: Int, reason: String) {
                if (webSocket === ws && _connectionState.value == ConnectionState.ACTIVE) {
                    _connectionState.value = ConnectionState.ERROR
                    attemptReconnect()
                }
            }
        })
    }

    private fun attemptReconnect() {
        if (reconnectAttempts >= MAX_RECONNECT_ATTEMPTS) {
            _connectionState.value = ConnectionState.FAILED
            Log.e(TAG, "Max reconnect attempts reached")
            return
        }
        _connectionState.value = ConnectionState.RECONNECTING
        val delay = RECONNECT_DELAYS_MS[reconnectAttempts.coerceAtMost(RECONNECT_DELAYS_MS.size - 1)]
        reconnectAttempts++
        scope.launch {
            delay(delay)
            if (_connectionState.value == ConnectionState.RECONNECTING) {
                openConnection()
            }
        }
    }
}

package com.cxplayer.subtitle

import android.util.Log

import com.cxplayer.data.model.SonioxConfig
import com.cxplayer.data.model.SrtEntry
import com.cxplayer.data.model.SubtitleDisplayMode
import com.cxplayer.data.model.SubtitleEvent
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

/**
 * Orchestrator điều phối luồng AI subtitle:
 * CxAudioProcessor → SonioxClient → SubtitleEvent → UI overlay.
 */
class AiSubtitleManager(private val scope: CoroutineScope) {
    companion object {
        private const val TAG = "AiSubtitleManager"
        private const val SENTENCE_GAP_MS = 900L
        private const val MAX_SENTENCE_CHARS = 84
    }
    private val sonioxClient = SonioxClient(scope)
    private val collectedEntries = mutableListOf<SrtEntry>()
    private val activeOriginalText = StringBuilder()
    private val activeTranslationText = StringBuilder()
    private var activeProvisionalOriginalText = ""
    private var committedOriginalText = ""
    private var committedTranslationText = ""
    private var entryStartMs = 0L
    private var entryIndex = 0
    private var collectJob: Job? = null
    private var lastFinalEndMs: Long? = null

    private val _isActive = MutableStateFlow(false)
    val isActive: StateFlow<Boolean> = _isActive

    private val _displayMode = MutableStateFlow(SubtitleDisplayMode.BOTH)
    val displayMode: StateFlow<SubtitleDisplayMode> = _displayMode

    private val _subtitleFlow = MutableSharedFlow<SubtitleEvent>(replay = 1, extraBufferCapacity = 16)
    val subtitleFlow: SharedFlow<SubtitleEvent> = _subtitleFlow
    val connectionState: StateFlow<ConnectionState> = sonioxClient.connectionState

    fun start(config: SonioxConfig) {
        if (_isActive.value) return
        Log.d(TAG, "start: connecting to Soniox (lang=${config.sourceLanguage} → ${config.targetLanguage})")
        _isActive.value = true
        collectedEntries.clear()
        resetSentenceState(clearCommitted = true)
        entryIndex = 0

        sonioxClient.connect(config)

        collectJob = scope.launch {
            sonioxClient.chunkFlow.collect { chunk ->
                handleChunk(chunk)
            }
        }
    }

    fun stop(): List<SrtEntry> {
        if (!_isActive.value) return emptyList()
        finalizeCurrentEntry()
        collectJob?.cancel()
        sonioxClient.disconnect()
        _isActive.value = false
        return collectedEntries.toList()
    }

    fun onAudioData(pcmData: ByteArray) {
        if (_isActive.value) {
            Log.v(TAG, "onAudioData: ${pcmData.size} bytes")
            sonioxClient.sendAudio(pcmData)
        }
    }

    fun setDisplayMode(mode: SubtitleDisplayMode) {
        _displayMode.value = mode
    }

    private fun handleChunk(chunk: SonioxChunk) {
        if (shouldFlushBeforeAppend(chunk)) {
            finalizeCurrentEntry()
        }

        if (chunk.finalizedOriginalText.isNotEmpty()) {
            if (activeOriginalText.isEmpty() && activeTranslationText.isEmpty()) {
                entryStartMs = System.currentTimeMillis()
            }
            activeOriginalText.append(chunk.finalizedOriginalText)
        }
        if (chunk.finalizedTranslationText.isNotEmpty()) {
            if (activeOriginalText.isEmpty() && activeTranslationText.isEmpty()) {
                entryStartMs = System.currentTimeMillis()
            }
            activeTranslationText.append(chunk.finalizedTranslationText)
        }
        if (chunk.endMs != null) {
            lastFinalEndMs = chunk.endMs
        }
        activeProvisionalOriginalText = chunk.provisionalOriginalText

        if (shouldFlushAfterAppend(chunk)) {
            finalizeCurrentEntry()
        }

        emitSnapshot()
    }

    private fun shouldFlushBeforeAppend(chunk: SonioxChunk): Boolean {
        val startMs = chunk.startMs ?: return false
        val previousEndMs = lastFinalEndMs ?: return false
        if (activeOriginalText.isEmpty() && activeTranslationText.isEmpty()) return false
        return startMs - previousEndMs >= SENTENCE_GAP_MS
    }

    private fun shouldFlushAfterAppend(chunk: SonioxChunk): Boolean {
        val normalizedOriginal = normalizeSubtitleText(activeOriginalText.toString())
        val normalizedTranslation = normalizeSubtitleText(activeTranslationText.toString())
        if (normalizedOriginal.isEmpty() && normalizedTranslation.isEmpty()) {
            return false
        }
        return chunk.hasEndToken ||
            hasSentenceBoundary(normalizedOriginal) ||
            hasSentenceBoundary(normalizedTranslation) ||
            normalizedOriginal.length >= MAX_SENTENCE_CHARS ||
            normalizedTranslation.length >= MAX_SENTENCE_CHARS
    }

    private fun finalizeCurrentEntry() {
        val originalText = normalizeSubtitleText(activeOriginalText.toString())
        val translationText = normalizeSubtitleText(activeTranslationText.toString())
        val text = buildString {
            if (originalText.isNotEmpty()) append(originalText)
            if (translationText.isNotEmpty()) {
                if (isNotEmpty()) append("\n")
                append(translationText)
            }
        }
        if (text.isNotEmpty()) {
            entryIndex++
            collectedEntries.add(
                SrtEntry(
                    index = entryIndex,
                    startMs = entryStartMs,
                    endMs = System.currentTimeMillis(),
                    text = text
                )
            )
            committedOriginalText = originalText
            committedTranslationText = translationText
        }
        resetSentenceState(clearCommitted = false)
    }

    private fun emitSnapshot() {
        val normalizedActiveOriginal = normalizeSubtitleText(activeOriginalText.toString())
        val normalizedActiveTranslation = normalizeSubtitleText(activeTranslationText.toString())
        val normalizedProvisional = normalizeSubtitleText(activeProvisionalOriginalText)
        val hasActiveSentence = normalizedActiveOriginal.isNotEmpty() ||
            normalizedActiveTranslation.isNotEmpty() ||
            normalizedProvisional.isNotEmpty()

        val originalText = if (hasActiveSentence) {
            normalizeSubtitleText(activeOriginalText.toString() + activeProvisionalOriginalText)
        } else {
            committedOriginalText
        }
        val translationText = if (hasActiveSentence) {
            normalizedActiveTranslation
        } else {
            committedTranslationText
        }

        _subtitleFlow.tryEmit(
            SubtitleEvent.Snapshot(
                originalText = originalText,
                translationText = translationText,
                isOriginalProvisional = normalizedProvisional.isNotEmpty()
            )
        )
    }

    private fun resetSentenceState(clearCommitted: Boolean) {
        activeOriginalText.clear()
        activeTranslationText.clear()
        activeProvisionalOriginalText = ""
        lastFinalEndMs = null
        if (clearCommitted) {
            committedOriginalText = ""
            committedTranslationText = ""
        }
    }

    private fun normalizeSubtitleText(text: String): String {
        return text.replace(Regex("\\s+"), " ").trim()
    }

    private fun hasSentenceBoundary(text: String): Boolean {
        val trimmed = text.trimEnd()
        if (trimmed.isEmpty()) return false
        return trimmed.endsWith(".") ||
            trimmed.endsWith("!") ||
            trimmed.endsWith("?") ||
            trimmed.endsWith("…") ||
            trimmed.endsWith("。") ||
            trimmed.endsWith("！") ||
            trimmed.endsWith("？")
    }
}

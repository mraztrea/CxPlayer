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
    private var committedStartMs: Long? = null
    private var committedEndMs: Long? = null
    private var entryStartMs: Long? = null
    private var entryEndMs: Long? = null
    private var entryIndex = 0
    private var collectJob: Job? = null
    private var lastFinalEndMs: Long? = null
    private var lastPlaybackPositionMs = 0L
    private var pendingSnapshot: SubtitleEvent.Snapshot? = null
    private var lastEmittedSnapshot: SubtitleEvent.Snapshot? = null

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

    fun updatePlaybackPosition(positionMs: Long) {
        lastPlaybackPositionMs = positionMs.coerceAtLeast(0L)
        emitPendingSnapshotIfDue()
    }

    fun setDisplayMode(mode: SubtitleDisplayMode) {
        _displayMode.value = mode
    }

    internal fun handleChunk(chunk: SonioxChunk) {
        if (shouldFlushBeforeAppend(chunk)) {
            finalizeCurrentEntry()
        }

        ensureEntryTimingStarted(chunk)

        if (chunk.finalizedOriginalText.isNotEmpty()) {
            activeOriginalText.append(chunk.finalizedOriginalText)
        }
        if (chunk.finalizedTranslationText.isNotEmpty()) {
            activeTranslationText.append(chunk.finalizedTranslationText)
        }
        if (chunk.endMs != null) {
            lastFinalEndMs = chunk.endMs
            if (entryStartMs != null || chunk.provisionalOriginalText.isNotEmpty()) {
                entryEndMs = chunk.endMs
            }
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

    private fun ensureEntryTimingStarted(chunk: SonioxChunk) {
        if (entryStartMs != null) return
        if (chunk.finalizedOriginalText.isEmpty() &&
            chunk.finalizedTranslationText.isEmpty() &&
            chunk.provisionalOriginalText.isEmpty()
        ) {
            return
        }
        entryStartMs = chunk.startMs ?: chunk.endMs ?: lastFinalEndMs
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
            val resolvedStartMs = entryStartMs ?: entryEndMs ?: lastFinalEndMs ?: 0L
            val resolvedEndMs = entryEndMs ?: lastFinalEndMs ?: resolvedStartMs
            entryIndex++
            collectedEntries.add(
                SrtEntry(
                    index = entryIndex,
                    startMs = resolvedStartMs,
                    endMs = resolvedEndMs,
                    text = text
                )
            )
            committedOriginalText = originalText
            committedTranslationText = translationText
            committedStartMs = resolvedStartMs
            committedEndMs = resolvedEndMs
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
        val startPositionMs = if (hasActiveSentence) {
            entryStartMs
        } else {
            committedStartMs
        }
        val endPositionMs = if (hasActiveSentence) {
            entryEndMs ?: lastFinalEndMs
        } else {
            committedEndMs
        }

        pendingSnapshot = SubtitleEvent.Snapshot(
            originalText = originalText,
            translationText = translationText,
            isOriginalProvisional = normalizedProvisional.isNotEmpty(),
            startPositionMs = startPositionMs,
            endPositionMs = endPositionMs
        )
        emitPendingSnapshotIfDue()
    }

    private fun emitPendingSnapshotIfDue() {
        val snapshot = pendingSnapshot ?: return
        val startPositionMs = snapshot.startPositionMs
        if (startPositionMs != null && lastPlaybackPositionMs < startPositionMs) {
            return
        }
        if (snapshot == lastEmittedSnapshot) {
            return
        }
        val displayMode = displayMode.value
        val previousSnapshot = lastEmittedSnapshot
        if (!snapshot.hasVisibleContent(displayMode) &&
            previousSnapshot != null &&
            previousSnapshot.hasVisibleContent(displayMode)
        ) {
            return
        }
        lastEmittedSnapshot = snapshot
        _subtitleFlow.tryEmit(snapshot)
    }

    private fun resetSentenceState(clearCommitted: Boolean) {
        activeOriginalText.clear()
        activeTranslationText.clear()
        activeProvisionalOriginalText = ""
        entryStartMs = null
        entryEndMs = null
        lastFinalEndMs = null
        if (clearCommitted) {
            committedOriginalText = ""
            committedTranslationText = ""
            committedStartMs = null
            committedEndMs = null
            pendingSnapshot = null
            lastEmittedSnapshot = null
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

    private fun SubtitleEvent.Snapshot.hasVisibleContent(mode: SubtitleDisplayMode): Boolean {
        return when (mode) {
            SubtitleDisplayMode.ORIGINAL_ONLY -> originalText.isNotBlank()
            SubtitleDisplayMode.TRANSLATION_ONLY -> translationText.isNotBlank()
            SubtitleDisplayMode.BOTH -> originalText.isNotBlank() || translationText.isNotBlank()
        }
    }
}

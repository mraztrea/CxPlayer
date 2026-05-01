package com.cxplayer.subtitle

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
    private val sonioxClient = SonioxClient(scope)
    private val collectedEntries = mutableListOf<SrtEntry>()
    private var currentOriginalText = StringBuilder()
    private var currentTranslationText = StringBuilder()
    private var entryStartMs = 0L
    private var entryIndex = 0
    private var collectJob: Job? = null

    private val _isActive = MutableStateFlow(false)
    val isActive: StateFlow<Boolean> = _isActive

    private val _displayMode = MutableStateFlow(SubtitleDisplayMode.BOTH)
    val displayMode: StateFlow<SubtitleDisplayMode> = _displayMode

    val subtitleFlow: SharedFlow<SubtitleEvent> = sonioxClient.subtitleFlow
    val connectionState: StateFlow<ConnectionState> = sonioxClient.connectionState

    fun start(config: SonioxConfig) {
        if (_isActive.value) return
        _isActive.value = true
        collectedEntries.clear()
        currentOriginalText.clear()
        currentTranslationText.clear()
        entryIndex = 0
        entryStartMs = System.currentTimeMillis()

        sonioxClient.connect(config)

        collectJob = scope.launch {
            sonioxClient.subtitleFlow.collect { event ->
                when (event) {
                    is SubtitleEvent.Original -> {
                        finalizeCurrentEntry()
                        currentOriginalText.append(event.text)
                        entryStartMs = System.currentTimeMillis()
                    }
                    is SubtitleEvent.Translation -> {
                        currentTranslationText.append(event.text)
                    }
                    is SubtitleEvent.Provisional -> {
                        // Provisional không collect vào SRT
                    }
                }
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
            sonioxClient.sendAudio(pcmData)
        }
    }

    fun setDisplayMode(mode: SubtitleDisplayMode) {
        _displayMode.value = mode
    }

    private fun finalizeCurrentEntry() {
        val text = buildString {
            if (currentOriginalText.isNotEmpty()) append(currentOriginalText)
            if (currentTranslationText.isNotEmpty()) {
                if (isNotEmpty()) append("\n")
                append(currentTranslationText)
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
        }
        currentOriginalText.clear()
        currentTranslationText.clear()
    }
}

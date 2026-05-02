package com.cxplayer.data.model

/**
 * Snapshot hiển thị phụ đề AI đã được gom câu cho UI.
 */
sealed class SubtitleEvent {
    data class Snapshot(
        val originalText: String,
        val translationText: String,
        val isOriginalProvisional: Boolean,
        val startPositionMs: Long?,
        val endPositionMs: Long?
    ) : SubtitleEvent()
}

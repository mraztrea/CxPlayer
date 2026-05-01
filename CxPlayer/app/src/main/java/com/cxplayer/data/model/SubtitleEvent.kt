package com.cxplayer.data.model

/**
 * Sự kiện phụ đề AI được emit từ Soniox STT.
 */
sealed class SubtitleEvent {
    /** Phụ đề ngôn ngữ gốc đã finalized. */
    data class Original(val text: String, val lang: String?) : SubtitleEvent()

    /** Bản dịch đã finalized. */
    data class Translation(val text: String) : SubtitleEvent()

    /** Phụ đề tạm (chưa finalized, sẽ bị thay thế). */
    data class Provisional(val text: String) : SubtitleEvent()
}

package com.cxplayer.data.model

/**
 * Chế độ hiển thị phụ đề AI.
 */
enum class SubtitleDisplayMode {
    /** Chỉ hiển thị phụ đề ngôn ngữ gốc. */
    ORIGINAL_ONLY,

    /** Chỉ hiển thị bản dịch. */
    TRANSLATION_ONLY,

    /** Hiển thị cả phụ đề gốc và bản dịch song song. */
    BOTH
}

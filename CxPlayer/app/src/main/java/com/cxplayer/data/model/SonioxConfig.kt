package com.cxplayer.data.model

/**
 * Cấu hình cho phiên kết nối Soniox STT.
 */
data class SonioxConfig(
    val apiKey: String,
    val sourceLanguage: String = "auto",
    val targetLanguage: String = "vi",
    val translationTerms: List<TranslationTerm> = emptyList()
)

/**
 * Thuật ngữ dịch tùy chỉnh.
 */
data class TranslationTerm(
    val source: String,
    val target: String
)

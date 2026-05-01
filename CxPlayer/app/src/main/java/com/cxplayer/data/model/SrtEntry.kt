package com.cxplayer.data.model

/**
 * Một mục phụ đề trong file SRT, đã finalized.
 */
data class SrtEntry(
    val index: Int,
    val startMs: Long,
    val endMs: Long,
    val text: String
)

package com.cxplayer.data.db

import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

/**
 * Room entity lưu cache phụ đề AI cho một video cụ thể.
 */
@Entity(
    tableName = "cached_subtitles",
    indices = [Index(value = ["videoUri"], unique = true)]
)
data class CachedSubtitleEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val videoUri: String,
    val videoHash: String,
    val language: String,
    val targetLanguage: String,
    val createdAt: Long,
    /** Danh sách SrtEntry serialized dưới dạng JSON. */
    val entries: String
)

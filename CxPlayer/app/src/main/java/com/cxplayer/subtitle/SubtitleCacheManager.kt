package com.cxplayer.subtitle

import android.content.Context
import com.cxplayer.data.db.AppDatabase
import com.cxplayer.data.db.CachedSubtitleEntity
import com.cxplayer.data.model.SrtEntry
import org.json.JSONArray
import org.json.JSONObject

/**
 * Quản lý cache phụ đề AI trong Room DB.
 */
class SubtitleCacheManager(context: Context) {
    private val dao = AppDatabase.getInstance(context).subtitleDao()

    suspend fun getCachedSubtitle(videoUri: String): List<SrtEntry>? {
        val entity = dao.getByVideoUri(videoUri) ?: return null
        return deserializeEntries(entity.entries)
    }

    suspend fun saveSubtitle(
        videoUri: String,
        entries: List<SrtEntry>,
        language: String,
        targetLanguage: String
    ) {
        val entity = CachedSubtitleEntity(
            videoUri = videoUri,
            videoHash = videoUri.hashCode().toString(),
            language = language,
            targetLanguage = targetLanguage,
            createdAt = System.currentTimeMillis(),
            entries = serializeEntries(entries)
        )
        dao.insert(entity)
    }

    suspend fun deleteCache(videoUri: String) {
        dao.deleteByVideoUri(videoUri)
    }

    suspend fun hasCache(videoUri: String): Boolean {
        return dao.countByVideoUri(videoUri) > 0
    }

    private fun serializeEntries(entries: List<SrtEntry>): String {
        val array = JSONArray()
        entries.forEach { entry ->
            array.put(JSONObject().apply {
                put("index", entry.index)
                put("startMs", entry.startMs)
                put("endMs", entry.endMs)
                put("text", entry.text)
            })
        }
        return array.toString()
    }

    private fun deserializeEntries(json: String): List<SrtEntry> {
        val array = JSONArray(json)
        return (0 until array.length()).map { i ->
            val obj = array.getJSONObject(i)
            SrtEntry(
                index = obj.getInt("index"),
                startMs = obj.getLong("startMs"),
                endMs = obj.getLong("endMs"),
                text = obj.getString("text")
            )
        }
    }
}

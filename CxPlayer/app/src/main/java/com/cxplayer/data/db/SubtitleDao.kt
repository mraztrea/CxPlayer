package com.cxplayer.data.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

/**
 * Room DAO cho subtitle cache operations.
 */
@Dao
interface SubtitleDao {
    @Query("SELECT * FROM cached_subtitles WHERE videoUri = :videoUri LIMIT 1")
    suspend fun getByVideoUri(videoUri: String): CachedSubtitleEntity?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(entity: CachedSubtitleEntity)

    @Query("DELETE FROM cached_subtitles WHERE videoUri = :videoUri")
    suspend fun deleteByVideoUri(videoUri: String)

    @Query("SELECT COUNT(*) FROM cached_subtitles WHERE videoUri = :videoUri")
    suspend fun countByVideoUri(videoUri: String): Int
}

package com.cxplayer.player

import android.content.Context
import androidx.media3.exoplayer.source.DefaultMediaSourceFactory
import androidx.media3.exoplayer.source.MediaSource
import com.cxplayer.data.datasource.CxDataSourceFactory

internal class CxMediaSourceFactory(
    private val context: Context
) {
    private val dataSourceFactory = CxDataSourceFactory(context).create()

    fun create(): MediaSource.Factory {
        val mediaSourceFactory = DefaultMediaSourceFactory(context)
        mediaSourceFactory.setDataSourceFactory(dataSourceFactory)
        return mediaSourceFactory
    }
}
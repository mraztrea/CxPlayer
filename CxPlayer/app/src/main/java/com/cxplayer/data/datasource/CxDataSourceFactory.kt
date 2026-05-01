package com.cxplayer.data.datasource

import android.content.Context
import android.net.Uri
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DataSpec
import androidx.media3.datasource.DefaultDataSource
import androidx.media3.datasource.TransferListener
import androidx.media3.datasource.okhttp.OkHttpDataSource
import okhttp3.OkHttpClient
import java.io.IOException
import java.util.concurrent.TimeUnit

private const val CX_PLAYER_USER_AGENT = "CxPlayer/1.0"

internal class CxDataSourceFactory(
    private val context: Context
) {
    private val okHttpClient = OkHttpClient.Builder()
        .connectTimeout(15, TimeUnit.SECONDS)
        .readTimeout(30, TimeUnit.SECONDS)
        .build()

    fun create(): DataSource.Factory {
        val httpFactory = OkHttpDataSource.Factory(okHttpClient)
            .setUserAgent(CX_PLAYER_USER_AGENT)
        val defaultFactory = DefaultDataSource.Factory(context, httpFactory)
        return DataSource.Factory {
            RoutingDataSource(
                defaultFactory = defaultFactory,
                smbFactory = DataSource.Factory(::SmbDataSource)
            )
        }
    }
}

private class RoutingDataSource(
    private val defaultFactory: DataSource.Factory,
    private val smbFactory: DataSource.Factory
) : DataSource {
    private val transferListeners = mutableListOf<TransferListener>()
    private var activeDataSource: DataSource? = null

    override fun addTransferListener(transferListener: TransferListener) {
        transferListeners += transferListener
        activeDataSource?.addTransferListener(transferListener)
    }

    @Throws(IOException::class)
    override fun open(dataSpec: DataSpec): Long {
        activeDataSource?.close()
        val selectedDataSource = if (dataSpec.uri.scheme.equals("smb", ignoreCase = true)) {
            smbFactory.createDataSource()
        } else {
            defaultFactory.createDataSource()
        }
        transferListeners.forEach(selectedDataSource::addTransferListener)
        activeDataSource = selectedDataSource
        return selectedDataSource.open(dataSpec)
    }

    override fun read(buffer: ByteArray, offset: Int, length: Int): Int {
        return activeDataSource?.read(buffer, offset, length)
            ?: throw IOException("Data source chưa được mở.")
    }

    override fun getUri(): Uri? = activeDataSource?.uri

    override fun getResponseHeaders(): Map<String, List<String>> {
        return activeDataSource?.responseHeaders ?: emptyMap()
    }

    @Throws(IOException::class)
    override fun close() {
        activeDataSource?.close()
        activeDataSource = null
    }
}
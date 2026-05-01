package com.cxplayer.data.datasource

import android.net.Uri
import androidx.media3.common.C
import androidx.media3.datasource.BaseDataSource
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DataSpec
import com.hierynomus.msdtyp.AccessMask
import com.hierynomus.msfscc.FileAttributes
import com.hierynomus.msfscc.fileinformation.FileStandardInformation
import com.hierynomus.mssmb2.SMB2CreateDisposition
import com.hierynomus.mssmb2.SMB2CreateOptions
import com.hierynomus.mssmb2.SMB2ShareAccess
import com.hierynomus.smbj.SMBClient
import com.hierynomus.smbj.SmbConfig
import com.hierynomus.smbj.auth.AuthenticationContext
import com.hierynomus.smbj.connection.Connection
import com.hierynomus.smbj.share.DiskShare
import java.io.IOException
import java.util.EnumSet
import java.util.concurrent.TimeUnit

internal class SmbDataSource : BaseDataSource(false) {
    private var currentUri: Uri? = null
    private var smbClient: SMBClient? = null
    private var connection: Connection? = null
    private var share: DiskShare? = null
    private var fileHandle: com.hierynomus.smbj.share.File? = null
    private var readPosition: Long = 0L
    private var bytesRemaining: Long = C.LENGTH_UNSET.toLong()
    private var opened = false

    @Throws(IOException::class)
    override fun open(dataSpec: DataSpec): Long {
        transferInitializing(dataSpec)
        closeSilently()

        val smbUri = SmbUriDescriptor.fromUri(dataSpec.uri)
        val config = SmbConfig.builder()
            .withTimeout(30, TimeUnit.SECONDS)
            .withSoTimeout(30, TimeUnit.SECONDS)
            .build()

        try {
            val client = SMBClient(config)
            val activeConnection = client.connect(smbUri.host)
            val session = activeConnection.authenticate(
                AuthenticationContext(
                    smbUri.username,
                    smbUri.password.toCharArray(),
                    smbUri.domain.orEmpty()
                )
            )
            val activeShare = session.connectShare(smbUri.shareName)
            if (activeShare !is DiskShare) {
                throw IOException("SMB share '${smbUri.shareName}' không hỗ trợ stream file.")
            }

            val activeFileHandle = activeShare.openFile(
                smbUri.filePath,
                EnumSet.of(AccessMask.FILE_READ_DATA),
                EnumSet.of(FileAttributes.FILE_ATTRIBUTE_NORMAL),
                SMB2ShareAccess.ALL,
                SMB2CreateDisposition.FILE_OPEN,
                EnumSet.of(SMB2CreateOptions.FILE_NON_DIRECTORY_FILE)
            )
            val fileSize = activeFileHandle.getFileInformation(FileStandardInformation::class.java).endOfFile

            currentUri = dataSpec.uri
            smbClient = client
            connection = activeConnection
            share = activeShare
            fileHandle = activeFileHandle
            readPosition = dataSpec.position
            bytesRemaining = when {
                dataSpec.length != C.LENGTH_UNSET.toLong() -> dataSpec.length
                fileSize > dataSpec.position -> fileSize - dataSpec.position
                else -> 0L
            }
            opened = true
            transferStarted(dataSpec)
            return bytesRemaining
        } catch (exception: IOException) {
            closeSilently()
            throw exception
        } catch (exception: Exception) {
            closeSilently()
            throw IOException(exception.message ?: "Không thể mở SMB source.", exception)
        }
    }

    override fun read(buffer: ByteArray, offset: Int, length: Int): Int {
        if (length == 0) {
            return 0
        }
        if (bytesRemaining == 0L) {
            return C.RESULT_END_OF_INPUT
        }

        val targetLength = if (bytesRemaining == C.LENGTH_UNSET.toLong()) {
            length
        } else {
            minOf(length.toLong(), bytesRemaining).toInt()
        }
        val bytesRead = fileHandle?.read(buffer, readPosition, offset, targetLength)
            ?: throw IOException("SMB source chưa được mở.")
        if (bytesRead == -1) {
            return C.RESULT_END_OF_INPUT
        }

        readPosition += bytesRead.toLong()
        if (bytesRemaining != C.LENGTH_UNSET.toLong()) {
            bytesRemaining -= bytesRead.toLong()
        }
        bytesTransferred(bytesRead)
        return bytesRead
    }

    override fun getUri(): Uri? = currentUri

    override fun getResponseHeaders(): Map<String, List<String>> = emptyMap()

    @Throws(IOException::class)
    override fun close() {
        closeSilently()
    }

    private fun closeSilently() {
        val shouldTransferEnd = opened
        opened = false

        runCatching { fileHandle?.close() }
        runCatching { share?.close() }
        runCatching { connection?.close(true) }
        runCatching { smbClient?.close() }

        fileHandle = null
        share = null
        connection = null
        smbClient = null
        currentUri = null
        readPosition = 0L
        bytesRemaining = C.LENGTH_UNSET.toLong()

        if (shouldTransferEnd) {
            transferEnded()
        }
    }
}

private data class SmbUriDescriptor(
    val host: String,
    val shareName: String,
    val filePath: String,
    val username: String,
    val password: String,
    val domain: String?
) {
    companion object {
        fun fromUri(uri: Uri): SmbUriDescriptor {
            val host = uri.host?.trim().orEmpty()
            if (host.isEmpty()) {
                throw IOException("Thiếu máy chủ SMB trong URI.")
            }

            val pathSegments = uri.pathSegments.orEmpty().filter { it.isNotBlank() }
            if (pathSegments.size < 2) {
                throw IOException("URI SMB phải chứa share và đường dẫn file.")
            }

            val shareName = pathSegments.first()
            val filePath = pathSegments.drop(1).joinToString("\\")
            val parsedUserInfo = parseUserInfo(uri.userInfo)
            val queryDomain = uri.getQueryParameter("domain")?.takeIf { it.isNotBlank() }
            return SmbUriDescriptor(
                host = host,
                shareName = shareName,
                filePath = filePath,
                username = parsedUserInfo.username,
                password = parsedUserInfo.password,
                domain = queryDomain ?: parsedUserInfo.domain
            )
        }

        private fun parseUserInfo(rawUserInfo: String?): ParsedUserInfo {
            val userInfo = rawUserInfo.orEmpty()
            if (userInfo.isEmpty()) {
                return ParsedUserInfo(username = "", password = "", domain = null)
            }

            val userAndPassword = userInfo.split(':', limit = 2)
            val principal = Uri.decode(userAndPassword[0])
            val password = userAndPassword.getOrNull(1)?.let(Uri::decode).orEmpty()
            val domainAndUser = principal.split(';', limit = 2)
            return if (domainAndUser.size == 2) {
                ParsedUserInfo(
                    username = domainAndUser[1],
                    password = password,
                    domain = domainAndUser[0].takeIf { it.isNotBlank() }
                )
            } else {
                ParsedUserInfo(username = principal, password = password, domain = null)
            }
        }
    }
}

private data class ParsedUserInfo(
    val username: String,
    val password: String,
    val domain: String?
)
package com.cxplayer.network

import com.hierynomus.msfscc.FileAttributes
import com.hierynomus.mssmb2.SMBApiException
import com.hierynomus.smbj.SMBClient
import com.hierynomus.smbj.SmbConfig
import com.hierynomus.smbj.auth.AuthenticationContext
import com.hierynomus.smbj.share.DiskShare
import java.io.IOException
import java.util.Locale
import java.util.concurrent.TimeUnit

internal data class NetworkCredentialSet(
    val host: String,
    val shareName: String,
    val username: String,
    val password: String,
    val domain: String? = null
)

internal enum class SharedLibraryEntryType {
    Directory,
    File
}

internal data class SharedLibraryEntry(
    val path: String,
    val displayName: String,
    val entryType: SharedLibraryEntryType,
    val sizeBytes: Long?,
    val lastModifiedEpochMs: Long?,
    val isPlayableCandidate: Boolean
)

internal enum class NetworkBrowseConnectionState {
    Disconnected,
    Authenticating,
    Browsing,
    Error
}

internal data class NetworkBrowseSession(
    val credentialSet: NetworkCredentialSet,
    val currentDirectoryPath: String,
    val entries: List<SharedLibraryEntry>,
    val connectionState: NetworkBrowseConnectionState,
    val errorMessage: String? = null
)

internal data class SmbRemoteEntry(
    val name: String,
    val isDirectory: Boolean,
    val sizeBytes: Long? = null,
    val lastModifiedEpochMs: Long? = null
)

internal interface SmbBrowserGateway {
    @Throws(IOException::class)
    fun list(
        credentialSet: NetworkCredentialSet,
        directoryPath: String
    ): List<SmbRemoteEntry>
}

internal class SmbBrowser(
    private val gateway: SmbBrowserGateway = SmbjBrowserGateway()
) {
    fun browse(
        credentialSet: NetworkCredentialSet,
        directoryPath: String = ""
    ): NetworkBrowseSession {
        val normalizedCredentialSet = credentialSet.normalized()
        val normalizedDirectoryPath = normalizeDirectoryPath(directoryPath)
        if (normalizedCredentialSet.host.isEmpty() || normalizedCredentialSet.shareName.isEmpty()) {
            return NetworkBrowseSession(
                credentialSet = normalizedCredentialSet,
                currentDirectoryPath = normalizedDirectoryPath,
                entries = emptyList(),
                connectionState = NetworkBrowseConnectionState.Error,
                errorMessage = "Thiếu thông tin máy chủ hoặc share SMB."
            )
        }

        return try {
            val entries = gateway.list(normalizedCredentialSet, normalizedDirectoryPath)
                .asSequence()
                .filterNot { it.name == "." || it.name == ".." }
                .map { remoteEntry ->
                    remoteEntry.toSharedLibraryEntry(normalizedDirectoryPath)
                }
                .sortedWith(compareBy<SharedLibraryEntry>({ it.entryType != SharedLibraryEntryType.Directory }, { it.displayName.lowercase(Locale.ROOT) }))
                .toList()

            NetworkBrowseSession(
                credentialSet = normalizedCredentialSet,
                currentDirectoryPath = normalizedDirectoryPath,
                entries = entries,
                connectionState = NetworkBrowseConnectionState.Browsing,
                errorMessage = null
            )
        } catch (exception: IOException) {
            NetworkBrowseSession(
                credentialSet = normalizedCredentialSet,
                currentDirectoryPath = normalizedDirectoryPath,
                entries = emptyList(),
                connectionState = NetworkBrowseConnectionState.Error,
                errorMessage = resolveFriendlyErrorMessage(exception)
            )
        }
    }

    fun buildPlaybackUri(
        credentialSet: NetworkCredentialSet,
        entry: SharedLibraryEntry
    ): String? {
        if (entry.entryType != SharedLibraryEntryType.File || !entry.isPlayableCandidate) {
            return null
        }

        val normalizedPath = entry.path.trim('/').replace('\\', '/')
        return buildString {
            append("smb://")
            append(credentialSet.host.trim())
            append('/')
            append(credentialSet.shareName.trim())
            if (normalizedPath.isNotEmpty()) {
                append('/')
                append(normalizedPath)
            }
        }
    }

    private fun resolveFriendlyErrorMessage(exception: IOException): String {
        val message = exception.message.orEmpty()
        return when {
            message.contains("ACCESS_DENIED", ignoreCase = true) ||
                message.contains("LOGON_FAILURE", ignoreCase = true) -> {
                "Xác thực SMB thất bại. Kiểm tra lại tài khoản hoặc mật khẩu."
            }

            message.contains("BAD_NETWORK_NAME", ignoreCase = true) ||
                message.contains("OBJECT_NAME_NOT_FOUND", ignoreCase = true) ||
                message.contains("PATH_NOT_FOUND", ignoreCase = true) -> {
                "Không tìm thấy share hoặc thư mục SMB đã chọn."
            }

            message.isNotBlank() -> message
            else -> "Không thể kết nối tới máy chủ SMB."
        }
    }

    private fun SmbRemoteEntry.toSharedLibraryEntry(directoryPath: String): SharedLibraryEntry {
        val normalizedName = name.trim().ifEmpty { "(unknown)" }
        val relativePath = listOf(directoryPath.takeIf { it.isNotEmpty() }, normalizedName)
            .filterNotNull()
            .joinToString("/")

        return SharedLibraryEntry(
            path = relativePath,
            displayName = normalizedName,
            entryType = if (isDirectory) SharedLibraryEntryType.Directory else SharedLibraryEntryType.File,
            sizeBytes = sizeBytes,
            lastModifiedEpochMs = lastModifiedEpochMs,
            isPlayableCandidate = !isDirectory && isPlayableVideoName(normalizedName)
        )
    }

    private fun isPlayableVideoName(fileName: String): Boolean {
        val extension = fileName.substringAfterLast('.', missingDelimiterValue = "")
            .lowercase(Locale.ROOT)
        return extension in SUPPORTED_VIDEO_EXTENSIONS
    }

    private fun normalizeDirectoryPath(directoryPath: String): String {
        return directoryPath.trim().replace('\\', '/').trim('/').takeIf { it.isNotEmpty() } ?: ""
    }

    private fun NetworkCredentialSet.normalized(): NetworkCredentialSet {
        return copy(
            host = host.trim(),
            shareName = shareName.trim(),
            username = username.trim(),
            domain = domain?.trim()?.takeIf { it.isNotEmpty() }
        )
    }

    companion object {
        private val SUPPORTED_VIDEO_EXTENSIONS = setOf("mp4", "3gp", "webm", "mkv")
    }
}

internal class SmbjBrowserGateway : SmbBrowserGateway {
    @Throws(IOException::class)
    override fun list(
        credentialSet: NetworkCredentialSet,
        directoryPath: String
    ): List<SmbRemoteEntry> {
        val config = SmbConfig.builder()
            .withTimeout(30, TimeUnit.SECONDS)
            .withSoTimeout(30, TimeUnit.SECONDS)
            .build()
        val client = SMBClient(config)

        try {
            client.connect(credentialSet.host).use { connection ->
                val session = connection.authenticate(
                    AuthenticationContext(
                        credentialSet.username,
                        credentialSet.password.toCharArray(),
                        credentialSet.domain.orEmpty()
                    )
                )
                val share = session.connectShare(credentialSet.shareName)
                if (share !is DiskShare) {
                    throw IOException("SMB share '${credentialSet.shareName}' không hỗ trợ duyệt file.")
                }

                share.use { diskShare ->
                    return diskShare.list(directoryPath.replace('/', '\\'))
                        .map { information ->
                            val isDirectory =
                                (information.fileAttributes and FileAttributes.FILE_ATTRIBUTE_DIRECTORY.value) != 0L
                            SmbRemoteEntry(
                                name = information.fileName,
                                isDirectory = isDirectory,
                                sizeBytes = information.endOfFile.takeUnless { isDirectory },
                                lastModifiedEpochMs = null
                            )
                        }
                }
            }
        } catch (exception: SMBApiException) {
            throw IOException(exception.message ?: "SMB request failed", exception)
        } catch (exception: IOException) {
            throw exception
        } catch (exception: Exception) {
            throw IOException(exception.message ?: "SMB connection failed", exception)
        } finally {
            client.close()
        }
    }
}
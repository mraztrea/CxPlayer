package com.cxplayer.ui.player

import android.content.ContentResolver
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.annotation.StringRes
import androidx.appcompat.app.AppCompatActivity
import androidx.media3.ui.PlayerView
import com.cxplayer.R
import com.cxplayer.player.CxPlayerManager
import com.cxplayer.player.PlaybackSnapshot
import java.io.File
import java.io.FileNotFoundException
import java.net.URI
import java.util.Locale

private const val STATE_PLAYBACK_INDEX = "state_playback_index"
private const val STATE_PLAYBACK_POSITION_MS = "state_playback_position_ms"
private const val STATE_PLAY_WHEN_READY = "state_play_when_ready"

class PlayerActivity : AppCompatActivity() {
    private lateinit var playerView: PlayerView
    private val playerManager by lazy(LazyThreadSafetyMode.NONE) { CxPlayerManager(this) }
    private var pendingLaunch: PendingLaunch? = null
    private var pendingSnapshot: PlaybackSnapshot? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_player)

        playerView = findViewById(R.id.playerView)
        pendingSnapshot = restoreSnapshot(savedInstanceState)
        updatePendingLaunch(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        pendingSnapshot = null
        updatePendingLaunch(intent)
        if (!isFinishing) {
            beginPlaybackSession()
        }
    }

    override fun onStart() {
        super.onStart()
        beginPlaybackSession()
    }

    override fun onSaveInstanceState(outState: Bundle) {
        captureSnapshot()
        pendingSnapshot?.let { snapshot ->
            outState.putInt(STATE_PLAYBACK_INDEX, snapshot.currentIndex)
            outState.putLong(STATE_PLAYBACK_POSITION_MS, snapshot.currentPositionMs)
            outState.putBoolean(STATE_PLAY_WHEN_READY, snapshot.playWhenReady)
        }
        super.onSaveInstanceState(outState)
    }

    override fun onStop() {
        captureSnapshot()
        playerManager.release()
        syncPlayerState()
        super.onStop()
    }

    override fun onDestroy() {
        playerManager.release()
        super.onDestroy()
    }

    fun playPlayback() {
        playerManager.play()
        syncPlayerState()
    }

    fun pausePlayback() {
        playerManager.pause()
        syncPlayerState()
    }

    fun seekToPosition(positionMs: Long) {
        playerManager.seekTo(positionMs)
        syncPlayerState()
    }

    fun seekForward() {
        playerManager.seekForward()
        syncPlayerState()
    }

    fun seekBack() {
        playerManager.seekBack()
        syncPlayerState()
    }

    internal fun currentPlaybackSnapshot(): PlaybackSnapshot? = playerManager.exportSnapshot()

    private fun updatePendingLaunch(intent: Intent?) {
        when (val outcome = PlaybackRequestParser.fromIntent(intent, contentResolver)) {
            is LaunchOutcome.Rejected -> {
                pendingLaunch = null
                showMessage(outcome.messageResId)
                finish()
            }

            is LaunchOutcome.Ready -> {
                pendingLaunch = PendingLaunch(
                    request = outcome.request,
                    messageResId = null
                )
            }

            is LaunchOutcome.FallbackSelected -> {
                pendingLaunch = PendingLaunch(
                    request = outcome.request,
                    messageResId = outcome.messageResId
                )
            }
        }
    }

    private fun beginPlaybackSession() {
        val launch = pendingLaunch ?: return
        playerManager.attach(playerView)
        playerManager.load(
            request = launch.request,
            snapshot = pendingSnapshot
        )
        launch.messageResId?.let { messageResId ->
            showMessage(messageResId)
            pendingLaunch = launch.copy(messageResId = null)
        }
        pendingSnapshot = null
        syncPlayerState()
    }

    private fun captureSnapshot() {
        pendingSnapshot = playerManager.exportSnapshot() ?: pendingSnapshot
    }

    private fun restoreSnapshot(savedInstanceState: Bundle?): PlaybackSnapshot? {
        if (savedInstanceState == null || !savedInstanceState.containsKey(STATE_PLAYBACK_INDEX)) {
            return null
        }

        return PlaybackSnapshot(
            currentIndex = savedInstanceState.getInt(STATE_PLAYBACK_INDEX),
            currentPositionMs = savedInstanceState
                .getLong(STATE_PLAYBACK_POSITION_MS)
                .coerceAtLeast(0L),
            playWhenReady = savedInstanceState.getBoolean(STATE_PLAY_WHEN_READY, true)
        )
    }

    private fun syncPlayerState() {
        if (!playerManager.currentState().hasActiveSession) {
            playerView.player = null
        }
    }

    private fun showMessage(@StringRes messageResId: Int) {
        Toast.makeText(this, messageResId, Toast.LENGTH_SHORT).show()
    }
}

private data class PendingLaunch(
    val request: PlaybackRequest,
    @param:StringRes val messageResId: Int?
)

data class PlaybackRequest(
    val sources: List<MediaSourceRef>,
    val startIndex: Int,
    val startPositionMs: Long,
    val origin: LaunchOrigin,
    val rawAction: String?
)

data class MediaSourceRef(
    val uriValue: String,
    val scheme: MediaScheme,
    val mimeType: String?,
    val isPlayableCandidate: Boolean,
    val displayLabel: String?
)

data class LaunchSourceCandidate(
    val rawValue: String,
    val mimeType: String?,
    val isAccessible: Boolean
)

data class LaunchRequestInput(
    val sources: List<LaunchSourceCandidate>,
    val startIndex: Int,
    val startPositionMs: Long,
    val origin: LaunchOrigin,
    val rawAction: String?
)

enum class LaunchOrigin {
    ExternalImplicit,
    InternalExplicit
}

enum class MediaScheme {
    Http,
    Https,
    Content,
    File;

    companion object {
        fun fromScheme(rawScheme: String?): MediaScheme? = when (rawScheme?.lowercase(Locale.ROOT)) {
            "http" -> Http
            "https" -> Https
            "content" -> Content
            "file" -> File
            else -> null
        }
    }
}

sealed class LaunchOutcome(
    open val request: PlaybackRequest?,
    open val selectedIndex: Int,
    open val effectiveStartPositionMs: Long
) {
    data class Ready(
        override val request: PlaybackRequest,
        override val selectedIndex: Int,
        override val effectiveStartPositionMs: Long
    ) : LaunchOutcome(request, selectedIndex, effectiveStartPositionMs)

    data class FallbackSelected(
        override val request: PlaybackRequest,
        override val selectedIndex: Int,
        override val effectiveStartPositionMs: Long,
        @param:StringRes val messageResId: Int
    ) : LaunchOutcome(request, selectedIndex, effectiveStartPositionMs)

    data class Rejected(@param:StringRes val messageResId: Int) : LaunchOutcome(null, 0, 0L)
}

object PlayerLaunchExtras {
    const val EXTRA_MEDIA_URIS = "extra_media_uris"
    const val EXTRA_START_INDEX = "extra_start_index"
    const val EXTRA_START_POSITION_MS = "extra_start_position_ms"
}

object PlaybackRequestParser {
    private val supportedMimeTypes = setOf(
        "video/mp4",
        "video/3gpp",
        "video/webm",
        "video/x-matroska"
    )

    private val supportedExtensions = setOf("mp4", "3gp", "webm", "mkv")

    fun fromIntent(intent: Intent?, resolver: ContentResolver?): LaunchOutcome {
        if (intent == null) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val origin = if (intent.action == Intent.ACTION_VIEW || intent.data != null) {
            LaunchOrigin.ExternalImplicit
        } else {
            LaunchOrigin.InternalExplicit
        }

        val sourceCandidates = buildSourceCandidates(intent, resolver)
        if (sourceCandidates.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val requestInput = LaunchRequestInput(
            sources = sourceCandidates,
            startIndex = intent.getIntExtra(PlayerLaunchExtras.EXTRA_START_INDEX, 0),
            startPositionMs = intent
                .getLongExtra(PlayerLaunchExtras.EXTRA_START_POSITION_MS, 0L),
            origin = origin,
            rawAction = intent.action
        )

        return fromInput(requestInput)
    }

    fun fromInput(input: LaunchRequestInput): LaunchOutcome {
        if (input.sources.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val sources = input.sources.mapNotNull { candidate ->
            buildMediaSource(candidate)
        }

        if (sources.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_unsupported_source)
        }

        val safeStartPosition = input.startPositionMs.coerceAtLeast(0L)
        val selectedIndex = input.startIndex.coerceIn(0, sources.lastIndex)
        val normalizedRequest = PlaybackRequest(
            sources = sources,
            startIndex = selectedIndex,
            startPositionMs = safeStartPosition,
            origin = input.origin,
            rawAction = input.rawAction
        )

        return if (selectedIndex == input.startIndex) {
            LaunchOutcome.Ready(
                request = normalizedRequest,
                selectedIndex = selectedIndex,
                effectiveStartPositionMs = safeStartPosition
            )
        } else {
            LaunchOutcome.FallbackSelected(
                request = normalizedRequest,
                selectedIndex = selectedIndex,
                effectiveStartPositionMs = safeStartPosition,
                messageResId = R.string.player_launch_error_invalid_index
            )
        }
    }

    private fun extractUris(intent: Intent): List<Uri> {
        val extraUris = getParcelableUris(intent)
        if (!extraUris.isNullOrEmpty()) {
            return extraUris
        }

        return listOfNotNull(intent.data)
    }

    private fun buildSourceCandidates(
        intent: Intent,
        resolver: ContentResolver?
    ): List<LaunchSourceCandidate> {
        return extractUris(intent).map { uri ->
            val normalizedUri = normalizeUri(uri)
            LaunchSourceCandidate(
                rawValue = normalizedUri.toString(),
                mimeType = resolveMimeType(normalizedUri, intent.type, resolver),
                isAccessible = canAccessSource(
                    normalizedUri,
                    MediaScheme.fromScheme(normalizedUri.scheme),
                    resolver
                )
            )
        }
    }

    private fun getParcelableUris(intent: Intent): ArrayList<Uri>? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableArrayListExtra(PlayerLaunchExtras.EXTRA_MEDIA_URIS, Uri::class.java)
        } else {
            @Suppress("DEPRECATION")
            intent.getParcelableArrayListExtra(PlayerLaunchExtras.EXTRA_MEDIA_URIS)
        }
    }

    private fun buildMediaSource(candidate: LaunchSourceCandidate): MediaSourceRef? {
        if (!candidate.isAccessible) {
            return null
        }

        val normalizedValue = normalizeUriValue(candidate.rawValue)
        val mediaScheme = MediaScheme.fromScheme(parseUri(normalizedValue)?.scheme) ?: return null
        if (!isSupportedVideo(normalizedValue, candidate.mimeType)) {
            return null
        }

        return MediaSourceRef(
            uriValue = normalizedValue,
            scheme = mediaScheme,
            mimeType = candidate.mimeType,
            isPlayableCandidate = true,
            displayLabel = normalizedValue.substringAfterLast('/')
        )
    }

    private fun normalizeUri(rawUri: Uri): Uri {
        val normalizedScheme = rawUri.scheme?.lowercase(Locale.ROOT)
        return rawUri.buildUpon().scheme(normalizedScheme).build()
    }

    private fun normalizeUriValue(rawValue: String): String {
        val parsedUri = parseUri(rawValue) ?: return rawValue
        val scheme = parsedUri.scheme?.lowercase(Locale.ROOT) ?: return rawValue
        return parsedUri.toString().replaceFirst("${parsedUri.scheme}:", "$scheme:")
    }

    private fun resolveMimeType(
        uri: Uri,
        intentMimeType: String?,
        resolver: ContentResolver?
    ): String? {
        return when {
            !intentMimeType.isNullOrBlank() -> intentMimeType.lowercase(Locale.ROOT)
            uri.scheme.equals("content", ignoreCase = true) && resolver != null -> {
                resolver.getType(uri)?.lowercase(Locale.ROOT)
            }

            else -> null
        }
    }

    private fun isSupportedVideo(uriValue: String, mimeType: String?): Boolean {
        if (mimeType != null && mimeType in supportedMimeTypes) {
            return true
        }

        val extension = uriValue.substringAfterLast('/')
            ?.substringAfterLast('.', missingDelimiterValue = "")
            ?.lowercase(Locale.ROOT)
            .orEmpty()

        return extension in supportedExtensions
    }

    private fun canAccessSource(
        uri: Uri,
        mediaScheme: MediaScheme?,
        resolver: ContentResolver?
    ): Boolean {
        if (mediaScheme == null) {
            return false
        }

        return when (mediaScheme) {
            MediaScheme.Http, MediaScheme.Https -> true
            MediaScheme.File -> uri.path?.let { File(it).exists() } == true
            MediaScheme.Content -> {
                if (resolver == null) {
                    true
                } else {
                    try {
                        resolver.openAssetFileDescriptor(uri, "r")?.close()
                        true
                    } catch (_: SecurityException) {
                        false
                    } catch (_: FileNotFoundException) {
                        false
                    }
                }
            }
        }
    }

    private fun parseUri(rawValue: String): URI? {
        return try {
            URI.create(rawValue)
        } catch (_: IllegalArgumentException) {
            null
        }
    }
}

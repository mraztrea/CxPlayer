package com.cxplayer.ui.player

import android.content.ContentResolver
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.SeekBar
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.StringRes
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.doOnLayout
import androidx.core.view.updatePadding
import androidx.media3.ui.PlayerView
import com.cxplayer.R
import com.cxplayer.databinding.ActivityPlayerBinding
import com.cxplayer.player.CxPlayerManager
import com.cxplayer.player.PlaybackSnapshot
import java.io.File
import java.io.FileNotFoundException
import java.net.URI
import java.util.Locale
import kotlin.math.min

private const val STATE_PLAYBACK_INDEX = "state_playback_index"
private const val STATE_PLAYBACK_POSITION_MS = "state_playback_position_ms"
private const val STATE_PLAY_WHEN_READY = "state_play_when_ready"

class PlayerActivity : AppCompatActivity() {
    private lateinit var binding: ActivityPlayerBinding
    private lateinit var playerView: PlayerView
    private lateinit var topChrome: ViewGroup
    private lateinit var bottomChrome: ViewGroup
    private lateinit var topRegion: ViewGroup
    private lateinit var timelineRow: ViewGroup
    private lateinit var transportRow: ViewGroup
    private lateinit var backButton: ImageButton
    private lateinit var titleView: TextView
    private lateinit var overflowButton: ImageButton
    private lateinit var currentTimeView: TextView
    private lateinit var durationView: TextView
    private lateinit var seekBar: SeekBar
    private lateinit var seekBackButton: ImageButton
    private lateinit var playPauseButton: ImageButton
    private lateinit var seekForwardButton: ImageButton
    private lateinit var volumeButton: ImageButton
    private lateinit var settingsButton: ImageButton
    private val playerManager by lazy(LazyThreadSafetyMode.NONE) { CxPlayerManager(this) }
    private var pendingLaunch: PendingLaunch? = null
    private var pendingSnapshot: PlaybackSnapshot? = null
    private var activeRequest: PlaybackRequest? = null
    private var topSystemInsetPx: Int = 0
    private var bottomSystemInsetPx: Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityPlayerBinding.inflate(layoutInflater)
        setContentView(binding.root)

        playerView = binding.playerView
        bindChromeViews()
        initializeTopChrome()
        initializeBottomChrome()
        initializeChromeLayoutBehavior()
        pendingSnapshot = restoreSnapshot(savedInstanceState)
        updatePendingLaunch(intent)
        updateTopChrome()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        clearPendingSnapshot()
        updatePendingLaunch(intent)
        updateTopChrome()
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
        if (isFinishing) {
            clearPlaybackSession(resetRequest = true)
        } else {
            playerManager.release()
            syncPlayerState()
        }
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

    internal fun hasChromeSkeleton(): Boolean =
        ::topChrome.isInitialized &&
            ::bottomChrome.isInitialized &&
            ::topRegion.isInitialized &&
            ::timelineRow.isInitialized &&
            ::transportRow.isInitialized

    private fun updatePendingLaunch(intent: Intent?) {
        when (val outcome = PlaybackRequestParser.fromIntent(intent, contentResolver)) {
            is LaunchOutcome.Rejected -> {
                pendingLaunch = null
                activeRequest = null
                showMessage(outcome.messageResId)
                finish()
            }

            is LaunchOutcome.Ready -> {
                pendingLaunch = PendingLaunch(
                    request = outcome.request,
                    messageResId = null
                )
                activeRequest = outcome.request
            }

            is LaunchOutcome.FallbackSelected -> {
                pendingLaunch = PendingLaunch(
                    request = outcome.request,
                    messageResId = outcome.messageResId
                )
                activeRequest = outcome.request
            }
        }
    }

    private fun beginPlaybackSession() {
        val launch = resolvePendingLaunchForPlayback() ?: return
        pendingLaunch = launch
        activeRequest = launch.request
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
        updateTopChrome()
    }

    private fun resolvePendingLaunchForPlayback(): PendingLaunch? {
        val launch = pendingLaunch ?: return null
        val snapshot = pendingSnapshot ?: return launch

        return when (val outcome = PlaybackRequestParser.revalidateRequest(launch.request, contentResolver)) {
            is LaunchOutcome.Ready -> launch.copy(request = outcome.request)

            is LaunchOutcome.FallbackSelected -> launch.copy(
                request = outcome.request,
                messageResId = launch.messageResId ?: R.string.player_launch_error_restore_failed
            )

            is LaunchOutcome.Rejected -> {
                handleRestoreFailure(snapshot)
                null
            }
        }
    }

    private fun captureSnapshot() {
        pendingSnapshot = playerManager.exportSnapshot() ?: pendingSnapshot
    }

    private fun handleRestoreFailure(snapshot: PlaybackSnapshot) {
        clearPlaybackSession(resetRequest = true)
        showMessage(R.string.player_launch_error_restore_failed)
        currentTimeView.text = formatPlaybackTime(snapshot.currentPositionMs)
        durationView.text = getString(R.string.player_time_placeholder)
        updateTopChrome()
    }

    private fun clearPendingSnapshot() {
        pendingSnapshot = null
    }

    private fun clearPlaybackSession(resetRequest: Boolean) {
        clearPendingSnapshot()
        if (resetRequest) {
            pendingLaunch = null
            activeRequest = null
        }
        playerManager.release()
        syncPlayerState()
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

    private fun bindChromeViews() {
        topChrome = binding.playerTopChrome
        bottomChrome = binding.playerBottomChrome
        topRegion = binding.playerTopRegion
        timelineRow = binding.playerTimelineRow
        transportRow = binding.playerTransportRow
        backButton = binding.playerBackButton
        titleView = binding.playerTitleView
        overflowButton = binding.playerOverflowButton
        currentTimeView = binding.playerCurrentTimeView
        durationView = binding.playerDurationView
        seekBar = binding.playerSeekBar
        seekBackButton = binding.playerSeekBackButton
        playPauseButton = binding.playerPlayPauseButton
        seekForwardButton = binding.playerSeekForwardButton
        volumeButton = binding.playerVolumeButton
        settingsButton = binding.playerSettingsButton
    }

    private fun initializeTopChrome() {
        titleView.text = getString(R.string.player_title_fallback)
        backButton.setOnClickListener {
            onBackPressedDispatcher.onBackPressed()
        }
        overflowButton.setOnClickListener {
            showMessage(R.string.player_control_not_available_yet)
        }
    }

    private fun initializeBottomChrome() {
        currentTimeView.text = getString(R.string.player_time_placeholder)
        durationView.text = getString(R.string.player_time_placeholder)
        seekBar.max = 1000
        seekBar.progress = 0
        seekBar.isEnabled = false
        seekBar.setOnSeekBarChangeListener(
            object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                    if (!fromUser) {
                        return
                    }

                    currentTimeView.text = formatPlaybackTime(progress.toLong())
                }

                override fun onStartTrackingTouch(seekBar: SeekBar?) = Unit

                override fun onStopTrackingTouch(seekBar: SeekBar?) {
                    val targetPosition = seekBar?.progress?.toLong() ?: return
                    seekToPosition(targetPosition)
                }
            }
        )
        seekBackButton.setOnClickListener { seekBack() }
        playPauseButton.setOnClickListener {
            val currentState = playerManager.currentState()
            if (currentState.hasActiveSession && currentState.playWhenReady) {
                pausePlayback()
            } else {
                playPlayback()
            }
        }
        seekForwardButton.setOnClickListener { seekForward() }
        volumeButton.setOnClickListener {
            showMessage(R.string.player_control_not_available_yet)
        }
        settingsButton.setOnClickListener {
            showMessage(R.string.player_control_not_available_yet)
        }
        updateBottomChrome()
    }

    private fun initializeChromeLayoutBehavior() {
        ViewCompat.setOnApplyWindowInsetsListener(binding.playerRoot) { _, windowInsets ->
            val systemBarsInsets = windowInsets.getInsets(WindowInsetsCompat.Type.systemBars())
            topSystemInsetPx = systemBarsInsets.top
            bottomSystemInsetPx = systemBarsInsets.bottom
            renderChromeLayout(binding.playerRoot.height)
            windowInsets
        }
        binding.playerRoot.doOnLayout { root ->
            renderChromeLayout(root.height)
        }
        ViewCompat.requestApplyInsets(binding.playerRoot)
    }

    private fun updateBottomChrome() {
        val state = playerManager.currentState()
        currentTimeView.text = if (state.hasActiveSession) {
            formatPlaybackTime(state.currentPositionMs)
        } else {
            getString(R.string.player_time_placeholder)
        }
        durationView.text = if (state.durationMs > 0L) {
            formatPlaybackTime(state.durationMs)
        } else {
            getString(R.string.player_time_placeholder)
        }
        seekBar.isEnabled = state.hasActiveSession && state.durationMs > 0L
        seekBar.max = if (state.durationMs > 0L) {
            min(state.durationMs, Int.MAX_VALUE.toLong()).toInt()
        } else {
            1000
        }
        seekBar.progress = min(state.currentPositionMs, seekBar.max.toLong()).toInt()
        val iconRes = if (state.hasActiveSession && state.playWhenReady) {
            R.drawable.ic_player_pause
        } else {
            R.drawable.ic_player_play
        }
        val descriptionRes = if (state.hasActiveSession && state.playWhenReady) {
            R.string.player_pause_content_description
        } else {
            R.string.player_play_content_description
        }
        playPauseButton.setImageResource(iconRes)
        playPauseButton.contentDescription = getString(descriptionRes)
    }

    private fun updateTopChrome() {
        titleView.text = resolveActiveTitle()
    }

    private fun renderChromeLayout(rootHeight: Int) {
        if (rootHeight <= 0) {
            return
        }

        val compactChrome = rootHeight - topSystemInsetPx - bottomSystemInsetPx <
            resources.getDimensionPixelSize(R.dimen.player_compact_height_threshold)
        val horizontalPadding = resources.getDimensionPixelSize(R.dimen.player_chrome_horizontal_padding)
        val topVerticalPadding = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_chrome_compact_vertical_padding
            } else {
                R.dimen.player_top_chrome_vertical_padding
            }
        )
        val bottomTopPadding = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_chrome_compact_vertical_padding
            } else {
                R.dimen.player_bottom_chrome_top_padding
            }
        )
        val bottomBottomPadding = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_chrome_compact_bottom_padding
            } else {
                R.dimen.player_bottom_chrome_bottom_padding
            }
        )
        val transportRowTopMargin = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_transport_row_margin_top_compact
            } else {
                R.dimen.player_transport_row_margin_top
            }
        )

        topChrome.updatePadding(
            left = horizontalPadding,
            top = topVerticalPadding + topSystemInsetPx,
            right = horizontalPadding,
            bottom = bottomTopPadding
        )
        bottomChrome.updatePadding(
            left = horizontalPadding,
            top = bottomTopPadding,
            right = horizontalPadding,
            bottom = bottomBottomPadding + bottomSystemInsetPx
        )
        (transportRow.layoutParams as? ViewGroup.MarginLayoutParams)?.let { layoutParams ->
            if (layoutParams.topMargin != transportRowTopMargin) {
                layoutParams.topMargin = transportRowTopMargin
                transportRow.layoutParams = layoutParams
            }
        }
    }

    private fun formatPlaybackTime(positionMs: Long): String {
        val totalSeconds = positionMs.coerceAtLeast(0L) / 1_000L
        val seconds = totalSeconds % 60L
        val minutes = (totalSeconds / 60L) % 60L
        val hours = totalSeconds / 3_600L
        return if (hours > 0L) {
            String.format(Locale.ROOT, "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            String.format(Locale.ROOT, "%02d:%02d", minutes, seconds)
        }
    }

    private fun resolveActiveTitle(): String {
        val request = activeRequest ?: pendingLaunch?.request
        val source = request
            ?.sources
            ?.getOrNull(playerManager.currentState().currentIndex.coerceAtLeast(0))

        return source?.displayLabel
            ?.takeIf { it.isNotBlank() }
            ?: source?.uriValue?.let(::deriveTitleFromUri)
            ?: getString(R.string.player_title_fallback)
    }

    private fun deriveTitleFromUri(uriValue: String): String? {
        val uri = Uri.parse(uriValue)
        val lastSegment = uri.lastPathSegment
            ?.substringAfterLast('/')
            ?.takeIf { it.isNotBlank() }
        if (lastSegment != null) {
            return lastSegment
        }

        return uri.host?.takeIf { it.isNotBlank() }
    }

    private fun syncPlayerState() {
        if (!playerManager.currentState().hasActiveSession) {
            playerView.player = null
        }
        updateBottomChrome()
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

    fun revalidateRequest(
        request: PlaybackRequest,
        resolver: ContentResolver?
    ): LaunchOutcome {
        if (request.sources.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val sourceCandidates = request.sources.map { source ->
            val normalizedValue = normalizeUriValue(source.uriValue)
            LaunchSourceCandidate(
                rawValue = normalizedValue,
                mimeType = source.mimeType?.lowercase(Locale.ROOT),
                isAccessible = canAccessSource(normalizedValue, source.scheme, resolver)
            )
        }

        return fromInput(
            LaunchRequestInput(
                sources = sourceCandidates,
                startIndex = request.startIndex,
                startPositionMs = request.startPositionMs,
                origin = request.origin,
                rawAction = request.rawAction
            )
        )
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

    private fun canAccessSource(
        uriValue: String,
        mediaScheme: MediaScheme,
        resolver: ContentResolver?
    ): Boolean {
        return when (mediaScheme) {
            MediaScheme.Http, MediaScheme.Https -> true
            MediaScheme.File -> parseUri(uriValue)?.path?.let { File(it).exists() } == true
            MediaScheme.Content -> {
                if (resolver == null) {
                    true
                } else {
                    val parsedUri = Uri.parse(uriValue)
                    try {
                        resolver.openAssetFileDescriptor(parsedUri, "r")?.close()
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

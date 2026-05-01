package com.cxplayer.player

import android.content.Context
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.PlaybackParameters
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.ui.PlayerView
import com.cxplayer.ui.player.MediaScheme
import com.cxplayer.ui.player.MediaSourceRef
import com.cxplayer.ui.player.PlaybackRequest

private const val TRANSPORT_SEEK_INCREMENT_MS = 10_000L
private const val DEFAULT_PLAYBACK_SPEED = 1f
private const val MIN_PLAYBACK_SPEED = 0.25f
private const val MAX_PLAYBACK_SPEED = 2f

internal data class PlayerSessionConfigurationSnapshot(
    val seekBackIncrementMs: Long,
    val seekForwardIncrementMs: Long,
    val renderersFactoryClassName: String,
    val mediaSourceFactoryClassName: String,
    val loadControlPolicy: CxLoadControlPolicySnapshot
)

internal fun playerSessionConfigurationSnapshot(): PlayerSessionConfigurationSnapshot {
    return PlayerSessionConfigurationSnapshot(
        seekBackIncrementMs = TRANSPORT_SEEK_INCREMENT_MS,
        seekForwardIncrementMs = TRANSPORT_SEEK_INCREMENT_MS,
        renderersFactoryClassName = CxRenderersFactory::class.java.name,
        mediaSourceFactoryClassName = CxMediaSourceFactory::class.java.name,
        loadControlPolicy = cxLoadControlPolicySnapshot()
    )
}

internal fun requiresNetworkWakeMode(scheme: MediaScheme): Boolean {
    return when (scheme) {
        MediaScheme.Http,
        MediaScheme.Https,
        MediaScheme.Smb -> true

        MediaScheme.Content,
        MediaScheme.File -> false
    }
}

internal fun resolveWakeModeForSource(source: MediaSourceRef?): Int {
    return if (source != null && requiresNetworkWakeMode(source.scheme)) {
        C.WAKE_MODE_NETWORK
    } else {
        C.WAKE_MODE_LOCAL
    }
}

class CxPlayerManager internal constructor(
    private val sessionFactory: PlayerSessionFactory
) {
    private var attachedPlayerView: PlayerView? = null
    private var session: PlayerSession? = null
    private var playlistSize: Int = 0
    private var latestState = PlaybackStateSnapshot()

    constructor(context: Context) : this(ExoPlayerSessionFactory(context))

    fun attach(playerView: PlayerView) {
        attachedPlayerView?.takeIf { it !== playerView }?.player = null
        attachedPlayerView = playerView
        session?.let { currentSession ->
            playerView.player = currentSession.player
        }
    }

    fun detach() {
        attachedPlayerView?.player = null
        attachedPlayerView = null
    }

    fun load(
        request: PlaybackRequest,
        playWhenReady: Boolean = true,
        snapshot: PlaybackSnapshot? = null
    ): PlaybackStateSnapshot {
        if (request.sources.isEmpty()) {
            return currentState()
        }

        val currentSession = ensureSession()
        val sourceUris = request.sources.map { it.uriValue }
        val safeRequestIndex = request.startIndex.coerceIn(0, sourceUris.lastIndex)
        val safeRequestPosition = normalizePosition(request.startPositionMs)
        val effectiveSnapshot = snapshot?.takeIf { it.currentIndex in sourceUris.indices }
        val targetIndex = effectiveSnapshot?.currentIndex ?: safeRequestIndex
        val targetPosition = effectiveSnapshot?.currentPositionMs?.let(::normalizePosition)
            ?: safeRequestPosition

        playlistSize = sourceUris.size
        bindAttachedView(currentSession)
        currentSession.setWakeMode(resolveWakeModeForSource(request.sources.getOrNull(targetIndex)))
        currentSession.setMediaItems(sourceUris, targetIndex, targetPosition)
        currentSession.playbackSpeed = DEFAULT_PLAYBACK_SPEED
        currentSession.prepare()
        currentSession.playWhenReady = effectiveSnapshot?.playWhenReady ?: playWhenReady

        return refreshState()
    }

    fun exportSnapshot(): PlaybackSnapshot? {
        val currentSession = session ?: return null
        if (playlistSize == 0) {
            return null
        }

        return PlaybackSnapshot(
            currentIndex = currentSession.currentMediaItemIndex.coerceIn(0, playlistSize - 1),
            currentPositionMs = normalizePosition(currentSession.currentPositionMs),
            playWhenReady = currentSession.playWhenReady
        )
    }

    fun currentState(): PlaybackStateSnapshot {
        return session?.let { refreshState() } ?: latestState
    }

    fun play() {
        session?.let { currentSession ->
            currentSession.playWhenReady = true
            refreshState()
        }
    }

    fun pause() {
        session?.let { currentSession ->
            currentSession.playWhenReady = false
            refreshState()
        }
    }

    fun seekTo(positionMs: Long) {
        session?.let { currentSession ->
            val targetIndex = currentSession.currentMediaItemIndex.coerceAtLeast(0)
            currentSession.seekTo(targetIndex, clampPosition(positionMs, currentSession.durationMs))
            refreshState()
        }
    }

    fun seekForward() {
        session?.let { currentSession ->
            seekTo(currentSession.currentPositionMs + TRANSPORT_SEEK_INCREMENT_MS)
        }
    }

    fun seekBack() {
        session?.let { currentSession ->
            seekTo(currentSession.currentPositionMs - TRANSPORT_SEEK_INCREMENT_MS)
        }
    }

    fun setPlaybackSpeed(speed: Float) {
        session?.let { currentSession ->
            currentSession.playbackSpeed = speed.coerceIn(MIN_PLAYBACK_SPEED, MAX_PLAYBACK_SPEED)
            refreshState()
        }
    }

    fun resetPlaybackSpeed() {
        setPlaybackSpeed(DEFAULT_PLAYBACK_SPEED)
    }

    fun release() {
        detach()
        session?.release()
        session = null
        playlistSize = 0
        latestState = PlaybackStateSnapshot(sessionState = PlaybackSessionState.Released)
    }

    internal fun activePlayer(): Player? = session?.player

    internal fun subtitleSessionController(): SubtitleSessionController? {
        return activePlayer()?.let(::PlayerSubtitleSessionController)
    }

    internal fun trackSelectorSessionController(): TrackSelectorSessionController? {
        return activePlayer()?.let(::PlayerTrackSelectorSessionController)
    }

    private fun ensureSession(): PlayerSession {
        return session ?: sessionFactory.create().also { createdSession ->
            session = createdSession
            latestState = PlaybackStateSnapshot(
                sessionState = PlaybackSessionState.Initialized,
                hasActiveSession = true,
                playWhenReady = createdSession.playWhenReady
            )
        }
    }

    private fun bindAttachedView(currentSession: PlayerSession) {
        attachedPlayerView?.player = currentSession.player
    }

    private fun refreshState(): PlaybackStateSnapshot {
        val currentSession = session ?: return latestState
        val maxIndex = (playlistSize - 1).coerceAtLeast(0)
        latestState = PlaybackStateSnapshot(
            sessionState = resolveSessionState(currentSession),
            currentIndex = currentSession.currentMediaItemIndex.coerceIn(0, maxIndex),
            currentPositionMs = clampPosition(currentSession.currentPositionMs, currentSession.durationMs),
            durationMs = normalizeDuration(currentSession.durationMs),
            playbackSpeed = currentSession.playbackSpeed,
            playWhenReady = currentSession.playWhenReady,
            hasActiveSession = true
        )
        return latestState
    }

    private fun resolveSessionState(currentSession: PlayerSession): PlaybackSessionState {
        return when {
            currentSession.hasError -> PlaybackSessionState.Error
            currentSession.playbackState == Player.STATE_ENDED -> PlaybackSessionState.Ended
            currentSession.playbackState == Player.STATE_READY && currentSession.playWhenReady -> {
                PlaybackSessionState.Playing
            }

            currentSession.playbackState == Player.STATE_READY -> PlaybackSessionState.Paused
            currentSession.playbackState == Player.STATE_BUFFERING -> PlaybackSessionState.Prepared
            else -> PlaybackSessionState.Initialized
        }
    }

    private fun normalizePosition(positionMs: Long): Long = positionMs.coerceAtLeast(0L)

    private fun clampPosition(positionMs: Long, durationMs: Long): Long {
        val normalizedPosition = normalizePosition(positionMs)
        val normalizedDuration = normalizeDuration(durationMs)
        return if (normalizedDuration == 0L) {
            normalizedPosition
        } else {
            normalizedPosition.coerceAtMost(normalizedDuration)
        }
    }

    private fun normalizeDuration(durationMs: Long): Long {
        return if (durationMs == C.TIME_UNSET || durationMs < 0L) 0L else durationMs
    }
}

data class PlaybackSnapshot(
    val currentIndex: Int,
    val currentPositionMs: Long,
    val playWhenReady: Boolean
)

data class PlaybackStateSnapshot(
    val sessionState: PlaybackSessionState = PlaybackSessionState.Idle,
    val currentIndex: Int = 0,
    val currentPositionMs: Long = 0L,
    val durationMs: Long = 0L,
    val playbackSpeed: Float = DEFAULT_PLAYBACK_SPEED,
    val playWhenReady: Boolean = false,
    val hasActiveSession: Boolean = false
)

enum class PlaybackSessionState {
    Idle,
    Initialized,
    Prepared,
    Playing,
    Paused,
    Ended,
    Error,
    Released
}

internal interface PlayerSessionFactory {
    fun create(): PlayerSession
}

internal interface PlayerSession {
    val player: Player?
    var playWhenReady: Boolean
    var playbackSpeed: Float
    val currentPositionMs: Long
    val currentMediaItemIndex: Int
    val durationMs: Long
    val playbackState: Int
    val hasError: Boolean

    fun setWakeMode(wakeMode: Int)

    fun setMediaItems(sourceUris: List<String>, startIndex: Int, startPositionMs: Long)

    fun prepare()

    fun seekTo(mediaItemIndex: Int, positionMs: Long)

    fun release()
}

private class ExoPlayerSessionFactory(
    private val context: Context
) : PlayerSessionFactory {
    override fun create(): PlayerSession {
        val configuration = playerSessionConfigurationSnapshot()
        val renderersFactory = CxRenderersFactory(context)
        val mediaSourceFactory = CxMediaSourceFactory(context).create()
        val exoPlayer = ExoPlayer.Builder(context)
            .setRenderersFactory(renderersFactory)
            .setMediaSourceFactory(mediaSourceFactory)
            .setLoadControl(buildCxLoadControl())
            .setWakeMode(C.WAKE_MODE_LOCAL)
            .setSeekBackIncrementMs(configuration.seekBackIncrementMs)
            .setSeekForwardIncrementMs(configuration.seekForwardIncrementMs)
            .build()
        return ExoPlayerSession(exoPlayer)
    }
}

private class ExoPlayerSession(
    private val exoPlayer: ExoPlayer
) : PlayerSession {
    override val player: Player
        get() = exoPlayer

    override var playWhenReady: Boolean
        get() = exoPlayer.playWhenReady
        set(value) {
            exoPlayer.playWhenReady = value
        }

    override var playbackSpeed: Float
        get() = exoPlayer.playbackParameters.speed
        set(value) {
            exoPlayer.playbackParameters = PlaybackParameters(value)
        }

    override val currentPositionMs: Long
        get() = exoPlayer.currentPosition.coerceAtLeast(0L)

    override val currentMediaItemIndex: Int
        get() = exoPlayer.currentMediaItemIndex.coerceAtLeast(0)

    override val durationMs: Long
        get() = exoPlayer.duration

    override val playbackState: Int
        get() = exoPlayer.playbackState

    override val hasError: Boolean
        get() = exoPlayer.playerError != null

    override fun setWakeMode(wakeMode: Int) {
        exoPlayer.setWakeMode(wakeMode)
    }

    override fun setMediaItems(sourceUris: List<String>, startIndex: Int, startPositionMs: Long) {
        val mediaItems = sourceUris.map { MediaItem.fromUri(it) }
        exoPlayer.setMediaItems(mediaItems, startIndex, startPositionMs)
    }

    override fun prepare() {
        exoPlayer.prepare()
    }

    override fun seekTo(mediaItemIndex: Int, positionMs: Long) {
        exoPlayer.seekTo(mediaItemIndex, positionMs)
    }

    override fun release() {
        exoPlayer.release()
    }
}
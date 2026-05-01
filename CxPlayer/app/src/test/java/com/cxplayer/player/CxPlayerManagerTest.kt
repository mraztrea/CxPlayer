package com.cxplayer.player

import androidx.media3.common.C
import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.common.Player
import com.cxplayer.ui.player.LaunchOrigin
import com.cxplayer.ui.player.MediaScheme
import com.cxplayer.ui.player.MediaSourceRef
import com.cxplayer.ui.player.PlaybackRequest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.lang.reflect.Proxy

class CxPlayerManagerTest {
    @Test
    fun `renderer policy prefers extensions and enables decoder fallback`() {
        val policy = cxRendererPolicySnapshot()

        assertEquals(
            DefaultRenderersFactory.EXTENSION_RENDERER_MODE_PREFER,
            policy.extensionRendererMode
        )
        assertTrue(policy.decoderFallbackEnabled)
    }

    @Test
    fun `player session configuration keeps transport increments and custom renderer factory`() {
        val configuration = playerSessionConfigurationSnapshot()

        assertEquals(10_000L, configuration.seekBackIncrementMs)
        assertEquals(10_000L, configuration.seekForwardIncrementMs)
        assertEquals(CxRenderersFactory::class.java.name, configuration.renderersFactoryClassName)
        assertEquals(CxMediaSourceFactory::class.java.name, configuration.mediaSourceFactoryClassName)
        assertEquals(50_000, configuration.loadControlPolicy.minBufferMs)
        assertEquals(120_000, configuration.loadControlPolicy.maxBufferMs)
    }

    @Test
    fun `wake mode resolves to network for remote playback schemes`() {
        val smbScheme = MediaScheme.fromScheme("smb") ?: error("Expected smb scheme to resolve")

        assertEquals(C.WAKE_MODE_NETWORK, resolveWakeModeForSource(buildSource("https://example.com/alpha.mp4", MediaScheme.Https)))
        assertEquals(C.WAKE_MODE_NETWORK, resolveWakeModeForSource(buildSource("smb://server/share/movie.mkv", smbScheme)))
    }

    @Test
    fun `wake mode resolves to local for file playback schemes`() {
        assertEquals(C.WAKE_MODE_LOCAL, resolveWakeModeForSource(buildSource("file:///storage/emulated/0/Movies/movie.mp4", MediaScheme.File)))
        assertEquals(C.WAKE_MODE_LOCAL, resolveWakeModeForSource(buildSource("content://media/external/video/media/1", MediaScheme.Content)))
    }

    @Test
    fun `ffmpeg renderer module is available on the app classpath`() {
        val rendererClass = Class.forName("androidx.media3.decoder.ffmpeg.FfmpegAudioRenderer")

        assertEquals("androidx.media3.decoder.ffmpeg.FfmpegAudioRenderer", rendererClass.name)
    }

    @Test
    fun `load creates a single session until release`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L))
        manager.load(buildRequest(startIndex = 1, startPositionMs = 2_000L))

        assertEquals(1, factory.createdSessions.size)

        manager.release()
        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L))

        assertEquals(2, factory.createdSessions.size)
    }

    @Test
    fun `load prepares playlist from request and enables autoplay`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        val state = manager.load(buildRequest(startIndex = 1, startPositionMs = 1_500L))
        val session = factory.lastSession()

        assertTrue(session.prepared)
        assertEquals(2, session.lastSourceUris.size)
        assertEquals("https://example.com/alpha.mp4", session.lastSourceUris.first())
        assertEquals(1, session.lastStartIndex)
        assertEquals(1_500L, session.lastStartPositionMs)
        assertTrue(session.playWhenReady)
        assertEquals(C.WAKE_MODE_NETWORK, session.lastWakeMode)
        assertEquals(PlaybackSessionState.Playing, state.sessionState)
        assertEquals(1, state.currentIndex)
    }

    @Test
    fun `load applies local wake mode for local media`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L, sources = listOf(buildSource("file:///storage/emulated/0/Movies/local.mp4", MediaScheme.File))))

        assertEquals(C.WAKE_MODE_LOCAL, factory.lastSession().lastWakeMode)
    }

    @Test
    fun `exportSnapshot captures current item position and playback intent`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L))
        val session = factory.lastSession()
        session.currentMediaItemIndexValue = 1
        session.currentPositionMsValue = 24_000L
        session.playWhenReady = false

        val snapshot = manager.exportSnapshot()

        assertNotNull(snapshot)
        assertEquals(1, snapshot?.currentIndex)
        assertEquals(24_000L, snapshot?.currentPositionMs)
        assertFalse(snapshot?.playWhenReady ?: true)
    }

    @Test
    fun `load restores snapshot over request defaults`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        val state = manager.load(
            request = buildRequest(startIndex = 0, startPositionMs = 500L),
            snapshot = PlaybackSnapshot(
                currentIndex = 1,
                currentPositionMs = 9_500L,
                playWhenReady = false
            )
        )
        val session = factory.lastSession()

        assertEquals(1, session.lastStartIndex)
        assertEquals(9_500L, session.lastStartPositionMs)
        assertFalse(session.playWhenReady)
        assertEquals(PlaybackSessionState.Paused, state.sessionState)
        assertEquals(1, state.currentIndex)
    }

    @Test
    fun `transport controls update playback intent and clamp positions`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        manager.load(buildRequest(startIndex = 0, startPositionMs = 4_000L))
        val session = factory.lastSession()
        session.durationMsValue = 15_000L
        session.currentPositionMsValue = 4_000L

        manager.pause()
        assertFalse(session.playWhenReady)

        manager.play()
        assertTrue(session.playWhenReady)

        manager.seekBack()
        assertEquals(0L, session.currentPositionMsValue)

        session.currentPositionMsValue = 8_000L
        manager.seekForward()
        assertEquals(15_000L, session.currentPositionMsValue)

        manager.seekTo(-500L)
        assertEquals(0L, session.currentPositionMsValue)
    }

    @Test
    fun `temporary playback speed helpers update active session and reset to normal`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L))
        val session = factory.lastSession()

        manager.setPlaybackSpeed(2f)
        assertEquals(2f, session.playbackSpeed, 0f)
        assertEquals(2f, manager.currentState().playbackSpeed, 0f)

        manager.resetPlaybackSpeed()
        assertEquals(1f, session.playbackSpeed, 0f)
        assertEquals(1f, manager.currentState().playbackSpeed, 0f)
    }

    @Test
    fun `error state is surfaced and next load can reuse the same session`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L))
        val session = factory.lastSession()
        session.hasError = true

        val failedState = manager.currentState()
        assertEquals(PlaybackSessionState.Error, failedState.sessionState)

        session.hasError = false
        val recoveredState = manager.load(buildRequest(startIndex = 1, startPositionMs = 3_000L))

        assertEquals(1, factory.createdSessions.size)
        assertEquals(PlaybackSessionState.Playing, recoveredState.sessionState)
        assertEquals(1, recoveredState.currentIndex)
        assertEquals(3_000L, session.lastStartPositionMs)
    }

    @Test
    fun `subtitle session controller is available for active playback and cleared on release`() {
        val factory = FakePlayerSessionFactory()
        val manager = CxPlayerManager(factory)

        assertNull(manager.subtitleSessionController())

        manager.load(buildRequest(startIndex = 0, startPositionMs = 0L))

        assertNotNull(manager.activePlayer())
        assertNotNull(manager.subtitleSessionController())

        manager.release()

        assertNull(manager.activePlayer())
        assertNull(manager.subtitleSessionController())
    }

    private fun buildRequest(
        startIndex: Int,
        startPositionMs: Long,
        sources: List<MediaSourceRef> = listOf(
            buildSource("https://example.com/alpha.mp4", MediaScheme.Https, "video/mp4", "alpha"),
            buildSource("https://example.com/beta.webm", MediaScheme.Https, "video/webm", "beta")
        )
    ): PlaybackRequest {
        return PlaybackRequest(
            sources = sources,
            startIndex = startIndex,
            startPositionMs = startPositionMs,
            origin = LaunchOrigin.InternalExplicit,
            rawAction = null
        )
    }

    private fun buildSource(
        uriValue: String,
        scheme: MediaScheme,
        mimeType: String? = "video/mp4",
        displayLabel: String? = uriValue.substringAfterLast('/')
    ): MediaSourceRef {
        return MediaSourceRef(
            uriValue = uriValue,
            scheme = scheme,
            mimeType = mimeType,
            isPlayableCandidate = true,
            displayLabel = displayLabel
        )
    }
}

private class FakePlayerSessionFactory : PlayerSessionFactory {
    val createdSessions = mutableListOf<FakePlayerSession>()

    override fun create(): PlayerSession {
        return FakePlayerSession().also(createdSessions::add)
    }

    fun lastSession(): FakePlayerSession = createdSessions.last()
}

private class FakePlayerSession : PlayerSession {
    override val player: Player = fakePlayerProxy()

    override var playWhenReady: Boolean = false
    override var playbackSpeed: Float = 1f
    override var shuffleModeEnabled: Boolean = false
    override var repeatMode: Int = Player.REPEAT_MODE_OFF
    var currentPositionMsValue: Long = 0L
    var currentMediaItemIndexValue: Int = 0
    var durationMsValue: Long = 120_000L
    override var playbackState: Int = Player.STATE_IDLE
    override var hasError: Boolean = false

    var prepared: Boolean = false
    var released: Boolean = false
    var lastSourceUris: List<String> = emptyList()
    var lastStartIndex: Int = 0
    var lastStartPositionMs: Long = 0L
    var lastWakeMode: Int = C.WAKE_MODE_LOCAL

    override val currentPositionMs: Long
        get() = currentPositionMsValue

    override val currentMediaItemIndex: Int
        get() = currentMediaItemIndexValue

    override val durationMs: Long
        get() = durationMsValue

    override val hasNextMediaItem: Boolean
        get() = currentMediaItemIndexValue < lastSourceUris.size - 1

    override val hasPreviousMediaItem: Boolean
        get() = currentMediaItemIndexValue > 0

    override fun setWakeMode(wakeMode: Int) {
        lastWakeMode = wakeMode
    }

    override fun setMediaItems(sourceUris: List<String>, startIndex: Int, startPositionMs: Long) {
        lastSourceUris = sourceUris
        lastStartIndex = startIndex
        lastStartPositionMs = startPositionMs
        currentMediaItemIndexValue = startIndex
        currentPositionMsValue = startPositionMs
        playbackState = Player.STATE_IDLE
    }

    override fun prepare() {
        prepared = true
        playbackState = Player.STATE_READY
    }

    override fun seekTo(mediaItemIndex: Int, positionMs: Long) {
        currentMediaItemIndexValue = mediaItemIndex
        currentPositionMsValue = positionMs.coerceAtMost(durationMsValue)
    }

    override fun seekToNextMediaItem() {
        if (hasNextMediaItem) {
            currentMediaItemIndexValue++
            currentPositionMsValue = 0L
        }
    }

    override fun seekToPreviousMediaItem() {
        if (hasPreviousMediaItem) {
            currentMediaItemIndexValue--
            currentPositionMsValue = 0L
        }
    }

    override fun release() {
        released = true
        playbackState = Player.STATE_IDLE
    }
}

@Suppress("UNCHECKED_CAST")
private fun fakePlayerProxy(): Player {
    return Proxy.newProxyInstance(
        Player::class.java.classLoader,
        arrayOf(Player::class.java)
    ) { _, method, _ ->
        when (method.returnType) {
            java.lang.Boolean.TYPE -> false
            java.lang.Integer.TYPE -> 0
            java.lang.Long.TYPE -> 0L
            java.lang.Float.TYPE -> 0f
            else -> null
        }
    } as Player
}
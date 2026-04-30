package com.cxplayer.player

import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.common.Player
import com.cxplayer.ui.player.LaunchOrigin
import com.cxplayer.ui.player.MediaScheme
import com.cxplayer.ui.player.MediaSourceRef
import com.cxplayer.ui.player.PlaybackRequest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test

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
        assertEquals(PlaybackSessionState.Playing, state.sessionState)
        assertEquals(1, state.currentIndex)
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

    private fun buildRequest(startIndex: Int, startPositionMs: Long): PlaybackRequest {
        return PlaybackRequest(
            sources = listOf(
                MediaSourceRef(
                    uriValue = "https://example.com/alpha.mp4",
                    scheme = MediaScheme.Https,
                    mimeType = "video/mp4",
                    isPlayableCandidate = true,
                    displayLabel = "alpha"
                ),
                MediaSourceRef(
                    uriValue = "https://example.com/beta.webm",
                    scheme = MediaScheme.Https,
                    mimeType = "video/webm",
                    isPlayableCandidate = true,
                    displayLabel = "beta"
                )
            ),
            startIndex = startIndex,
            startPositionMs = startPositionMs,
            origin = LaunchOrigin.InternalExplicit,
            rawAction = null
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
    override val player: Player? = null

    override var playWhenReady: Boolean = false
    override var playbackSpeed: Float = 1f
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

    override val currentPositionMs: Long
        get() = currentPositionMsValue

    override val currentMediaItemIndex: Int
        get() = currentMediaItemIndexValue

    override val durationMs: Long
        get() = durationMsValue

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

    override fun release() {
        released = true
        playbackState = Player.STATE_IDLE
    }
}
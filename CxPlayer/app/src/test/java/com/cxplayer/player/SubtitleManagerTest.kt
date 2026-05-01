package com.cxplayer.player

import android.graphics.Color
import androidx.media3.common.MediaItem
import androidx.media3.ui.CaptionStyleCompat
import org.junit.Assert.assertFalse
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.File
import kotlin.io.path.createTempDirectory

class SubtitleManagerTest {
    @Test
    fun `available subtitle sources expose off placeholder by default`() {
        val manager = SubtitleManager(FakeSubtitleSessionController())

        val sources = manager.availableSubtitleSources()

        assertEquals(1, sources.size)
        assertEquals(SubtitleSourceKind.Off, sources.first().kind)
        assertTrue(sources.first().isCurrentlySelected)
    }

    @Test
    fun `cycle style preset updates runtime subtitle style state`() {
        val manager = SubtitleManager(FakeSubtitleSessionController())

        val updatedStyle = manager.cycleStylePreset()

        assertTrue(updatedStyle.fontSizeSp >= 18)
        assertEquals(updatedStyle, manager.currentStyleState())
    }

    @Test
    fun `auto detect returns unsupported for remote media uri`() {
        val manager = SubtitleManager(FakeSubtitleSessionController())

        val result = manager.detectExternalSubtitle(
            videoPath = "/video.mp4",
            scheme = "https"
        )

        assertEquals(SubtitleDetectionStatus.UnsupportedSource, result.status)
        assertTrue(result.attemptedExtensions.contains(".srt"))
    }

    @Test
    fun `auto detect matches sibling subtitle file for local media path`() {
        val tempDirectory = createTempDirectory(prefix = "subtitle-manager").toFile()
        val videoFile = File(tempDirectory, "demo.mp4").apply { writeBytes(byteArrayOf()) }
        File(tempDirectory, "demo.srt").writeText("1\n00:00:00,000 --> 00:00:01,000\nXin chao\n")
        val manager = SubtitleManager(FakeSubtitleSessionController())

        val result = manager.detectExternalSubtitle(
            videoPath = videoFile.absolutePath,
            scheme = "file"
        )

        assertEquals(SubtitleDetectionStatus.Found, result.status)
        assertNotNull(result.matchedFile)
        assertEquals("demo.srt", result.matchedFile?.name)
        assertEquals("application/x-subrip", result.matchedMimeType)
        assertEquals(1, result.matchedFiles.size)
    }

    @Test
    fun `content scheme detection falls back to resolved local file path`() {
        val tempDirectory = createTempDirectory(prefix = "subtitle-manager-content").toFile()
        val videoFile = File(tempDirectory, "wma.mp4").apply { writeBytes(byteArrayOf()) }
        File(tempDirectory, "wma.srt").writeText("1\n00:00:00,000 --> 00:00:01,000\nXin chao\n")
        val manager = SubtitleManager(FakeSubtitleSessionController())

        val result = manager.detectExternalSubtitle(
            videoPath = "/document/video/123",
            scheme = "content",
            resolvedLocalPath = videoFile.absolutePath
        )

        assertEquals(SubtitleDetectionStatus.Found, result.status)
        assertEquals(listOf("wma.srt"), result.matchedFiles.map { it.file.name })
    }

    @Test
    fun `auto detect matches exact and language tagged subtitle siblings with same base name`() {
        val tempDirectory = createTempDirectory(prefix = "subtitle-manager-siblings").toFile()
        val videoFile = File(tempDirectory, "ten-phim.mp4").apply { writeBytes(byteArrayOf()) }
        File(tempDirectory, "ten-phim.ass").writeText("[Script Info]\nTitle: demo\n")
        File(tempDirectory, "ten-phim.vi.srt").writeText("1\n00:00:00,000 --> 00:00:01,000\nXin chao\n")
        File(tempDirectory, "ten-phim.en.vtt").writeText("WEBVTT\n\n00:00.000 --> 00:01.000\nHello\n")
        File(tempDirectory, "ten-phim.vi.forced.srt").writeText("1\n00:00:00,000 --> 00:00:01,000\nSkip\n")
        File(tempDirectory, "phim-khac.srt").writeText("1\n00:00:00,000 --> 00:00:01,000\nKhac\n")
        val manager = SubtitleManager(FakeSubtitleSessionController())

        val result = manager.detectExternalSubtitle(
            videoPath = videoFile.absolutePath,
            scheme = "file"
        )

        assertEquals(SubtitleDetectionStatus.Found, result.status)
        assertEquals(
            listOf("ten-phim.ass", "ten-phim.en.vtt", "ten-phim.vi.srt"),
            result.matchedFiles.map { it.file.name }
        )
    }

    @Test
    fun `sync detected external subtitles exposes all sibling subtitle files in available sources`() {
        val tempDirectory = createTempDirectory(prefix = "subtitle-manager-available").toFile()
        val manager = SubtitleManager(FakeSubtitleSessionController())

        manager.syncDetectedExternalSubtitleSources(
            listOf(
                DetectedSubtitleFile(
                    file = File(tempDirectory, "ten-phim.ass").apply { writeText("[Script Info]\nTitle: demo\n") },
                    mimeType = "text/x-ssa"
                ),
                DetectedSubtitleFile(
                    file = File(tempDirectory, "ten-phim.vi.srt").apply { writeText("1\n00:00:00,000 --> 00:00:01,000\nXin chao\n") },
                    mimeType = "application/x-subrip"
                )
            )
        )

        val sources = manager.availableSubtitleSources()

        assertEquals(3, sources.size)
        assertEquals(SubtitleSourceKind.Off, sources.first().kind)
        assertEquals(listOf("ten-phim.ass", "ten-phim.vi.srt"), sources.drop(1).map { it.label })
    }

    @Test
    fun `subtitle mime type mapping resolves supported extensions`() {
        val manager = SubtitleManager(FakeSubtitleSessionController())

        assertEquals("application/x-subrip", manager.resolveSubtitleMimeTypeFromName("demo.srt"))
        assertEquals("text/x-ssa", manager.resolveSubtitleMimeTypeFromName("demo.ass"))
        assertEquals("text/vtt", manager.resolveSubtitleMimeTypeFromName("demo.vtt"))
    }

    @Test
    fun `record external subtitle selection preserves playback position and play intent`() {
        val sessionController = FakeSubtitleSessionController(
            currentPositionMsValue = 54_000L,
            playWhenReadyValue = true
        )
        val manager = SubtitleManager(sessionController)

        val state = manager.recordExternalSubtitleSelection(
            sourceId = "external:file:///demo.srt",
            label = "demo.srt",
            mimeType = "application/x-subrip",
            uriValue = "file:///demo.srt",
            isAutoDetected = true
        )

        assertEquals("external:file:///demo.srt", state.activeSourceId)
        assertEquals(54_000L, state.preservedPositionMs)
        assertTrue(state.preservedPlayWhenReady)
    }

    @Test
    fun `available subtitle sources include embedded tracks alongside off placeholder`() {
        val manager = SubtitleManager(
            FakeSubtitleSessionController(
                embeddedTracks = listOf(
                    EmbeddedSubtitleTrack(0, 0, "English", "en", false),
                    EmbeddedSubtitleTrack(1, 0, "Vietnamese", "vi", true)
                )
            )
        )

        val sources = manager.availableSubtitleSources()

        assertEquals(3, sources.size)
        assertEquals(SubtitleSourceKind.Off, sources.first().kind)
        assertTrue(sources.any { it.kind == SubtitleSourceKind.Embedded && it.label == "English" })
        assertTrue(sources.any { it.kind == SubtitleSourceKind.Embedded && it.label == "Vietnamese" })
    }

    @Test
    fun `select embedded subtitle routes override through session controller`() {
        val sessionController = FakeSubtitleSessionController(
            embeddedTracks = listOf(
                EmbeddedSubtitleTrack(0, 0, "Vietnamese", "vi", false)
            )
        )
        val manager = SubtitleManager(sessionController)

        val selected = manager.selectSubtitleSource(SubtitleManager.embeddedSourceId(0, 0))

        assertTrue(selected)
        assertEquals(0, sessionController.selectedGroupIndex)
        assertEquals(0, sessionController.selectedTrackIndex)
        assertFalse(manager.currentSelectionState().textTrackDisabled)
    }

    @Test
    fun `select off disables subtitle tracks after external subtitle was recorded`() {
        val sessionController = FakeSubtitleSessionController(
            currentPositionMsValue = 2_500L,
            playWhenReadyValue = true
        )
        val manager = SubtitleManager(sessionController)
        manager.recordExternalSubtitleSelection(
            sourceId = "external:file:///demo.srt",
            label = "demo.srt",
            mimeType = "application/x-subrip",
            uriValue = "file:///demo.srt",
            isAutoDetected = true
        )

        val selected = manager.selectSubtitleSource("subtitle_source_off")

        assertTrue(selected)
        assertTrue(sessionController.textTracksDisabled)
        assertTrue(manager.currentSelectionState().textTrackDisabled)
    }

    @Test
    fun `resolved style state maps edge mode color boldness and fixed size`() {
        val manager = SubtitleManager(FakeSubtitleSessionController())
        manager.applySubtitleStyle(
            SubtitleStyleState(
                fontSizeSp = 24,
                isBold = true,
                foregroundColor = Color.YELLOW,
                edgeMode = SubtitleEdgeMode.DropShadow,
                edgeColor = Color.BLUE
            )
        )

        val resolvedStyle = manager.resolvedStyleState()

        assertEquals(24, resolvedStyle.fontSizeSp)
        assertEquals(Color.YELLOW, resolvedStyle.foregroundColor)
        assertEquals(Color.BLUE, resolvedStyle.edgeColor)
        assertEquals(CaptionStyleCompat.EDGE_TYPE_DROP_SHADOW, resolvedStyle.edgeType)
        assertTrue(resolvedStyle.useBoldTypeface)
    }
}

private class FakeSubtitleSessionController(
    private val currentMediaItemValue: MediaItem? = null,
    private val currentPositionMsValue: Long = 0L,
    private val playWhenReadyValue: Boolean = false,
    private val embeddedTracks: List<EmbeddedSubtitleTrack> = emptyList()
) : SubtitleSessionController {
    var textTracksEnabled: Boolean = false
    var textTracksDisabled: Boolean = false
    var selectedGroupIndex: Int? = null
    var selectedTrackIndex: Int? = null

    override val currentMediaItem: MediaItem?
        get() = currentMediaItemValue

    override val currentPositionMs: Long
        get() = currentPositionMsValue

    override val playWhenReady: Boolean
        get() = playWhenReadyValue

    override fun setMediaItem(mediaItem: MediaItem, startPositionMs: Long) = Unit

    override fun prepare() = Unit

    override fun currentEmbeddedSubtitleTracks(): List<EmbeddedSubtitleTrack> = embeddedTracks

    override fun enableTextTracks() {
        textTracksEnabled = true
        textTracksDisabled = false
    }

    override fun disableTextTracks() {
        textTracksDisabled = true
        textTracksEnabled = false
    }

    override fun selectEmbeddedSubtitle(groupIndex: Int, trackIndex: Int) {
        selectedGroupIndex = groupIndex
        selectedTrackIndex = trackIndex
        textTracksDisabled = false
    }
}
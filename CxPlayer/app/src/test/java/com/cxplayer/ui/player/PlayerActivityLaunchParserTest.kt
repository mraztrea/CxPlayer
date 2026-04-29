package com.cxplayer.ui.player

import com.cxplayer.R
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class PlayerActivityLaunchParserTest {
    @Test
    fun `fromInput returns ready outcome for supported http source`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate(
                        rawValue = "HTTPS://example.com/demo.mp4",
                        mimeType = null,
                        isAccessible = true
                    )
                ),
                startIndex = 0,
                startPositionMs = 0L,
                origin = LaunchOrigin.ExternalImplicit,
                rawAction = "android.intent.action.VIEW"
            )
        )

        assertTrue(outcome is LaunchOutcome.Ready)
        val ready = outcome as LaunchOutcome.Ready
        assertEquals(LaunchOrigin.ExternalImplicit, ready.request.origin)
        assertEquals(0, ready.selectedIndex)
        assertEquals(0L, ready.effectiveStartPositionMs)
        assertEquals("https://example.com/demo.mp4", ready.request.sources.single().uriValue)
        assertEquals(MediaScheme.Https, ready.request.sources.single().scheme)
    }

    @Test
    fun `fromInput returns ready outcome for explicit multi-source request`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("https://example.com/first.mp4", null, true),
                    LaunchSourceCandidate("https://example.com/second.webm", null, true)
                ),
                startIndex = 1,
                startPositionMs = 1500L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = null
            )
        )

        assertTrue(outcome is LaunchOutcome.Ready)
        val ready = outcome as LaunchOutcome.Ready
        assertEquals(LaunchOrigin.InternalExplicit, ready.request.origin)
        assertEquals(2, ready.request.sources.size)
        assertEquals(1, ready.selectedIndex)
        assertEquals(1500L, ready.effectiveStartPositionMs)
    }

    @Test
    fun `fromInput falls back to first source when start index is invalid`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("https://example.com/alpha.mp4", null, true),
                    LaunchSourceCandidate("https://example.com/beta.webm", null, true)
                ),
                startIndex = 8,
                startPositionMs = 0L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = null
            )
        )

        assertTrue(outcome is LaunchOutcome.FallbackSelected)
        val fallback = outcome as LaunchOutcome.FallbackSelected
        assertEquals(0, fallback.selectedIndex)
        assertEquals(R.string.player_launch_error_invalid_index, fallback.messageResId)
    }

    @Test
    fun `fromInput rejects unsupported scheme and extension`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("ftp://example.com/movie.txt", null, true)
                ),
                startIndex = 0,
                startPositionMs = 0L,
                origin = LaunchOrigin.ExternalImplicit,
                rawAction = "android.intent.action.VIEW"
            )
        )

        assertTrue(outcome is LaunchOutcome.Rejected)
        val rejected = outcome as LaunchOutcome.Rejected
        assertEquals(R.string.player_launch_error_unsupported_source, rejected.messageResId)
    }

    @Test
    fun `fromInput rejects when no media source is provided`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = emptyList(),
                startIndex = 0,
                startPositionMs = 0L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = null
            )
        )

        assertTrue(outcome is LaunchOutcome.Rejected)
        val rejected = outcome as LaunchOutcome.Rejected
        assertEquals(R.string.player_launch_error_missing_source, rejected.messageResId)
    }

    @Test
    fun `fromInput rejects inaccessible file source`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("file:///definitely-missing-video.mp4", null, false)
                ),
                startIndex = 0,
                startPositionMs = 0L,
                origin = LaunchOrigin.ExternalImplicit,
                rawAction = "android.intent.action.VIEW"
            )
        )

        assertTrue(outcome is LaunchOutcome.Rejected)
        val rejected = outcome as LaunchOutcome.Rejected
        assertEquals(R.string.player_launch_error_unsupported_source, rejected.messageResId)
    }
}

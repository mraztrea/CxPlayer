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
    fun `fromInput clamps overflow start index to the nearest valid source`() {
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
        assertEquals(1, fallback.selectedIndex)
        assertEquals(1, fallback.request.startIndex)
        assertEquals(R.string.player_launch_error_invalid_index, fallback.messageResId)
    }

    @Test
    fun `fromInput clamps underflow start index to zero`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("https://example.com/alpha.mp4", null, true),
                    LaunchSourceCandidate("https://example.com/beta.webm", null, true)
                ),
                startIndex = -3,
                startPositionMs = 0L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = null
            )
        )

        assertTrue(outcome is LaunchOutcome.FallbackSelected)
        val fallback = outcome as LaunchOutcome.FallbackSelected
        assertEquals(0, fallback.selectedIndex)
        assertEquals(0, fallback.request.startIndex)
        assertEquals(R.string.player_launch_error_invalid_index, fallback.messageResId)
    }

    @Test
    fun `fromInput resets negative start position to zero`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("https://example.com/alpha.mp4", null, true)
                ),
                startIndex = 0,
                startPositionMs = -1_500L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = null
            )
        )

        assertTrue(outcome is LaunchOutcome.Ready)
        val ready = outcome as LaunchOutcome.Ready
        assertEquals(0L, ready.effectiveStartPositionMs)
        assertEquals(0L, ready.request.startPositionMs)
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

    @Test
    fun `fromInput rejects when all provided sources are filtered out`() {
        val outcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate("ftp://example.com/invalid.txt", null, true),
                    LaunchSourceCandidate("file:///definitely-missing-video.mp4", null, false)
                ),
                startIndex = 0,
                startPositionMs = 0L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = null
            )
        )

        assertTrue(outcome is LaunchOutcome.Rejected)
        val rejected = outcome as LaunchOutcome.Rejected
        assertEquals(R.string.player_launch_error_unsupported_source, rejected.messageResId)
    }

    @Test
    fun `revalidateRequest keeps a valid explicit request playable`() {
        val request = PlaybackRequest(
            sources = listOf(
                MediaSourceRef(
                    uriValue = "https://example.com/demo.mp4",
                    scheme = MediaScheme.Https,
                    mimeType = "video/mp4",
                    isPlayableCandidate = true,
                    displayLabel = "demo.mp4"
                )
            ),
            startIndex = 0,
            startPositionMs = 2_500L,
            origin = LaunchOrigin.InternalExplicit,
            rawAction = null
        )

        val outcome = PlaybackRequestParser.revalidateRequest(request, resolver = null)

        assertTrue(outcome is LaunchOutcome.Ready)
        val ready = outcome as LaunchOutcome.Ready
        assertEquals(0, ready.selectedIndex)
        assertEquals(2_500L, ready.request.startPositionMs)
    }

    @Test
    fun `revalidateRequest rejects inaccessible local file request`() {
        val request = PlaybackRequest(
            sources = listOf(
                MediaSourceRef(
                    uriValue = "file:///definitely-missing-video.mp4",
                    scheme = MediaScheme.File,
                    mimeType = "video/mp4",
                    isPlayableCandidate = true,
                    displayLabel = "definitely-missing-video.mp4"
                )
            ),
            startIndex = 0,
            startPositionMs = 2_500L,
            origin = LaunchOrigin.InternalExplicit,
            rawAction = null
        )

        val outcome = PlaybackRequestParser.revalidateRequest(request, resolver = null)

        assertTrue(outcome is LaunchOutcome.Rejected)
        val rejected = outcome as LaunchOutcome.Rejected
        assertEquals(R.string.player_launch_error_unsupported_source, rejected.messageResId)
    }
}

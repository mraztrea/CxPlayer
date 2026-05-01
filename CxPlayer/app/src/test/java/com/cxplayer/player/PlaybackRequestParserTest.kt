package com.cxplayer.player

import com.cxplayer.ui.player.LaunchOrigin
import com.cxplayer.ui.player.LaunchOutcome
import com.cxplayer.ui.player.LaunchRequestInput
import com.cxplayer.ui.player.LaunchSourceCandidate
import com.cxplayer.ui.player.MediaScheme
import com.cxplayer.ui.player.PlaybackRequestParser
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class PlaybackRequestParserTest {
	@Test
	fun `from input accepts smb sources for explicit launches`() {
		val smbScheme = MediaScheme.fromScheme("smb") ?: error("Expected smb scheme to resolve")

		val outcome = PlaybackRequestParser.fromInput(
			LaunchRequestInput(
				sources = listOf(
					LaunchSourceCandidate(
						rawValue = "smb://server/share/movie.mkv",
						mimeType = null,
						isAccessible = true
					)
				),
				startIndex = 0,
				startPositionMs = 0L,
				origin = LaunchOrigin.InternalExplicit,
				rawAction = null
			)
		)

		assertTrue(outcome is LaunchOutcome.Ready)
		val request = (outcome as LaunchOutcome.Ready).request
		assertEquals(smbScheme, request.sources.single().scheme)
		assertEquals("smb://server/share/movie.mkv", request.sources.single().uriValue)
	}

	@Test
	fun `from input keeps https sources playable`() {
		val outcome = PlaybackRequestParser.fromInput(
			LaunchRequestInput(
				sources = listOf(
					LaunchSourceCandidate(
						rawValue = "https://example.com/movie.mp4",
						mimeType = "video/mp4",
						isAccessible = true
					)
				),
				startIndex = 0,
				startPositionMs = 1_000L,
				origin = LaunchOrigin.InternalExplicit,
				rawAction = null
			)
		)

		assertTrue(outcome is LaunchOutcome.Ready)
		val request = (outcome as LaunchOutcome.Ready).request
		assertEquals(MediaScheme.Https, request.sources.single().scheme)
		assertEquals(1_000L, request.startPositionMs)
	}
}
package com.cxplayer.player

import com.cxplayer.network.NetworkBrowseConnectionState
import com.cxplayer.network.NetworkCredentialSet
import com.cxplayer.network.SharedLibraryEntryType
import com.cxplayer.network.SmbBrowser
import com.cxplayer.network.SmbBrowserGateway
import com.cxplayer.network.SmbRemoteEntry
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test
import java.io.IOException

class SmbBrowserContractTest {
	@Test
	fun `browse returns directory listing and marks playable video files`() {
		val browser = SmbBrowser(
			gateway = FakeSmbBrowserGateway(
				entries = listOf(
					SmbRemoteEntry(name = "Series", isDirectory = true),
					SmbRemoteEntry(name = "movie.mkv", isDirectory = false, sizeBytes = 512_000_000L),
					SmbRemoteEntry(name = "notes.txt", isDirectory = false, sizeBytes = 512L)
				)
			)
		)

		val session = browser.browse(
			credentialSet = NetworkCredentialSet(
				host = " server.local ",
				shareName = " media ",
				username = "demo",
				password = "secret"
			),
			directoryPath = "Movies/Action"
		)

		assertEquals(NetworkBrowseConnectionState.Browsing, session.connectionState)
		assertEquals("Movies/Action", session.currentDirectoryPath)
		assertEquals(3, session.entries.size)
		assertEquals(SharedLibraryEntryType.Directory, session.entries.first().entryType)
		assertFalse(session.entries.first().isPlayableCandidate)

		val videoEntry = session.entries.first { it.displayName == "movie.mkv" }
		assertEquals("Movies/Action/movie.mkv", videoEntry.path)
		assertTrue(videoEntry.isPlayableCandidate)

		val textEntry = session.entries.first { it.displayName == "notes.txt" }
		assertFalse(textEntry.isPlayableCandidate)
		assertEquals(512L, textEntry.sizeBytes)
	}

	@Test
	fun `browse returns friendly error when authentication is rejected`() {
		val browser = SmbBrowser(
			gateway = FakeSmbBrowserGateway(
				failure = IOException("STATUS_LOGON_FAILURE (0xc000006d)")
			)
		)

		val session = browser.browse(
			credentialSet = NetworkCredentialSet(
				host = "server.local",
				shareName = "media",
				username = "demo",
				password = "wrong"
			)
		)

		assertEquals(NetworkBrowseConnectionState.Error, session.connectionState)
		assertTrue(session.errorMessage.orEmpty().contains("Xác thực SMB thất bại"))
		assertTrue(session.entries.isEmpty())
	}

	@Test
	fun `build playback uri only maps playable SMB files`() {
		val browser = SmbBrowser(gateway = FakeSmbBrowserGateway())
		val credentials = NetworkCredentialSet(
			host = "server.local",
			shareName = "media",
			username = "demo",
			password = "secret"
		)
		val playableEntry = browser.browse(
			credentialSet = credentials,
			directoryPath = "Movies"
		).copy(
			entries = listOf(
				com.cxplayer.network.SharedLibraryEntry(
					path = "Movies/movie.mkv",
					displayName = "movie.mkv",
					entryType = SharedLibraryEntryType.File,
					sizeBytes = 1_024L,
					lastModifiedEpochMs = null,
					isPlayableCandidate = true
				),
				com.cxplayer.network.SharedLibraryEntry(
					path = "Movies/Series",
					displayName = "Series",
					entryType = SharedLibraryEntryType.Directory,
					sizeBytes = null,
					lastModifiedEpochMs = null,
					isPlayableCandidate = false
				)
			)
		)

		assertEquals(
			"smb://server.local/media/Movies/movie.mkv",
			browser.buildPlaybackUri(credentials, playableEntry.entries.first())
		)
		assertNull(browser.buildPlaybackUri(credentials, playableEntry.entries.last()))
	}
}

private class FakeSmbBrowserGateway(
	private val entries: List<SmbRemoteEntry> = emptyList(),
	private val failure: IOException? = null
) : SmbBrowserGateway {
	override fun list(
		credentialSet: NetworkCredentialSet,
		directoryPath: String
	): List<SmbRemoteEntry> {
		failure?.let { throw it }
		return entries
	}
}
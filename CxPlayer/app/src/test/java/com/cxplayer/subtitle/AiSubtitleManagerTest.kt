package com.cxplayer.subtitle

import com.cxplayer.data.model.SubtitleEvent
import com.cxplayer.data.model.SubtitleDisplayMode
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.yield
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class AiSubtitleManagerTest {
    @Test
    fun `subtitle snapshot waits until playback reaches soniox start time`() = runBlocking {
        val manager = AiSubtitleManager(this)
        val snapshots = mutableListOf<SubtitleEvent.Snapshot>()
        val collectJob = launch(start = CoroutineStart.UNDISPATCHED) {
            manager.subtitleFlow.collect { event ->
                if (event is SubtitleEvent.Snapshot) {
                    snapshots.add(event)
                }
            }
        }

        manager.handleChunk(
            SonioxChunk(
                finalizedOriginalText = "Hello",
                finalizedTranslationText = "Xin chao",
                startMs = 2_000L,
                endMs = 2_400L,
                hasEndToken = true
            )
        )
        yield()
        assertTrue(snapshots.isEmpty())

        manager.updatePlaybackPosition(1_999L)
        yield()
        assertTrue(snapshots.isEmpty())

        manager.updatePlaybackPosition(2_000L)
        yield()
        assertEquals(1, snapshots.size)
        assertEquals("Hello", snapshots.last().originalText)
        assertEquals("Xin chao", snapshots.last().translationText)
        assertEquals(2_000L, snapshots.last().startPositionMs)
        assertEquals(2_400L, snapshots.last().endPositionMs)

        collectJob.cancelAndJoin()
    }

    @Test
    fun `translation only keeps last visible subtitle until next translated snapshot arrives`() = runBlocking {
        val manager = AiSubtitleManager(this)
        manager.setDisplayMode(SubtitleDisplayMode.TRANSLATION_ONLY)
        val snapshots = mutableListOf<SubtitleEvent.Snapshot>()
        val collectJob = launch(start = CoroutineStart.UNDISPATCHED) {
            manager.subtitleFlow.collect { event ->
                if (event is SubtitleEvent.Snapshot) {
                    snapshots.add(event)
                }
            }
        }

        manager.handleChunk(
            SonioxChunk(
                finalizedOriginalText = "Hello",
                finalizedTranslationText = "Xin chao",
                startMs = 1_000L,
                endMs = 1_300L,
                hasEndToken = true
            )
        )
        manager.updatePlaybackPosition(1_000L)
        yield()
        assertEquals(1, snapshots.size)
        assertEquals("Xin chao", snapshots.last().translationText)

        manager.handleChunk(
            SonioxChunk(
                provisionalOriginalText = "How are",
                startMs = 1_500L
            )
        )
        manager.updatePlaybackPosition(1_500L)
        yield()
        assertEquals(1, snapshots.size)
        assertEquals("Xin chao", snapshots.last().translationText)

        manager.handleChunk(
            SonioxChunk(
                finalizedOriginalText = "How are you?",
                finalizedTranslationText = "Ban khoe khong?",
                startMs = 1_500L,
                endMs = 2_100L,
                hasEndToken = true
            )
        )
        manager.updatePlaybackPosition(1_500L)
        yield()
        assertEquals(2, snapshots.size)
        assertEquals("Ban khoe khong?", snapshots.last().translationText)

        collectJob.cancelAndJoin()
    }
}

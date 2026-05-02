package com.cxplayer.subtitle

import com.cxplayer.data.model.SubtitleEvent
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
}

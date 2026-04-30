package com.cxplayer.ui.player

import android.content.Intent
import android.net.Uri
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Test
import org.junit.runner.RunWith
import java.io.File

@RunWith(AndroidJUnit4::class)
class PlayerActivityPlaybackTest {
    @Test
    fun localLaunchKeepsManagerSessionActiveForTransportCommands() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                assertNotNull(activity.currentPlaybackSnapshot())

                activity.pausePlayback()
                activity.seekForward()
                activity.seekBack()
                activity.playPlayback()

                assertNotNull(activity.currentPlaybackSnapshot())
            }
        }
    }

    @Test
    fun httpLaunchCreatesPlayableSessionWithoutCrashing() {
        ActivityScenario.launch<PlayerActivity>(buildNetworkLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                val snapshot = activity.currentPlaybackSnapshot()
                assertNotNull(snapshot)
                assertEquals(0, snapshot?.currentIndex)
            }
        }
    }

    @Test
    fun recreateRestoresSnapshotAndPausedIntent() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            var snapshotBeforeRecreate: com.cxplayer.player.PlaybackSnapshot? = null

            scenario.onActivity { activity ->
                activity.pausePlayback()
                activity.seekToPosition(6_000L)
                snapshotBeforeRecreate = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotBeforeRecreate)
            }

            scenario.recreate()

            scenario.onActivity { activity ->
                val snapshotAfterRecreate = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotAfterRecreate)
                assertEquals(
                    snapshotBeforeRecreate?.currentIndex,
                    snapshotAfterRecreate?.currentIndex
                )
                assertFalse(snapshotAfterRecreate?.playWhenReady ?: true)
            }

            scenario.moveToState(Lifecycle.State.CREATED)
            scenario.moveToState(Lifecycle.State.RESUMED)

            scenario.onActivity { activity ->
                val snapshotAfterForegroundReturn = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotAfterForegroundReturn)
                assertFalse(snapshotAfterForegroundReturn?.playWhenReady ?: true)
            }
        }
    }

    private fun buildLocalLaunchIntent(): Intent {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val tempFile = File.createTempFile("player-activity", ".mp4", context.cacheDir)
        if (!tempFile.exists()) {
            tempFile.writeBytes(byteArrayOf())
        }

        return Intent(context, PlayerActivity::class.java).apply {
            data = Uri.fromFile(tempFile)
            putExtra(PlayerLaunchExtras.EXTRA_START_POSITION_MS, 1_000L)
        }
    }

    private fun buildNetworkLaunchIntent(): Intent {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        return Intent(context, PlayerActivity::class.java).apply {
            data = Uri.parse("http://example.com/demo.mp4")
        }
    }
}
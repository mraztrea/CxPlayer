package com.cxplayer.ui.player

import android.content.Intent
import android.content.pm.ActivityInfo
import android.net.Uri
import android.view.View
import android.widget.ImageButton
import androidx.annotation.IdRes
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.cxplayer.R
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertTrue
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
                assertTrue(activity.hasChromeSkeleton())

                activity.pausePlayback()
                activity.seekForward()
                activity.seekBack()
                activity.playPlayback()

                assertNotNull(activity.currentPlaybackSnapshot())
            }
        }
    }

    @Test
    fun localLaunchShowsVideoTimelineAndTransportRegionsOnFirstRender() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                assertVisible(activity, R.id.playerView)
                assertVisible(activity, R.id.playerTimelineRow)
                assertVisible(activity, R.id.playerTransportRow)
                assertVisible(activity, R.id.playerCurrentTimeView)
                assertVisible(activity, R.id.playerSeekBar)
                assertVisible(activity, R.id.playerDurationView)
            }
        }
    }

    @Test
    fun localLaunchShowsTopBarWithVisibleActionsAndNonBlankTitle() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                assertVisible(activity, R.id.playerTopChrome)
                assertVisible(activity, R.id.playerBackButton)
                assertVisible(activity, R.id.playerTitleView)
                assertVisible(activity, R.id.playerOverflowButton)
                assertTextNotBlank(activity, R.id.playerTitleView)
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
    fun transportButtonsControlPlaybackSession() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                val playPauseButton = activity.findViewById<ImageButton>(R.id.playerPlayPauseButton)
                val seekBackButton = activity.findViewById<ImageButton>(R.id.playerSeekBackButton)
                val seekForwardButton = activity.findViewById<ImageButton>(R.id.playerSeekForwardButton)

                val initialSnapshot = requireNotNull(activity.currentPlaybackSnapshot())
                assertTrue(initialSnapshot.playWhenReady)

                assertTrue(playPauseButton.performClick())
                val pausedSnapshot = requireNotNull(activity.currentPlaybackSnapshot())
                assertFalse(pausedSnapshot.playWhenReady)

                activity.seekToPosition(15_000L)
                val beforeSeekBackPosition = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                assertTrue(seekBackButton.performClick())
                val afterSeekBackPosition = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                assertTrue(afterSeekBackPosition < beforeSeekBackPosition)

                activity.seekToPosition(5_000L)
                val beforeSeekForwardPosition = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                assertTrue(seekForwardButton.performClick())
                val afterSeekForwardPosition = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                assertTrue(afterSeekForwardPosition > beforeSeekForwardPosition)

                assertTrue(playPauseButton.performClick())
                val resumedSnapshot = requireNotNull(activity.currentPlaybackSnapshot())
                assertTrue(resumedSnapshot.playWhenReady)
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

    @Test
    fun recreateAndOrientationChangeKeepPlayerChromeVisible() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                activity.requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
            }
            InstrumentationRegistry.getInstrumentation().waitForIdleSync()

            scenario.onActivity { activity ->
                assertVisible(activity, R.id.playerTopChrome)
                assertVisible(activity, R.id.playerTimelineRow)
                assertVisible(activity, R.id.playerTransportRow)
            }

            scenario.recreate()

            scenario.onActivity { activity ->
                assertVisible(activity, R.id.playerTopChrome)
                assertVisible(activity, R.id.playerTimelineRow)
                assertVisible(activity, R.id.playerTransportRow)
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

    private fun requireView(activity: PlayerActivity, @IdRes viewId: Int): View {
        return activity.findViewById<View>(viewId).also { view ->
            assertNotNull("View with id $viewId should exist", view)
        }
    }

    private fun assertVisible(activity: PlayerActivity, @IdRes viewId: Int) {
        val view = requireView(activity, viewId)
        assertEquals(View.VISIBLE, view.visibility)
    }

    private fun assertTextNotBlank(activity: PlayerActivity, @IdRes viewId: Int) {
        val view = requireView(activity, viewId)
        assertTrue(view is android.widget.TextView)
        assertTrue((view as android.widget.TextView).text.toString().isNotBlank())
    }
}
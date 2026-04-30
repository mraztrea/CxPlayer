package com.cxplayer.ui.player

import android.content.Intent
import android.content.pm.ActivityInfo
import android.net.Uri
import android.view.View
import androidx.annotation.IdRes
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.cxplayer.R
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
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
    fun httpLaunchRestoresAfterForegroundReturn() {
        ActivityScenario.launch<PlayerActivity>(buildNetworkLaunchIntent()).use { scenario ->
            var snapshotBeforeBackground: com.cxplayer.player.PlaybackSnapshot? = null

            scenario.onActivity { activity ->
                activity.pausePlayback()
                activity.seekToPosition(5_000L)
                snapshotBeforeBackground = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotBeforeBackground)
            }

            scenario.moveToState(Lifecycle.State.CREATED)
            scenario.moveToState(Lifecycle.State.RESUMED)

            scenario.onActivity { activity ->
                val snapshotAfterReturn = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotAfterReturn)
                assertEquals(snapshotBeforeBackground?.currentIndex, snapshotAfterReturn?.currentIndex)
                assertFalse(snapshotAfterReturn?.playWhenReady ?: true)
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

    @Test
    fun multiSourceRecreateKeepsSelectedItemIndex() {
        ActivityScenario.launch<PlayerActivity>(buildMultiSourceLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                val snapshotBeforeRecreate = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotBeforeRecreate)
                assertEquals(1, snapshotBeforeRecreate?.currentIndex)
            }

            scenario.recreate()

            scenario.onActivity { activity ->
                val snapshotAfterRecreate = activity.currentPlaybackSnapshot()
                assertNotNull(snapshotAfterRecreate)
                assertEquals(1, snapshotAfterRecreate?.currentIndex)
            }
        }
    }

    @Test
    fun foregroundReturnWithMissingLocalSourceClearsPlaybackSession() {
        val localFile = createTempVideoFile()
        val launchIntent = buildLocalLaunchIntent(localFile)

        ActivityScenario.launch<PlayerActivity>(launchIntent).use { scenario ->
            scenario.onActivity { activity ->
                activity.pausePlayback()
                activity.seekToPosition(6_000L)
                assertNotNull(activity.currentPlaybackSnapshot())
            }

            scenario.moveToState(Lifecycle.State.CREATED)
            assertTrue(localFile.delete())
            scenario.moveToState(Lifecycle.State.RESUMED)

            scenario.onActivity { activity ->
                assertNull(activity.currentPlaybackSnapshot())
                assertEquals("--:--", requireText(activity, R.id.playerDurationView))
            }
        }
    }

    @Test
    fun finishAndRelaunchDoesNotReusePreviousSnapshot() {
        val localFile = createTempVideoFile()
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent(localFile)).use { scenario ->
            scenario.onActivity { activity ->
                activity.pausePlayback()
                activity.seekToPosition(8_000L)
                activity.finish()
            }
        }

        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent(localFile)).use { scenario ->
            scenario.onActivity { activity ->
                val relaunchedSnapshot = activity.currentPlaybackSnapshot()
                assertNotNull(relaunchedSnapshot)
                assertEquals(1_000L, relaunchedSnapshot?.currentPositionMs)
                assertTrue(relaunchedSnapshot?.playWhenReady ?: false)
            }
        }
    }

    private fun buildLocalLaunchIntent(tempFile: File = createTempVideoFile()): Intent {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        return Intent(context, PlayerActivity::class.java).apply {
            data = Uri.fromFile(tempFile)
            putExtra(PlayerLaunchExtras.EXTRA_START_POSITION_MS, 1_000L)
        }
    }

    private fun buildMultiSourceLaunchIntent(): Intent {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val firstFile = createTempVideoFile("player-activity-first")
        val secondFile = createTempVideoFile("player-activity-second")

        return Intent(context, PlayerActivity::class.java).apply {
            putParcelableArrayListExtra(
                PlayerLaunchExtras.EXTRA_MEDIA_URIS,
                arrayListOf(Uri.fromFile(firstFile), Uri.fromFile(secondFile))
            )
            putExtra(PlayerLaunchExtras.EXTRA_START_INDEX, 1)
            putExtra(PlayerLaunchExtras.EXTRA_START_POSITION_MS, 4_000L)
        }
    }

    private fun buildNetworkLaunchIntent(): Intent {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        return Intent(context, PlayerActivity::class.java).apply {
            data = Uri.parse("http://example.com/demo.mp4")
        }
    }

    private fun createTempVideoFile(prefix: String = "player-activity"): File {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        return File.createTempFile(prefix, ".mp4", context.cacheDir).also { file ->
            if (!file.exists()) {
                file.writeBytes(byteArrayOf())
            }
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

    private fun requireText(activity: PlayerActivity, @IdRes viewId: Int): String {
        val view = requireView(activity, viewId)
        assertTrue(view is android.widget.TextView)
        return (view as android.widget.TextView).text.toString()
    }
}
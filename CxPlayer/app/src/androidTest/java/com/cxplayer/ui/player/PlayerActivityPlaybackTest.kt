package com.cxplayer.ui.player

import android.content.Intent
import android.content.pm.ActivityInfo
import android.media.AudioManager
import android.net.Uri
import android.os.SystemClock
import android.view.InputDevice
import android.view.MotionEvent
import android.view.View
import android.view.ViewConfiguration
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

    @Test
    fun surfaceSwipeGesturesAdjustVolumeBrightnessAndSeek() {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val audioManager = context.getSystemService(AudioManager::class.java)

        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            var baselineVolume = 0
            var originalVolume = 0
            var baselineBrightness = 0f
            var baselinePosition = 0L
            var expectedVolume = 0
            var expectedBrightness = 0f
            var expectedPosition = 0L

            scenario.onActivity { activity ->
                val playerView = requireView(activity, R.id.playerView)
                val verticalSwipeDistancePx = playerView.height * 0.6f
                val horizontalSwipeDistancePx = playerView.width * 0.3f
                val expectedVerticalSteps = (verticalSwipeDistancePx / 150f).toInt()
                val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                originalVolume = activity.currentMusicStreamVolume()
                baselineVolume = (maxVolume / 2).coerceAtLeast(1)
                audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, baselineVolume, 0)

                baselineBrightness = activity.currentGestureBrightness()
                baselinePosition = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                expectedVolume = (baselineVolume + expectedVerticalSteps).coerceIn(0, maxVolume)
                expectedBrightness = (baselineBrightness + (expectedVerticalSteps * 0.05f))
                    .coerceIn(0.05f, 1f)
                expectedPosition = baselinePosition + (horizontalSwipeDistancePx * 100f).toLong()

                dispatchSwipe(activity, R.id.playerView, 0.8f, 0.8f, 0.8f, 0.2f)
                dispatchSwipe(activity, R.id.playerView, 0.2f, 0.8f, 0.2f, 0.2f)
                dispatchSwipe(activity, R.id.playerView, 0.25f, 0.5f, 0.55f, 0.5f)
            }
            InstrumentationRegistry.getInstrumentation().waitForIdleSync()

            try {
                scenario.onActivity { activity ->
                    assertEquals(expectedVolume, activity.currentMusicStreamVolume())
                    assertEquals(expectedBrightness, activity.currentGestureBrightness(), 0.0001f)
                    assertEquals(expectedPosition, requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs)
                }
            } finally {
                audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, originalVolume, 0)
            }
        }
    }

    @Test
    fun surfaceDoubleTapGesturesTogglePlaybackAndSeekByZone() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            scenario.onActivity { activity ->
                dispatchDoubleTap(activity, R.id.playerView, 0.5f, 0.5f)
            }
            InstrumentationRegistry.getInstrumentation().waitForIdleSync()

            scenario.onActivity { activity ->
                assertFalse(requireNotNull(activity.currentPlaybackSnapshot()).playWhenReady)

                activity.seekToPosition(20_000L)
                val beforeLeftDoubleTap = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                dispatchDoubleTap(activity, R.id.playerView, 0.16f, 0.5f)
                val afterLeftDoubleTap = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                assertTrue(afterLeftDoubleTap < beforeLeftDoubleTap)

                activity.seekToPosition(5_000L)
                val beforeRightDoubleTap = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                dispatchDoubleTap(activity, R.id.playerView, 0.84f, 0.5f)
                val afterRightDoubleTap = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                assertTrue(afterRightDoubleTap > beforeRightDoubleTap)
            }
        }
    }

    @Test
    fun surfaceLongPressTemporarilyAdjustsPlaybackSpeed() {
        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            lateinit var anchor: TouchAnchor

            scenario.onActivity { activity ->
                anchor = dispatchLongPressDown(activity, R.id.playerView, 0.5f, 0.5f)
            }

            SystemClock.sleep((ViewConfiguration.getLongPressTimeout() + 150).toLong())
            InstrumentationRegistry.getInstrumentation().waitForIdleSync()

            scenario.onActivity { activity ->
                assertEquals(2f, activity.currentPlaybackState().playbackSpeed, 0f)
                dispatchSinglePointerEvent(
                    view = requireView(activity, R.id.playerView),
                    action = MotionEvent.ACTION_UP,
                    x = anchor.x,
                    y = anchor.y,
                    downTime = anchor.downTime,
                    eventTime = SystemClock.uptimeMillis()
                )
            }
            InstrumentationRegistry.getInstrumentation().waitForIdleSync()

            scenario.onActivity { activity ->
                assertEquals(1f, activity.currentPlaybackState().playbackSpeed, 0f)
            }
        }
    }

    @Test
    fun surfacePinchGestureUpdatesPlayerZoomScale() {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val audioManager = context.getSystemService(AudioManager::class.java)

        ActivityScenario.launch<PlayerActivity>(buildLocalLaunchIntent()).use { scenario ->
            var baselinePosition = 0L
            var baselineBrightness = 0f
            var baselineVolume = 0

            scenario.onActivity { activity ->
                baselinePosition = requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs
                baselineBrightness = activity.currentGestureBrightness()
                baselineVolume = activity.currentMusicStreamVolume()
                dispatchPinch(activity, R.id.playerView, startDistanceFraction = 0.08f, endDistanceFraction = 0.22f)
            }
            InstrumentationRegistry.getInstrumentation().waitForIdleSync()

            scenario.onActivity { activity ->
                assertTrue(activity.currentPlayerZoomScale() in 1f..3f)
                assertEquals(baselinePosition, requireNotNull(activity.currentPlaybackSnapshot()).currentPositionMs)
                assertEquals(baselineBrightness, activity.currentGestureBrightness(), 0.0001f)
                assertEquals(baselineVolume, activity.currentMusicStreamVolume())
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

    private fun dispatchSwipe(
        activity: PlayerActivity,
        @IdRes viewId: Int,
        startXFraction: Float,
        startYFraction: Float,
        endXFraction: Float,
        endYFraction: Float,
        moveSteps: Int = 4
    ) {
        val view = requireView(activity, viewId)
        val startX = view.width * startXFraction
        val startY = view.height * startYFraction
        val endX = view.width * endXFraction
        val endY = view.height * endYFraction
        val downTime = SystemClock.uptimeMillis()

        dispatchSinglePointerEvent(view, MotionEvent.ACTION_DOWN, startX, startY, downTime, downTime)
        for (step in 1..moveSteps) {
            val progress = step / moveSteps.toFloat()
            val x = startX + ((endX - startX) * progress)
            val y = startY + ((endY - startY) * progress)
            dispatchSinglePointerEvent(
                view,
                MotionEvent.ACTION_MOVE,
                x,
                y,
                downTime,
                downTime + (step * 16L)
            )
        }
        dispatchSinglePointerEvent(view, MotionEvent.ACTION_UP, endX, endY, downTime, downTime + 100L)
    }

    private fun dispatchDoubleTap(
        activity: PlayerActivity,
        @IdRes viewId: Int,
        xFraction: Float,
        yFraction: Float
    ) {
        val view = requireView(activity, viewId)
        val x = view.width * xFraction
        val y = view.height * yFraction
        val firstDown = SystemClock.uptimeMillis()

        dispatchSinglePointerEvent(view, MotionEvent.ACTION_DOWN, x, y, firstDown, firstDown)
        dispatchSinglePointerEvent(view, MotionEvent.ACTION_UP, x, y, firstDown, firstDown + 30L)

        val secondDown = firstDown + 90L
        dispatchSinglePointerEvent(view, MotionEvent.ACTION_DOWN, x, y, secondDown, secondDown)
        dispatchSinglePointerEvent(view, MotionEvent.ACTION_UP, x, y, secondDown, secondDown + 30L)
    }

    private fun dispatchLongPressDown(
        activity: PlayerActivity,
        @IdRes viewId: Int,
        xFraction: Float,
        yFraction: Float
    ): TouchAnchor {
        val view = requireView(activity, viewId)
        val x = view.width * xFraction
        val y = view.height * yFraction
        val downTime = SystemClock.uptimeMillis()
        dispatchSinglePointerEvent(view, MotionEvent.ACTION_DOWN, x, y, downTime, downTime)
        return TouchAnchor(x = x, y = y, downTime = downTime)
    }

    private fun dispatchPinch(
        activity: PlayerActivity,
        @IdRes viewId: Int,
        startDistanceFraction: Float,
        endDistanceFraction: Float
    ) {
        val view = requireView(activity, viewId)
        val centerX = view.width / 2f
        val centerY = view.height / 2f
        val startDistance = view.width * startDistanceFraction
        val endDistance = view.width * endDistanceFraction
        val downTime = SystemClock.uptimeMillis()

        dispatchSinglePointerEvent(
            view,
            MotionEvent.ACTION_DOWN,
            centerX - startDistance,
            centerY,
            downTime,
            downTime
        )

        dispatchMultiPointerEvent(
            view = view,
            action = MotionEvent.ACTION_POINTER_DOWN,
            actionIndex = 1,
            downTime = downTime,
            eventTime = downTime + 10L,
            points = listOf(
                TouchPoint(centerX - startDistance, centerY),
                TouchPoint(centerX + startDistance, centerY)
            )
        )

        for (step in 1..4) {
            val progress = step / 4f
            val distance = startDistance + ((endDistance - startDistance) * progress)
            dispatchMultiPointerEvent(
                view = view,
                action = MotionEvent.ACTION_MOVE,
                actionIndex = 0,
                downTime = downTime,
                eventTime = downTime + 10L + (step * 16L),
                points = listOf(
                    TouchPoint(centerX - distance, centerY),
                    TouchPoint(centerX + distance, centerY)
                )
            )
        }

        dispatchMultiPointerEvent(
            view = view,
            action = MotionEvent.ACTION_POINTER_UP,
            actionIndex = 1,
            downTime = downTime,
            eventTime = downTime + 90L,
            points = listOf(
                TouchPoint(centerX - endDistance, centerY),
                TouchPoint(centerX + endDistance, centerY)
            )
        )

        dispatchSinglePointerEvent(
            view,
            MotionEvent.ACTION_UP,
            centerX - endDistance,
            centerY,
            downTime,
            downTime + 110L
        )
    }

    private fun dispatchSinglePointerEvent(
        view: View,
        action: Int,
        x: Float,
        y: Float,
        downTime: Long,
        eventTime: Long
    ) {
        MotionEvent.obtain(downTime, eventTime, action, x, y, 0).also { event ->
            view.dispatchTouchEvent(event)
            event.recycle()
        }
    }

    private fun dispatchMultiPointerEvent(
        view: View,
        action: Int,
        actionIndex: Int,
        downTime: Long,
        eventTime: Long,
        points: List<TouchPoint>
    ) {
        val pointerProperties = Array(points.size) { index ->
            MotionEvent.PointerProperties().apply {
                id = index
                toolType = MotionEvent.TOOL_TYPE_FINGER
            }
        }
        val pointerCoords = Array(points.size) { index ->
            MotionEvent.PointerCoords().apply {
                x = points[index].x
                y = points[index].y
                pressure = 1f
                size = 1f
            }
        }
        val motionAction = if (action == MotionEvent.ACTION_MOVE) {
            action
        } else {
            action + (actionIndex shl MotionEvent.ACTION_POINTER_INDEX_SHIFT)
        }

        MotionEvent.obtain(
            downTime,
            eventTime,
            motionAction,
            points.size,
            pointerProperties,
            pointerCoords,
            0,
            0,
            1f,
            1f,
            0,
            0,
            InputDevice.SOURCE_TOUCHSCREEN,
            0
        ).also { event ->
            view.dispatchTouchEvent(event)
            event.recycle()
        }
    }
}

private data class TouchPoint(
    val x: Float,
    val y: Float
)

private data class TouchAnchor(
    val x: Float,
    val y: Float,
    val downTime: Long
)
package com.cxplayer.ui.player

import android.view.GestureDetector
import android.view.MotionEvent
import android.view.ScaleGestureDetector
import android.view.View
import androidx.media3.ui.PlayerView
import kotlin.math.abs

private const val DEFAULT_DIRECTION_LOCK_DISTANCE_PX = 24f
private const val DEFAULT_VERTICAL_STEP_DISTANCE_PX = 150f
private const val DEFAULT_VOLUME_STEP_DELTA = 1f
private const val DEFAULT_BRIGHTNESS_STEP_DELTA = 0.05f
private const val DEFAULT_SEEK_MS_PER_PX = 100L
private const val DEFAULT_DOUBLE_TAP_SEEK_DELTA_MS = 10_000L
private const val DEFAULT_FAST_FORWARD_SPEED = 2f
private const val DEFAULT_MIN_ZOOM_SCALE = 1f
private const val DEFAULT_MAX_ZOOM_SCALE = 3f

class GestureController(
    private val playerView: PlayerView,
    private val onVolumeChange: (delta: Float) -> Unit,
    private val onBrightnessChange: (delta: Float) -> Unit,
    private val onSeekDelta: (deltaMs: Long) -> Unit,
    private val onTogglePlayPause: () -> Unit,
    private val onFastForward: (speed: Float) -> Unit,
    private val onFastForwardEnd: () -> Unit,
    private val onZoom: (scaleFactor: Float) -> Unit
) : View.OnTouchListener {
    private val sessionController = GestureSessionController(
        sink = object : GestureCallbackSink {
            override fun onVolumeDelta(delta: Float) {
                this@GestureController.onVolumeChange(delta)
            }

            override fun onBrightnessDelta(delta: Float) {
                this@GestureController.onBrightnessChange(delta)
            }

            override fun onSeekDelta(deltaMs: Long) {
                this@GestureController.onSeekDelta(deltaMs)
            }

            override fun onTogglePlayPause() {
                this@GestureController.onTogglePlayPause()
            }

            override fun onFastForwardStart(speed: Float) {
                this@GestureController.onFastForward(speed)
            }

            override fun onFastForwardEnd() {
                this@GestureController.onFastForwardEnd()
            }

            override fun onZoom(scaleFactor: Float) {
                this@GestureController.onZoom(scaleFactor)
            }
        }
    )
    private val gestureDetector = GestureDetector(
        playerView.context,
        object : GestureDetector.SimpleOnGestureListener() {
            override fun onDown(event: MotionEvent): Boolean = true

            override fun onScroll(
                firstDown: MotionEvent?,
                current: MotionEvent,
                distanceX: Float,
                distanceY: Float
            ): Boolean {
                return sessionController.onScroll(currentX = current.x, currentY = current.y)
            }

            override fun onDoubleTap(event: MotionEvent): Boolean {
                return sessionController.onDoubleTap(
                    tapX = event.x,
                    widthPx = resolvePlayerWidth()
                )
            }

            override fun onLongPress(event: MotionEvent) {
                sessionController.onLongPress()
            }
        }
    )
    private val scaleGestureDetector = ScaleGestureDetector(
        playerView.context,
        object : ScaleGestureDetector.SimpleOnScaleGestureListener() {
            override fun onScaleBegin(detector: ScaleGestureDetector): Boolean {
                return sessionController.onScaleBegin()
            }

            override fun onScale(detector: ScaleGestureDetector): Boolean {
                return sessionController.onScale(detector.scaleFactor)
            }
        }
    )

    init {
        playerView.isLongClickable = true
        playerView.setOnTouchListener(this)
    }

    var isLocked: Boolean = false

    override fun onTouch(view: View?, event: MotionEvent?): Boolean {
        val motionEvent = event ?: return false
        if (isLocked) return false
        when (motionEvent.actionMasked) {
            MotionEvent.ACTION_DOWN -> {
                sessionController.onTouchDown(
                    startX = motionEvent.x,
                    startY = motionEvent.y,
                    widthPx = resolvePlayerWidth()
                )
            }

            MotionEvent.ACTION_POINTER_DOWN -> sessionController.onAdditionalPointer()
        }

        val scaleHandled = scaleGestureDetector.onTouchEvent(motionEvent)
        val gestureHandled = if (motionEvent.pointerCount == 1 && !sessionController.isPinchInProgress()) {
            gestureDetector.onTouchEvent(motionEvent)
        } else {
            false
        }

        when (motionEvent.actionMasked) {
            MotionEvent.ACTION_UP,
            MotionEvent.ACTION_CANCEL -> sessionController.onTouchEnd()
        }

        return scaleHandled || gestureHandled || sessionController.hasActiveSession()
    }

    fun release() {
        sessionController.onTouchEnd()
        playerView.setOnTouchListener(null)
    }

    private fun resolvePlayerWidth(): Int {
        return when {
            playerView.width > 0 -> playerView.width
            playerView.measuredWidth > 0 -> playerView.measuredWidth
            else -> 0
        }
    }
}

internal enum class GestureAxis {
    Horizontal,
    Vertical
}

internal enum class GestureHalfZone {
    Left,
    Right
}

internal enum class GestureTapZone {
    Left,
    Center,
    Right
}

internal data class GestureThresholdProfile(
    val directionLockDistancePx: Float = DEFAULT_DIRECTION_LOCK_DISTANCE_PX,
    val verticalStepDistancePx: Float = DEFAULT_VERTICAL_STEP_DISTANCE_PX,
    val volumeStepDelta: Float = DEFAULT_VOLUME_STEP_DELTA,
    val brightnessStepDelta: Float = DEFAULT_BRIGHTNESS_STEP_DELTA,
    val seekMsPerPixel: Long = DEFAULT_SEEK_MS_PER_PX,
    val doubleTapSeekDeltaMs: Long = DEFAULT_DOUBLE_TAP_SEEK_DELTA_MS,
    val fastForwardSpeed: Float = DEFAULT_FAST_FORWARD_SPEED,
    val minZoomScale: Float = DEFAULT_MIN_ZOOM_SCALE,
    val maxZoomScale: Float = DEFAULT_MAX_ZOOM_SCALE
)

internal data class GestureSessionState(
    val startX: Float,
    val startY: Float,
    val halfZone: GestureHalfZone,
    val lockedAxis: GestureAxis? = null,
    val lastVerticalSteps: Int = 0,
    val lastSeekDeltaMs: Long = 0L,
    val longPressActive: Boolean = false,
    val pinchInProgress: Boolean = false
)

internal interface GestureCallbackSink {
    fun onVolumeDelta(delta: Float)

    fun onBrightnessDelta(delta: Float)

    fun onSeekDelta(deltaMs: Long)

    fun onTogglePlayPause()

    fun onFastForwardStart(speed: Float)

    fun onFastForwardEnd()

    fun onZoom(scaleFactor: Float)
}

internal class GestureSessionController(
    private val thresholdProfile: GestureThresholdProfile = GestureThresholdProfile(),
    private val sink: GestureCallbackSink
) {
    private var state: GestureSessionState? = null

    fun hasActiveSession(): Boolean = state != null

    fun isPinchInProgress(): Boolean = state?.pinchInProgress == true

    fun onTouchDown(startX: Float, startY: Float, widthPx: Int) {
        state = GestureSessionState(
            startX = startX,
            startY = startY,
            halfZone = GestureMath.resolveHalfZone(startX = startX, widthPx = widthPx)
        )
    }

    fun onAdditionalPointer() {
        state = state?.let(::finishFastForwardIfNeeded)?.copy(
            pinchInProgress = true,
            lockedAxis = null
        )
    }

    fun onScroll(currentX: Float, currentY: Float): Boolean {
        val currentState = state ?: return false
        if (currentState.pinchInProgress || currentState.longPressActive) {
            return false
        }

        val totalDeltaX = currentX - currentState.startX
        val totalDeltaY = currentY - currentState.startY
        val lockedAxis = currentState.lockedAxis ?: GestureMath.resolveAxis(
            deltaX = totalDeltaX,
            deltaY = totalDeltaY,
            lockDistancePx = thresholdProfile.directionLockDistancePx
        )
            ?: return false

        state = currentState.copy(lockedAxis = lockedAxis)
        return when (lockedAxis) {
            GestureAxis.Vertical -> handleVerticalScroll(totalDeltaY)
            GestureAxis.Horizontal -> handleHorizontalScroll(totalDeltaX)
        }
    }

    fun onDoubleTap(tapX: Float, widthPx: Int): Boolean {
        return when (GestureMath.resolveTapZone(startX = tapX, widthPx = widthPx)) {
            GestureTapZone.Left -> {
                sink.onSeekDelta(-thresholdProfile.doubleTapSeekDeltaMs)
                true
            }

            GestureTapZone.Center -> {
                sink.onTogglePlayPause()
                true
            }

            GestureTapZone.Right -> {
                sink.onSeekDelta(thresholdProfile.doubleTapSeekDeltaMs)
                true
            }
        }
    }

    fun onLongPress(): Boolean {
        val currentState = state ?: return false
        if (currentState.longPressActive) {
            return true
        }

        sink.onFastForwardStart(thresholdProfile.fastForwardSpeed)
        state = currentState.copy(longPressActive = true, lockedAxis = null)
        return true
    }

    fun onScaleBegin(): Boolean {
        val currentState = state ?: return false
        state = finishFastForwardIfNeeded(currentState).copy(
            pinchInProgress = true,
            lockedAxis = null
        )
        return true
    }

    fun onScale(scaleFactor: Float): Boolean {
        if (state == null) {
            return false
        }

        state = state?.copy(pinchInProgress = true, lockedAxis = null)
        val boundedScaleFactor = scaleFactor.coerceIn(
            thresholdProfile.minZoomScale,
            thresholdProfile.maxZoomScale
        )
        sink.onZoom(boundedScaleFactor)
        return true
    }

    fun onTouchEnd() {
        state?.let(::finishFastForwardIfNeeded)
        state = null
    }

    private fun handleVerticalScroll(totalDeltaY: Float): Boolean {
        val currentState = state ?: return false
        val nextSteps = GestureMath.resolveSignedStepCount(
            distancePx = -totalDeltaY,
            stepDistancePx = thresholdProfile.verticalStepDistancePx
        )
        val deltaSteps = nextSteps - currentState.lastVerticalSteps
        if (deltaSteps != 0) {
            when (currentState.halfZone) {
                GestureHalfZone.Left -> sink.onBrightnessDelta(
                    deltaSteps * thresholdProfile.brightnessStepDelta
                )

                GestureHalfZone.Right -> sink.onVolumeDelta(
                    deltaSteps * thresholdProfile.volumeStepDelta
                )
            }
        }

        state = currentState.copy(lastVerticalSteps = nextSteps, lockedAxis = GestureAxis.Vertical)
        return true
    }

    private fun handleHorizontalScroll(totalDeltaX: Float): Boolean {
        val currentState = state ?: return false
        val nextDeltaMs = (totalDeltaX * thresholdProfile.seekMsPerPixel).toLong()
        val deltaMs = nextDeltaMs - currentState.lastSeekDeltaMs
        if (deltaMs != 0L) {
            sink.onSeekDelta(deltaMs)
        }

        state = currentState.copy(lastSeekDeltaMs = nextDeltaMs, lockedAxis = GestureAxis.Horizontal)
        return true
    }

    private fun finishFastForwardIfNeeded(currentState: GestureSessionState): GestureSessionState {
        if (currentState.longPressActive) {
            sink.onFastForwardEnd()
        }
        return currentState.copy(longPressActive = false)
    }
}

internal object GestureMath {
    fun resolveHalfZone(startX: Float, widthPx: Int): GestureHalfZone {
        if (widthPx <= 0) {
            return GestureHalfZone.Left
        }

        return if (startX >= widthPx / 2f) {
            GestureHalfZone.Right
        } else {
            GestureHalfZone.Left
        }
    }

    fun resolveTapZone(startX: Float, widthPx: Int): GestureTapZone {
        if (widthPx <= 0) {
            return GestureTapZone.Center
        }

        val thirdWidth = widthPx / 3f
        return when {
            startX < thirdWidth -> GestureTapZone.Left
            startX >= thirdWidth * 2f -> GestureTapZone.Right
            else -> GestureTapZone.Center
        }
    }

    fun resolveAxis(
        deltaX: Float,
        deltaY: Float,
        lockDistancePx: Float = DEFAULT_DIRECTION_LOCK_DISTANCE_PX
    ): GestureAxis? {
        if (abs(deltaX) < lockDistancePx && abs(deltaY) < lockDistancePx) {
            return null
        }

        return if (abs(deltaY) >= abs(deltaX)) {
            GestureAxis.Vertical
        } else {
            GestureAxis.Horizontal
        }
    }

    fun resolveSignedStepCount(distancePx: Float, stepDistancePx: Float): Int {
        if (stepDistancePx <= 0f) {
            return 0
        }

        return (distancePx / stepDistancePx).toInt()
    }
}
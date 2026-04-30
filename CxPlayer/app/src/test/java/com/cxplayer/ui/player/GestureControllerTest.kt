package com.cxplayer.ui.player

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

class GestureControllerTest {
    @Test
    fun `resolveHalfZone returns right for points on right half`() {
        val zone = GestureMath.resolveHalfZone(startX = 900f, widthPx = 1200)

        assertEquals(GestureHalfZone.Right, zone)
    }

    @Test
    fun `resolveTapZone returns center for middle third`() {
        val zone = GestureMath.resolveTapZone(startX = 500f, widthPx = 1200)

        assertEquals(GestureTapZone.Center, zone)
    }

    @Test
    fun `resolveAxis returns null before lock threshold`() {
        val axis = GestureMath.resolveAxis(deltaX = 8f, deltaY = 10f, lockDistancePx = 24f)

        assertNull(axis)
    }

    @Test
    fun `resolveAxis prefers vertical when vertical delta dominates past threshold`() {
        val axis = GestureMath.resolveAxis(deltaX = 16f, deltaY = -72f, lockDistancePx = 24f)

        assertEquals(GestureAxis.Vertical, axis)
    }

    @Test
    fun `onScroll emits volume delta for upward swipe on right half`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        controller.onTouchDown(startX = 900f, startY = 420f, widthPx = 1200)
        val handled = controller.onScroll(currentX = 920f, currentY = 120f)

        assertTrue(handled)
        assertEquals(listOf(2f), sink.volumeDeltas)
        assertTrue(sink.brightnessDeltas.isEmpty())
        assertTrue(sink.seekDeltas.isEmpty())
    }

    @Test
    fun `onScroll emits brightness delta for upward swipe on left half`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        controller.onTouchDown(startX = 180f, startY = 420f, widthPx = 1200)
        val handled = controller.onScroll(currentX = 200f, currentY = 120f)

        assertTrue(handled)
        assertEquals(listOf(0.1f), sink.brightnessDeltas)
        assertTrue(sink.volumeDeltas.isEmpty())
        assertTrue(sink.seekDeltas.isEmpty())
    }

    @Test
    fun `onScroll emits seek delta for horizontal swipe`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        controller.onTouchDown(startX = 320f, startY = 400f, widthPx = 1200)
        val handled = controller.onScroll(currentX = 500f, currentY = 415f)

        assertTrue(handled)
        assertEquals(listOf(18_000L), sink.seekDeltas)
    }

    @Test
    fun `onDoubleTap routes center zone to toggle playback`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        val handled = controller.onDoubleTap(tapX = 500f, widthPx = 1200)

        assertTrue(handled)
        assertEquals(1, sink.toggleCount)
        assertTrue(sink.seekDeltas.isEmpty())
    }

    @Test
    fun `onLongPress followed by onTouchEnd emits matching fast-forward callbacks`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        controller.onTouchDown(startX = 600f, startY = 400f, widthPx = 1200)
        assertTrue(controller.onLongPress())
        controller.onTouchEnd()

        assertEquals(listOf(2f), sink.fastForwardSpeeds)
        assertEquals(1, sink.fastForwardEndCount)
    }

    @Test
    fun `pinch activation emits zoom and suppresses swipe callbacks`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        controller.onTouchDown(startX = 600f, startY = 400f, widthPx = 1200)
        assertTrue(controller.onScaleBegin())
        assertTrue(controller.onScale(1.25f))

        val handled = controller.onScroll(currentX = 820f, currentY = 100f)

        assertFalse(handled)
        assertEquals(listOf(1.25f), sink.zoomFactors)
        assertTrue(sink.volumeDeltas.isEmpty())
        assertTrue(sink.brightnessDeltas.isEmpty())
        assertTrue(sink.seekDeltas.isEmpty())
    }

    @Test
    fun `onScale clamps emitted zoom factor to supported bounds`() {
        val sink = RecordingGestureSink()
        val controller = GestureSessionController(sink = sink)

        controller.onTouchDown(startX = 600f, startY = 400f, widthPx = 1200)
        assertTrue(controller.onScaleBegin())
        assertTrue(controller.onScale(4f))
        assertTrue(controller.onScale(0.2f))

        assertEquals(listOf(3f, 1f), sink.zoomFactors)
    }
}

private class RecordingGestureSink : GestureCallbackSink {
    val volumeDeltas = mutableListOf<Float>()
    val brightnessDeltas = mutableListOf<Float>()
    val seekDeltas = mutableListOf<Long>()
    val fastForwardSpeeds = mutableListOf<Float>()
    val zoomFactors = mutableListOf<Float>()
    var toggleCount: Int = 0
    var fastForwardEndCount: Int = 0

    override fun onVolumeDelta(delta: Float) {
        volumeDeltas += delta
    }

    override fun onBrightnessDelta(delta: Float) {
        brightnessDeltas += delta
    }

    override fun onSeekDelta(deltaMs: Long) {
        seekDeltas += deltaMs
    }

    override fun onTogglePlayPause() {
        toggleCount += 1
    }

    override fun onFastForwardStart(speed: Float) {
        fastForwardSpeeds += speed
    }

    override fun onFastForwardEnd() {
        fastForwardEndCount += 1
    }

    override fun onZoom(scaleFactor: Float) {
        zoomFactors += scaleFactor
    }
}
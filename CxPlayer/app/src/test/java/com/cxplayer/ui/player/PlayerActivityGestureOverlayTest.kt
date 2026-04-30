package com.cxplayer.ui.player

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class PlayerActivityGestureOverlayTest {
    @Test
    fun `volume overlay formats percent from current values`() {
        val state = GestureOverlayModel.formatVolume(percent = 75)

        assertEquals(GestureOverlayType.Volume, state.type)
        assertEquals("75%", state.valueText)
        assertTrue(state.isVisible)
    }

    @Test
    fun `seek overlay preserves sign and mm ss formatting`() {
        val state = GestureOverlayModel.formatSeekDelta(deltaMs = -30_000L)

        assertEquals(GestureOverlayType.SeekDelta, state.type)
        assertEquals("-00:30", state.valueText)
    }

    @Test
    fun `brightness overlay clamps percent to supported bounds`() {
        val state = GestureOverlayModel.formatBrightness(percent = 140)

        assertEquals(GestureOverlayType.Brightness, state.type)
        assertEquals("100%", state.valueText)
    }

    @Test
    fun `fast forward release schedules dismiss instead of keeping sticky`() {
        val visible = GestureOverlayModel.fastForwardActive(speedLabel = "2X")
        val released = GestureOverlayModel.scheduleDismiss(
            current = visible,
            updatedAtMs = 2_000L,
            autoDismissDelayMs = 1_000L
        )

        assertFalse(released.isStickyWhileGestureActive)
        assertEquals(3_000L, released.dismissDeadlineMs)
    }

    @Test
    fun `replacement keeps newest overlay type and content`() {
        val current = GestureOverlayModel.formatVolume(percent = 40)
        val replacement = GestureOverlayModel.replace(
            current = current,
            next = GestureOverlayModel.formatSeekDelta(deltaMs = 10_000L)
        )

        assertEquals(GestureOverlayType.SeekDelta, replacement.type)
        assertEquals("+00:10", replacement.valueText)
    }
}
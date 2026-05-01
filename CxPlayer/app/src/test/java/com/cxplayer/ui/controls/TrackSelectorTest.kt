package com.cxplayer.ui.controls

import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class TrackSelectorTest {
    @Test
    fun `popup placement aligns to anchor right edge and flips above near bottom`() {
        val placement = TrackSelector.resolvePopupPlacement(
            anchorLeft = 980,
            anchorTop = 1740,
            anchorWidth = 56,
            anchorHeight = 56,
            popupWidth = 320,
            popupHeight = 360,
            viewportLeft = 0,
            viewportTop = 0,
            viewportRight = 1080,
            viewportBottom = 1920,
            marginPx = 12
        )

        assertEquals(716, placement.x)
        assertTrue(placement.y < 1740)
    }

    @Test
    fun `popup placement clamps into viewport when preferred position overflows`() {
        val placement = TrackSelector.resolvePopupPlacement(
            anchorLeft = 20,
            anchorTop = 80,
            anchorWidth = 56,
            anchorHeight = 56,
            popupWidth = 400,
            popupHeight = 240,
            viewportLeft = 0,
            viewportTop = 0,
            viewportRight = 360,
            viewportBottom = 640,
            marginPx = 12
        )

        assertEquals(12, placement.x)
        assertEquals(136, placement.y)
    }
}
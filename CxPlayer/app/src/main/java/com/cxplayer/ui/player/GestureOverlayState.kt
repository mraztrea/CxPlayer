package com.cxplayer.ui.player

import java.util.Locale
import kotlin.math.abs

internal const val GESTURE_OVERLAY_AUTO_DISMISS_DELAY_MS = 1_000L

internal enum class GestureOverlayType {
    Volume,
    Brightness,
    SeekDelta,
    FastForward
}

internal data class GestureOverlayState(
    val type: GestureOverlayType,
    val cueText: String,
    val valueText: String,
    val isVisible: Boolean = true,
    val dismissDeadlineMs: Long? = null,
    val isStickyWhileGestureActive: Boolean = false
)

internal object GestureOverlayModel {
    fun formatVolume(percent: Int): GestureOverlayState {
        return GestureOverlayState(
            type = GestureOverlayType.Volume,
            cueText = "Am luong",
            valueText = formatPercent(percent)
        )
    }

    fun formatBrightness(percent: Int): GestureOverlayState {
        return GestureOverlayState(
            type = GestureOverlayType.Brightness,
            cueText = "Do sang",
            valueText = formatPercent(percent)
        )
    }

    fun formatSeekDelta(deltaMs: Long): GestureOverlayState {
        return GestureOverlayState(
            type = GestureOverlayType.SeekDelta,
            cueText = if (deltaMs >= 0L) "Tien" else "Lui",
            valueText = formatSignedDuration(deltaMs)
        )
    }

    fun fastForwardActive(speedLabel: String): GestureOverlayState {
        return GestureOverlayState(
            type = GestureOverlayType.FastForward,
            cueText = speedLabel,
            valueText = speedLabel,
            isStickyWhileGestureActive = true
        )
    }

    fun scheduleDismiss(
        current: GestureOverlayState,
        updatedAtMs: Long,
        autoDismissDelayMs: Long = GESTURE_OVERLAY_AUTO_DISMISS_DELAY_MS
    ): GestureOverlayState {
        return current.copy(
            isStickyWhileGestureActive = false,
            dismissDeadlineMs = updatedAtMs + autoDismissDelayMs
        )
    }

    fun replace(current: GestureOverlayState?, next: GestureOverlayState): GestureOverlayState {
        return next.copy(dismissDeadlineMs = current?.dismissDeadlineMs)
    }

    private fun formatPercent(percent: Int): String = "${percent.coerceIn(0, 100)}%"

    private fun formatSignedDuration(deltaMs: Long): String {
        val totalSeconds = abs(deltaMs) / 1_000L
        val minutes = (totalSeconds / 60L) % 60L
        val seconds = totalSeconds % 60L
        val prefix = if (deltaMs >= 0L) "+" else "-"
        return String.format(Locale.ROOT, "%s%02d:%02d", prefix, minutes, seconds)
    }
}
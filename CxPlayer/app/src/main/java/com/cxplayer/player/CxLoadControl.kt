package com.cxplayer.player

import androidx.media3.common.C
import androidx.media3.exoplayer.DefaultLoadControl

private const val NETWORK_MIN_BUFFER_MS = 50_000
private const val NETWORK_MAX_BUFFER_MS = 120_000
private const val NETWORK_BUFFER_FOR_PLAYBACK_MS = 2_500
private const val NETWORK_BUFFER_FOR_REBUFFER_MS = 5_000

internal data class CxLoadControlPolicySnapshot(
    val minBufferMs: Int,
    val maxBufferMs: Int,
    val bufferForPlaybackMs: Int,
    val bufferForRebufferMs: Int
)

internal fun cxLoadControlPolicySnapshot(): CxLoadControlPolicySnapshot {
    return CxLoadControlPolicySnapshot(
        minBufferMs = NETWORK_MIN_BUFFER_MS,
        maxBufferMs = NETWORK_MAX_BUFFER_MS,
        bufferForPlaybackMs = NETWORK_BUFFER_FOR_PLAYBACK_MS,
        bufferForRebufferMs = NETWORK_BUFFER_FOR_REBUFFER_MS
    )
}

internal fun buildCxLoadControl(): DefaultLoadControl {
    val policy = cxLoadControlPolicySnapshot()
    return DefaultLoadControl.Builder()
        .setBufferDurationsMs(
            policy.minBufferMs,
            policy.maxBufferMs,
            policy.bufferForPlaybackMs,
            policy.bufferForRebufferMs
        )
        .setTargetBufferBytes(C.LENGTH_UNSET)
        .setPrioritizeTimeOverSizeThresholds(true)
        .build()
}
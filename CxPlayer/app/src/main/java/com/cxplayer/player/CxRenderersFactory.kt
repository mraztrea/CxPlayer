package com.cxplayer.player

import android.content.Context
import androidx.media3.exoplayer.DefaultRenderersFactory

internal data class RendererPolicySnapshot(
    val extensionRendererMode: Int,
    val decoderFallbackEnabled: Boolean
)

internal fun cxRendererPolicySnapshot(): RendererPolicySnapshot {
    return RendererPolicySnapshot(
        extensionRendererMode = DefaultRenderersFactory.EXTENSION_RENDERER_MODE_PREFER,
        decoderFallbackEnabled = true
    )
}

internal class CxRenderersFactory(context: Context) : DefaultRenderersFactory(context) {
    init {
        val policy = cxRendererPolicySnapshot()
        setExtensionRendererMode(policy.extensionRendererMode)
        setEnableDecoderFallback(policy.decoderFallbackEnabled)
    }
}
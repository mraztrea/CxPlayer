package com.cxplayer.player

import android.content.Context
import androidx.media3.exoplayer.DefaultRenderersFactory
import androidx.media3.exoplayer.audio.AudioSink
import androidx.media3.exoplayer.audio.DefaultAudioSink

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
    val audioProcessor = CxAudioProcessor()

    init {
        val policy = cxRendererPolicySnapshot()
        setExtensionRendererMode(policy.extensionRendererMode)
        setEnableDecoderFallback(policy.decoderFallbackEnabled)
    }

    override fun buildAudioSink(
        context: Context,
        enableFloatOutput: Boolean,
        enableAudioTrackPlaybackParams: Boolean
    ): AudioSink? {
        return DefaultAudioSink.Builder(context)
            .setAudioProcessors(arrayOf(audioProcessor))
            .setEnableFloatOutput(enableFloatOutput)
            .setEnableAudioTrackPlaybackParams(enableAudioTrackPlaybackParams)
            .build()
    }
}
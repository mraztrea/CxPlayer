package com.cxplayer.player

import androidx.media3.common.audio.AudioProcessor
import androidx.media3.common.audio.BaseAudioProcessor
import java.nio.ByteBuffer
import java.nio.ByteOrder

/**
 * AudioProcessor trích xuất PCM data từ ExoPlayer audio pipeline.
 * Resample sang 16kHz mono PCM cho Soniox STT, pass-through audio nguyên bản.
 */
class CxAudioProcessor : BaseAudioProcessor() {
    var onPcmData: ((ByteArray) -> Unit)? = null

    override fun onConfigure(inputAudioFormat: AudioProcessor.AudioFormat): AudioProcessor.AudioFormat {
        // Accept any input format, output unchanged
        return inputAudioFormat
    }

    override fun queueInput(inputBuffer: ByteBuffer) {
        val listener = onPcmData
        if (listener != null && inputBuffer.hasRemaining()) {
            val inputFormat = inputAudioFormat
            val pcm = resampleTo16kMono(inputBuffer.duplicate(), inputFormat)
            if (pcm.isNotEmpty()) {
                listener(pcm)
            }
        }
        // Pass through unchanged to speakers
        val output = replaceOutputBuffer(inputBuffer.remaining())
        output.put(inputBuffer)
        output.flip()
    }

    private fun resampleTo16kMono(
        buffer: ByteBuffer,
        format: AudioProcessor.AudioFormat
    ): ByteArray {
        if (format.sampleRate <= 0 || format.channelCount <= 0) return ByteArray(0)

        buffer.order(ByteOrder.LITTLE_ENDIAN)
        val bytesPerSample = 2 // pcm_s16le
        val totalSamples = buffer.remaining() / (bytesPerSample * format.channelCount)
        if (totalSamples == 0) return ByteArray(0)

        // Read all samples as mono (average channels)
        val monoSamples = ShortArray(totalSamples)
        for (i in 0 until totalSamples) {
            var sum = 0L
            for (ch in 0 until format.channelCount) {
                sum += buffer.short
            }
            monoSamples[i] = (sum / format.channelCount).toInt().coerceIn(Short.MIN_VALUE.toInt(), Short.MAX_VALUE.toInt()).toShort()
        }

        // Resample to 16kHz using linear interpolation
        val targetRate = 16000
        val ratio = format.sampleRate.toDouble() / targetRate
        val outputSampleCount = (totalSamples / ratio).toInt()
        if (outputSampleCount == 0) return ByteArray(0)

        val outputBuffer = ByteBuffer.allocate(outputSampleCount * bytesPerSample)
        outputBuffer.order(ByteOrder.LITTLE_ENDIAN)

        for (i in 0 until outputSampleCount) {
            val srcPos = i * ratio
            val srcIndex = srcPos.toInt().coerceAtMost(totalSamples - 1)
            val nextIndex = (srcIndex + 1).coerceAtMost(totalSamples - 1)
            val frac = srcPos - srcIndex

            val sample = (monoSamples[srcIndex] * (1.0 - frac) + monoSamples[nextIndex] * frac).toInt()
                .coerceIn(Short.MIN_VALUE.toInt(), Short.MAX_VALUE.toInt())
            outputBuffer.putShort(sample.toShort())
        }

        return outputBuffer.array()
    }
}

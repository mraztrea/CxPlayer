package androidx.media3.decoder.ffmpeg;

import androidx.annotation.Nullable;
import androidx.media3.common.C;
import androidx.media3.common.Format;
import androidx.media3.common.MimeTypes;
import androidx.media3.common.util.ParsableByteArray;
import androidx.media3.common.util.UnstableApi;
import androidx.media3.common.util.Util;
import androidx.media3.decoder.DecoderInputBuffer;
import androidx.media3.decoder.SimpleDecoder;
import androidx.media3.decoder.SimpleDecoderOutputBuffer;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.Objects;

@UnstableApi
final class FfmpegAudioDecoder
        extends SimpleDecoder<DecoderInputBuffer, SimpleDecoderOutputBuffer, FfmpegDecoderException> {
    private static final int OUTPUT_BUFFER_SIZE_16BIT = 65536;
    private static final int OUTPUT_BUFFER_SIZE_32BIT = OUTPUT_BUFFER_SIZE_16BIT * 2;
    private static final int AUDIO_DECODER_ERROR_INVALID_DATA = -1;
    private static final int AUDIO_DECODER_ERROR_OTHER = -2;
    private static final int OUTPUT_MODE_DEFAULT = 0;

    private final String codecName;
    @Nullable
    private final byte[] extraData;
    private final @C.PcmEncoding int encoding;
    private final int outputBufferSize;
    private final int outputMode;

    private com.google.android.exoplayer2.ext.ffmpeg.FfmpegDecoder nativeDecoder;
    private long nativeContext;
    private boolean hasOutputFormat;
    private volatile int channelCount;
    private volatile int sampleRate;

    FfmpegAudioDecoder(
            Format format,
            int numInputBuffers,
            int numOutputBuffers,
            int initialInputBufferSize,
            boolean outputFloat)
            throws FfmpegDecoderException {
        super(new DecoderInputBuffer[numInputBuffers], new SimpleDecoderOutputBuffer[numOutputBuffers]);
        if (!FfmpegLibrary.isAvailable()) {
            throw new FfmpegDecoderException("Failed to load decoder native libraries.");
        }

        String sampleMimeType = Objects.requireNonNull(format.sampleMimeType);
        codecName = Objects.requireNonNull(FfmpegLibrary.getCodecName(sampleMimeType));
        extraData = getExtraData(sampleMimeType, format.initializationData);
        encoding = outputFloat ? C.ENCODING_PCM_FLOAT : C.ENCODING_PCM_16BIT;
        outputBufferSize = outputFloat ? OUTPUT_BUFFER_SIZE_32BIT : OUTPUT_BUFFER_SIZE_16BIT;
        outputMode = OUTPUT_MODE_DEFAULT;
        nativeContext = initializeNativeDecoder(outputFloat, format.sampleRate, format.channelCount);
        if (nativeContext == 0L) {
            throw new FfmpegDecoderException("Initialization failed.");
        }

        setInitialInputBufferSize(initialInputBufferSize);
    }

    @Override
    public String getName() {
        return "ffmpeg" + FfmpegLibrary.getVersion() + "-" + codecName;
    }

    @Override
    protected DecoderInputBuffer createInputBuffer() {
        return new DecoderInputBuffer(
                DecoderInputBuffer.BUFFER_REPLACEMENT_MODE_DIRECT,
                FfmpegLibrary.getInputBufferPaddingSize());
    }

    @Override
    protected SimpleDecoderOutputBuffer createOutputBuffer() {
        return new SimpleDecoderOutputBuffer(this::releaseOutputBuffer);
    }

    @Override
    protected FfmpegDecoderException createUnexpectedDecodeException(Throwable error) {
        return new FfmpegDecoderException("Unexpected decode error", error);
    }

    @Override
    @Nullable
    protected FfmpegDecoderException decode(
            DecoderInputBuffer inputBuffer,
            SimpleDecoderOutputBuffer outputBuffer,
            boolean reset) {
        if (reset) {
            nativeContext = nativeDecoder.reset(nativeContext, extraData);
            if (nativeContext == 0L) {
                return new FfmpegDecoderException("Error resetting (see logcat).");
            }
        }

        ByteBuffer inputData = Util.castNonNull(inputBuffer.data);
        int inputSize = inputData.limit();
        ByteBuffer outputData = outputBuffer.init(inputBuffer.timeUs, outputBufferSize);
        int result = nativeDecoder.decode(
                nativeContext,
                inputData,
                inputSize,
                outputData,
                outputBufferSize,
                outputMode);
        if (result == AUDIO_DECODER_ERROR_OTHER) {
            return new FfmpegDecoderException("Error decoding (see logcat).");
        } else if (result == AUDIO_DECODER_ERROR_INVALID_DATA || result == 0) {
            outputBuffer.shouldBeSkipped = true;
            return null;
        }

        if (!hasOutputFormat) {
            channelCount = nativeDecoder.getChannelCount(nativeContext);
            sampleRate = nativeDecoder.getSampleRate(nativeContext);
            if (sampleRate == 0 && "alac".equals(codecName)) {
                byte[] decoderExtraData = Objects.requireNonNull(extraData);
                ParsableByteArray parsableExtraData = new ParsableByteArray(decoderExtraData);
                parsableExtraData.setPosition(decoderExtraData.length - 4);
                sampleRate = parsableExtraData.readUnsignedIntToInt();
            }
            hasOutputFormat = true;
        }

        outputData.position(0);
        outputData.limit(result);
        return null;
    }

    @Override
    public void release() {
        super.release();
        nativeDecoder.release(nativeContext);
        nativeContext = 0L;
    }

    public int getChannelCount() {
        return channelCount;
    }

    public int getSampleRate() {
        return sampleRate;
    }

    public @C.PcmEncoding int getEncoding() {
        return encoding;
    }

    private long initializeNativeDecoder(boolean outputFloat, int rawSampleRate, int rawChannelCount) {
        boolean preferExDecoder = FfmpegLibrary.shouldUseExDecoder(codecName);
        nativeDecoder = new com.google.android.exoplayer2.ext.ffmpeg.FfmpegDecoder(preferExDecoder);
        long context = nativeDecoder.initialize(codecName, extraData, outputFloat, rawSampleRate, rawChannelCount);
        if (context != 0L || !preferExDecoder) {
            return context;
        }

        nativeDecoder = new com.google.android.exoplayer2.ext.ffmpeg.FfmpegDecoder(false);
        return nativeDecoder.initialize(codecName, extraData, outputFloat, rawSampleRate, rawChannelCount);
    }

    @Nullable
    private static byte[] getExtraData(String mimeType, List<byte[]> initializationData) {
        switch (mimeType) {
            case MimeTypes.AUDIO_AAC:
            case MimeTypes.AUDIO_OPUS:
                return initializationData.get(0);
            case MimeTypes.AUDIO_ALAC:
                return getAlacExtraData(initializationData);
            case MimeTypes.AUDIO_VORBIS:
                return getVorbisExtraData(initializationData);
            default:
                return null;
        }
    }

    private static byte[] getAlacExtraData(List<byte[]> initializationData) {
        byte[] magicCookie = initializationData.get(0);
        int alacAtomLength = 12 + magicCookie.length;
        ByteBuffer alacAtom = ByteBuffer.allocate(alacAtomLength);
        alacAtom.putInt(alacAtomLength);
        alacAtom.putInt(0x616c6163);
        alacAtom.putInt(0);
        alacAtom.put(magicCookie, 0, magicCookie.length);
        return alacAtom.array();
    }

    private static byte[] getVorbisExtraData(List<byte[]> initializationData) {
        byte[] header0 = initializationData.get(0);
        byte[] header1 = initializationData.get(1);
        byte[] extraData = new byte[header0.length + header1.length + 6];
        extraData[0] = (byte) (header0.length >> 8);
        extraData[1] = (byte) (header0.length & 0xFF);
        System.arraycopy(header0, 0, extraData, 2, header0.length);
        extraData[header0.length + 2] = 0;
        extraData[header0.length + 3] = 0;
        extraData[header0.length + 4] = (byte) (header1.length >> 8);
        extraData[header0.length + 5] = (byte) (header1.length & 0xFF);
        System.arraycopy(header1, 0, extraData, header0.length + 6, header1.length);
        return extraData;
    }
}
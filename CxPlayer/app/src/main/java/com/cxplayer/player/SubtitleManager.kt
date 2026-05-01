package com.cxplayer.player

import android.content.ContentResolver
import android.graphics.Color
import android.graphics.Typeface
import android.net.Uri
import android.util.TypedValue
import androidx.media3.common.C
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.Player
import androidx.media3.common.TrackSelectionOverride
import androidx.media3.ui.CaptionStyleCompat
import androidx.media3.ui.PlayerView
import java.io.File
import java.util.Locale

private const val DEFAULT_SUBTITLE_LANGUAGE = "vi"
private const val DEFAULT_SUBTITLE_FONT_SIZE_SP = 18
private const val OFF_SUBTITLE_SOURCE_ID = "subtitle_source_off"

internal enum class SubtitleSourceKind {
    Off,
    External,
    Embedded
}

internal enum class SubtitleEdgeMode {
    Outline,
    DropShadow,
    None
}

internal enum class SubtitleDetectionStatus {
    Found,
    NotFound,
    UnsupportedSource,
    Unreadable
}

internal data class SubtitleStyleState(
    val fontSizeSp: Int = DEFAULT_SUBTITLE_FONT_SIZE_SP,
    val isBold: Boolean = false,
    val foregroundColor: Int = Color.WHITE,
    val edgeMode: SubtitleEdgeMode = SubtitleEdgeMode.Outline,
    val edgeColor: Int = Color.BLACK
)

internal data class ResolvedSubtitleStyle(
    val fontSizeSp: Int,
    val foregroundColor: Int,
    val edgeColor: Int,
    val edgeType: Int,
    val useBoldTypeface: Boolean
)

internal data class SubtitleSourceDescriptor(
    val id: String,
    val kind: SubtitleSourceKind,
    val label: String,
    val languageTag: String?,
    val mimeType: String?,
    val uriValue: String?,
    val isAutoDetected: Boolean,
    val isCurrentlySelected: Boolean
)

internal data class SubtitleDetectionResult(
    val status: SubtitleDetectionStatus,
    val matchedFile: File?,
    val matchedMimeType: String?,
    val attemptedExtensions: List<String>
)

internal data class SubtitleSelectionState(
    val activeSourceId: String = OFF_SUBTITLE_SOURCE_ID,
    val textTrackDisabled: Boolean = true,
    val preservedPositionMs: Long = 0L,
    val preservedPlayWhenReady: Boolean = false
)

internal data class EmbeddedSubtitleTrack(
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String,
    val languageTag: String?,
    val isSelected: Boolean
)

internal interface SubtitleSessionController {
    val currentMediaItem: MediaItem?
    val currentPositionMs: Long
    val playWhenReady: Boolean

    fun setMediaItem(mediaItem: MediaItem, startPositionMs: Long)

    fun prepare()

    fun currentEmbeddedSubtitleTracks(): List<EmbeddedSubtitleTrack>

    fun enableTextTracks()

    fun disableTextTracks()

    fun selectEmbeddedSubtitle(groupIndex: Int, trackIndex: Int)
}

internal class PlayerSubtitleSessionController(
    private val player: Player
) : SubtitleSessionController {
    override val currentMediaItem: MediaItem?
        get() = player.currentMediaItem

    override val currentPositionMs: Long
        get() = player.currentPosition.coerceAtLeast(0L)

    override val playWhenReady: Boolean
        get() = player.playWhenReady

    override fun setMediaItem(mediaItem: MediaItem, startPositionMs: Long) {
        val preservedPlayWhenReady = player.playWhenReady
        player.setMediaItem(mediaItem, startPositionMs)
        player.playWhenReady = preservedPlayWhenReady
    }

    override fun prepare() {
        player.prepare()
    }

    override fun currentEmbeddedSubtitleTracks(): List<EmbeddedSubtitleTrack> {
        val tracks = mutableListOf<EmbeddedSubtitleTrack>()
        player.currentTracks.groups.forEachIndexed { groupIndex, group ->
            if (group.type != C.TRACK_TYPE_TEXT) {
                return@forEachIndexed
            }

            for (trackIndex in 0 until group.length) {
                val format = group.getTrackFormat(trackIndex)
                tracks += EmbeddedSubtitleTrack(
                    groupIndex = groupIndex,
                    trackIndex = trackIndex,
                    label = format.label ?: format.language ?: "Subtitle ${trackIndex + 1}",
                    languageTag = format.language,
                    isSelected = group.isTrackSelected(trackIndex)
                )
            }
        }
        return tracks
    }

    override fun enableTextTracks() {
        player.trackSelectionParameters = player.trackSelectionParameters
            .buildUpon()
            .setTrackTypeDisabled(C.TRACK_TYPE_TEXT, false)
            .build()
    }

    override fun disableTextTracks() {
        player.trackSelectionParameters = player.trackSelectionParameters
            .buildUpon()
            .clearOverridesOfType(C.TRACK_TYPE_TEXT)
            .setTrackTypeDisabled(C.TRACK_TYPE_TEXT, true)
            .build()
    }

    override fun selectEmbeddedSubtitle(groupIndex: Int, trackIndex: Int) {
        val trackGroup = player.currentTracks.groups.getOrNull(groupIndex)?.mediaTrackGroup ?: return
        val override = TrackSelectionOverride(trackGroup, listOf(trackIndex))
        player.trackSelectionParameters = player.trackSelectionParameters
            .buildUpon()
            .setTrackTypeDisabled(C.TRACK_TYPE_TEXT, false)
            .clearOverridesOfType(C.TRACK_TYPE_TEXT)
            .addOverride(override)
            .build()
    }
}

internal class SubtitleManager(
    private val sessionController: SubtitleSessionController,
    private val playerView: PlayerView? = null,
    private val contentResolver: ContentResolver? = null
) {
    private var styleState = SubtitleStyleState()
    private var selectionState = SubtitleSelectionState()
    private var externalSubtitleSource: SubtitleSourceDescriptor? = null
    private var stylePresetIndex: Int = 0

    fun currentStyleState(): SubtitleStyleState = styleState

    fun currentStylePresetIndex(): Int = stylePresetIndex

    fun currentSelectionState(): SubtitleSelectionState = selectionState

    fun availableSubtitleSources(): List<SubtitleSourceDescriptor> {
        val embeddedSources = sessionController.currentEmbeddedSubtitleTracks().map { track ->
            SubtitleSourceDescriptor(
                id = embeddedSourceId(track.groupIndex, track.trackIndex),
                kind = SubtitleSourceKind.Embedded,
                label = track.label,
                languageTag = track.languageTag,
                mimeType = null,
                uriValue = null,
                isAutoDetected = false,
                isCurrentlySelected = selectionState.activeSourceId == embeddedSourceId(track.groupIndex, track.trackIndex) &&
                    !selectionState.textTrackDisabled
            )
        }
        val sources = mutableListOf(
            SubtitleSourceDescriptor(
                id = OFF_SUBTITLE_SOURCE_ID,
                kind = SubtitleSourceKind.Off,
                label = "Off",
                languageTag = null,
                mimeType = null,
                uriValue = null,
                isAutoDetected = false,
                isCurrentlySelected = selectionState.textTrackDisabled
            )
        )
        externalSubtitleSource
            ?.copy(isCurrentlySelected = selectionState.activeSourceId == externalSubtitleSource?.id && !selectionState.textTrackDisabled)
            ?.let(sources::add)
        sources.addAll(embeddedSources)
        return sources
    }

    fun autoDetectExternalSubtitle(videoUri: Uri): SubtitleDetectionResult {
        return detectExternalSubtitle(
            videoPath = videoUri.path,
            scheme = videoUri.scheme
        )
    }

    internal fun detectExternalSubtitle(videoPath: String?, scheme: String?): SubtitleDetectionResult {
        val attemptedExtensions = supportedSubtitleExtensions()
        val normalizedScheme = scheme?.lowercase(Locale.ROOT)
        if (normalizedScheme != null && normalizedScheme != "file") {
            return SubtitleDetectionResult(
                status = SubtitleDetectionStatus.UnsupportedSource,
                matchedFile = null,
                matchedMimeType = null,
                attemptedExtensions = attemptedExtensions
            )
        }

        val resolvedVideoPath = videoPath
            ?.takeIf { it.isNotBlank() }
            ?: return SubtitleDetectionResult(
                status = SubtitleDetectionStatus.UnsupportedSource,
                matchedFile = null,
                matchedMimeType = null,
                attemptedExtensions = attemptedExtensions
            )

        val videoFile = File(resolvedVideoPath)
        val baseName = videoFile.absolutePath.substringBeforeLast('.', missingDelimiterValue = videoFile.absolutePath)
        attemptedExtensions.forEach { extension ->
            val subtitleFile = File(baseName + extension)
            if (subtitleFile.exists() && subtitleFile.isFile) {
                return SubtitleDetectionResult(
                    status = SubtitleDetectionStatus.Found,
                    matchedFile = subtitleFile,
                    matchedMimeType = resolveSubtitleMimeTypeFromName(subtitleFile.name),
                    attemptedExtensions = attemptedExtensions
                )
            }
        }

        return SubtitleDetectionResult(
            status = SubtitleDetectionStatus.NotFound,
            matchedFile = null,
            matchedMimeType = null,
            attemptedExtensions = attemptedExtensions
        )
    }

    fun loadExternalSubtitle(
        uri: Uri,
        mimeType: String = resolveSubtitleMimeType(uri) ?: MimeTypes.APPLICATION_SUBRIP,
        isAutoDetected: Boolean = false
    ): Boolean {
        val currentMediaItem = sessionController.currentMediaItem ?: return false
        val subtitleConfiguration = MediaItem.SubtitleConfiguration.Builder(uri)
            .setMimeType(mimeType)
            .setLanguage(DEFAULT_SUBTITLE_LANGUAGE)
            .setSelectionFlags(C.SELECTION_FLAG_DEFAULT)
            .build()
        val updatedItem = currentMediaItem.buildUpon()
            .setSubtitleConfigurations(listOf(subtitleConfiguration))
            .build()

        recordExternalSubtitleSelection(
            sourceId = externalSourceId(uri),
            label = uri.lastPathSegment?.substringAfterLast('/') ?: "External subtitle",
            mimeType = mimeType,
            uriValue = uri.toString(),
            isAutoDetected = isAutoDetected
        )
        sessionController.enableTextTracks()
        sessionController.setMediaItem(updatedItem, selectionState.preservedPositionMs)
        sessionController.prepare()
        return true
    }

    internal fun recordExternalSubtitleSelection(
        sourceId: String,
        label: String,
        mimeType: String,
        uriValue: String,
        isAutoDetected: Boolean
    ): SubtitleSelectionState {
        selectionState = selectionState.copy(
            activeSourceId = sourceId,
            textTrackDisabled = false,
            preservedPositionMs = sessionController.currentPositionMs,
            preservedPlayWhenReady = sessionController.playWhenReady
        )
        externalSubtitleSource = SubtitleSourceDescriptor(
            id = sourceId,
            kind = SubtitleSourceKind.External,
            label = label,
            languageTag = DEFAULT_SUBTITLE_LANGUAGE,
            mimeType = mimeType,
            uriValue = uriValue,
            isAutoDetected = isAutoDetected,
            isCurrentlySelected = true
        )
        return selectionState
    }

    fun selectSubtitleSource(sourceId: String): Boolean {
        if (sourceId == OFF_SUBTITLE_SOURCE_ID) {
            disableSubtitles()
            return true
        }

        externalSubtitleSource
            ?.takeIf { it.id == sourceId }
            ?.let { source ->
                selectionState = selectionState.copy(
                    activeSourceId = source.id,
                    textTrackDisabled = false,
                    preservedPositionMs = sessionController.currentPositionMs,
                    preservedPlayWhenReady = sessionController.playWhenReady
                )
                sessionController.enableTextTracks()
                return true
            }

        sessionController.currentEmbeddedSubtitleTracks().forEach { track ->
            if (embeddedSourceId(track.groupIndex, track.trackIndex) != sourceId) {
                return@forEach
            }
            selectionState = selectionState.copy(
                activeSourceId = sourceId,
                textTrackDisabled = false,
                preservedPositionMs = sessionController.currentPositionMs,
                preservedPlayWhenReady = sessionController.playWhenReady
            )
            sessionController.selectEmbeddedSubtitle(track.groupIndex, track.trackIndex)
            return true
        }

        return false
    }

    fun disableSubtitles() {
        selectionState = selectionState.copy(
            activeSourceId = OFF_SUBTITLE_SOURCE_ID,
            textTrackDisabled = true,
            preservedPositionMs = sessionController.currentPositionMs,
            preservedPlayWhenReady = sessionController.playWhenReady
        )
        sessionController.disableTextTracks()
    }

    fun applySubtitleStyle(newStyleState: SubtitleStyleState): SubtitleStyleState {
        styleState = newStyleState
        applyStyleToView()
        return styleState
    }

    fun applyStylePreset(presetIndex: Int): SubtitleStyleState {
        val normalizedIndex = ((presetIndex % STYLE_PRESETS.size) + STYLE_PRESETS.size) % STYLE_PRESETS.size
        stylePresetIndex = normalizedIndex
        return applySubtitleStyle(STYLE_PRESETS[stylePresetIndex])
    }

    fun cycleStylePreset(): SubtitleStyleState {
        return applyStylePreset(stylePresetIndex + 1)
    }

    fun resolveSubtitleMimeType(uri: Uri): String? {
        return resolveSubtitleMimeTypeFromName(
            fileName = uri.lastPathSegment,
            explicitMimeType = contentResolver
                ?.getType(uri)
                ?.takeIf { it.isNotBlank() }
        )
    }

    internal fun resolveSubtitleMimeTypeFromName(
        fileName: String?,
        explicitMimeType: String? = null
    ): String? {
        return explicitMimeType ?: when (fileName?.substringAfterLast('.', missingDelimiterValue = "")?.lowercase(Locale.ROOT)) {
            "srt" -> MimeTypes.APPLICATION_SUBRIP
            "ass", "ssa" -> MimeTypes.TEXT_SSA
            "vtt" -> MimeTypes.TEXT_VTT
            else -> null
        }
    }

    internal fun resolvedStyleState(styleState: SubtitleStyleState = this.styleState): ResolvedSubtitleStyle {
        return ResolvedSubtitleStyle(
            fontSizeSp = styleState.fontSizeSp,
            foregroundColor = styleState.foregroundColor,
            edgeColor = styleState.edgeColor,
            edgeType = resolveEdgeType(styleState.edgeMode),
            useBoldTypeface = styleState.isBold
        )
    }

    private fun applyStyleToView() {
        val subtitleView = playerView?.subtitleView ?: return
        val resolvedStyle = resolvedStyleState()
        val typeface = if (resolvedStyle.useBoldTypeface) Typeface.DEFAULT_BOLD else Typeface.DEFAULT
        subtitleView.setStyle(
            CaptionStyleCompat(
                resolvedStyle.foregroundColor,
                Color.TRANSPARENT,
                Color.TRANSPARENT,
                resolvedStyle.edgeType,
                resolvedStyle.edgeColor,
                typeface
            )
        )
        subtitleView.setFixedTextSize(TypedValue.COMPLEX_UNIT_SP, resolvedStyle.fontSizeSp.toFloat())
    }

    private fun resolveEdgeType(edgeMode: SubtitleEdgeMode): Int {
        return when (edgeMode) {
            SubtitleEdgeMode.Outline -> CaptionStyleCompat.EDGE_TYPE_OUTLINE
            SubtitleEdgeMode.DropShadow -> CaptionStyleCompat.EDGE_TYPE_DROP_SHADOW
            SubtitleEdgeMode.None -> CaptionStyleCompat.EDGE_TYPE_NONE
        }
    }

    companion object {
        private val STYLE_PRESETS = listOf(
            SubtitleStyleState(),
            SubtitleStyleState(fontSizeSp = 20, isBold = true, foregroundColor = Color.YELLOW),
            SubtitleStyleState(fontSizeSp = 22, isBold = true, foregroundColor = Color.WHITE, edgeMode = SubtitleEdgeMode.DropShadow)
        )

        internal fun supportedSubtitleExtensions(): List<String> = listOf(".srt", ".ass", ".ssa", ".vtt")

        internal fun externalSourceId(uri: Uri): String = "external:${uri}"

        internal fun embeddedSourceId(groupIndex: Int, trackIndex: Int): String =
            "embedded:${groupIndex}:${trackIndex}"
    }
}
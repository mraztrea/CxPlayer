package com.cxplayer.player

import android.content.ContentResolver
import android.database.Cursor
import android.graphics.Color
import android.graphics.Typeface
import android.net.Uri
import android.os.Environment
import android.provider.OpenableColumns
import android.util.Log
import android.provider.DocumentsContract
import android.provider.MediaStore
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

internal data class DetectedSubtitleFile(
    val file: File,
    val mimeType: String?
)

internal data class SubtitleDetectionResult(
    val status: SubtitleDetectionStatus,
    val matchedFiles: List<DetectedSubtitleFile>,
    val attemptedExtensions: List<String>
) {
    val matchedFile: File?
        get() = matchedFiles.firstOrNull()?.file

    val matchedMimeType: String?
        get() = matchedFiles.firstOrNull()?.mimeType
}

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
    private var externalSubtitleSources: List<SubtitleSourceDescriptor> = emptyList()
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
        sources.addAll(
            externalSubtitleSources.map { source ->
                source.copy(
                    isCurrentlySelected = selectionState.activeSourceId == source.id && !selectionState.textTrackDisabled
                )
            }
        )
        sources.addAll(embeddedSources)
        return sources
    }

    fun autoDetectExternalSubtitle(videoUri: Uri): SubtitleDetectionResult {
        val resolvedPath = resolveVideoPathForDetection(videoUri)
        Log.d(TAG, "autoDetect: uri=$videoUri, scheme=${videoUri.scheme}, path=${videoUri.path}, resolvedPath=$resolvedPath")
        val result = detectExternalSubtitle(
            videoPath = videoUri.path,
            scheme = videoUri.scheme,
            resolvedLocalPath = resolvedPath
        )
        Log.d(TAG, "autoDetect: status=${result.status}, matchedFiles=${result.matchedFiles.map { it.file.name }}")
        syncDetectedExternalSubtitleSources(result.matchedFiles)
        return result
    }

    internal fun detectExternalSubtitle(
        videoPath: String?,
        scheme: String?,
        resolvedLocalPath: String? = null
    ): SubtitleDetectionResult {
        val attemptedExtensions = supportedSubtitleExtensions()
        val normalizedScheme = scheme?.lowercase(Locale.ROOT)
        if (normalizedScheme != null && normalizedScheme != "file" && resolvedLocalPath.isNullOrBlank()) {
            return SubtitleDetectionResult(
                status = SubtitleDetectionStatus.UnsupportedSource,
                matchedFiles = emptyList(),
                attemptedExtensions = attemptedExtensions
            )
        }

        val resolvedVideoPath = resolvedLocalPath
            ?.takeIf { it.isNotBlank() }
            ?: videoPath?.takeIf { it.isNotBlank() }
            ?: return SubtitleDetectionResult(
                status = SubtitleDetectionStatus.UnsupportedSource,
                matchedFiles = emptyList(),
                attemptedExtensions = attemptedExtensions
            )

        val videoFile = File(resolvedVideoPath)
        val siblingFiles = listSiblingFiles(videoFile)
            ?: return SubtitleDetectionResult(
                status = SubtitleDetectionStatus.Unreadable,
                matchedFiles = emptyList(),
                attemptedExtensions = attemptedExtensions
            )

        val videoBaseName = videoFile.nameWithoutExtension
        val matchedFiles = siblingFiles
            .mapNotNull { candidateFile ->
                val mimeType = resolveSubtitleMimeTypeFromName(candidateFile.name) ?: return@mapNotNull null
                if (!matchesSubtitleFilePattern(videoBaseName, candidateFile.name)) {
                    return@mapNotNull null
                }
                DetectedSubtitleFile(
                    file = candidateFile,
                    mimeType = mimeType
                )
            }
            .sortedWith(
                compareBy<DetectedSubtitleFile>(
                    { !isExactSubtitleFileMatch(videoBaseName, it.file.name) },
                    { it.file.name.lowercase(Locale.ROOT) }
                )
            )
            .toList()

        if (matchedFiles.isNotEmpty()) {
            return SubtitleDetectionResult(
                status = SubtitleDetectionStatus.Found,
                matchedFiles = matchedFiles,
                attemptedExtensions = attemptedExtensions
            )
        }

        return SubtitleDetectionResult(
            status = SubtitleDetectionStatus.NotFound,
            matchedFiles = emptyList(),
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
        externalSubtitleSources = upsertExternalSubtitleSource(
            SubtitleSourceDescriptor(
                id = sourceId,
                kind = SubtitleSourceKind.External,
                label = label,
                languageTag = DEFAULT_SUBTITLE_LANGUAGE,
                mimeType = mimeType,
                uriValue = uriValue,
                isAutoDetected = isAutoDetected,
                isCurrentlySelected = true
            )
        )
        return selectionState
    }

    fun selectSubtitleSource(sourceId: String): Boolean {
        if (sourceId == OFF_SUBTITLE_SOURCE_ID) {
            disableSubtitles()
            return true
        }

        externalSubtitleSources
            .firstOrNull { it.id == sourceId }
            ?.let { source ->
                return selectExternalSubtitleSource(source)
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

    internal fun syncDetectedExternalSubtitleSources(matchedFiles: List<DetectedSubtitleFile>) {
        val detectedSources = matchedFiles.map { detectedFile ->
            val uriValue = "file://${detectedFile.file.absolutePath}"
            SubtitleSourceDescriptor(
                id = externalSourceId(uriValue),
                kind = SubtitleSourceKind.External,
                label = detectedFile.file.name,
                languageTag = resolveLanguageTagFromSubtitleFileName(detectedFile.file.name),
                mimeType = detectedFile.mimeType,
                uriValue = uriValue,
                isAutoDetected = true,
                isCurrentlySelected = selectionState.activeSourceId == externalSourceId(uriValue) && !selectionState.textTrackDisabled
            )
        }
        val manualSources = externalSubtitleSources.filterNot { it.isAutoDetected }
        externalSubtitleSources = detectedSources + manualSources.filterNot { manualSource ->
            detectedSources.any { detectedSource -> detectedSource.id == manualSource.id }
        }
    }

    private fun selectExternalSubtitleSource(source: SubtitleSourceDescriptor): Boolean {
        if (selectionState.activeSourceId == source.id && !selectionState.textTrackDisabled) {
            selectionState = selectionState.copy(
                activeSourceId = source.id,
                textTrackDisabled = false,
                preservedPositionMs = sessionController.currentPositionMs,
                preservedPlayWhenReady = sessionController.playWhenReady
            )
            sessionController.enableTextTracks()
            return true
        }

        val sourceUri = source.uriValue?.let(Uri::parse) ?: return false
        val mimeType = source.mimeType ?: resolveSubtitleMimeTypeFromName(source.label) ?: MimeTypes.APPLICATION_SUBRIP
        return loadExternalSubtitle(
            uri = sourceUri,
            mimeType = mimeType,
            isAutoDetected = source.isAutoDetected
        )
    }

    private fun upsertExternalSubtitleSource(source: SubtitleSourceDescriptor): List<SubtitleSourceDescriptor> {
        val existingIndex = externalSubtitleSources.indexOfFirst { it.id == source.id }
        if (existingIndex < 0) {
            return externalSubtitleSources + source
        }

        return externalSubtitleSources.toMutableList().apply {
            set(existingIndex, source)
        }
    }

    private fun resolveLanguageTagFromSubtitleFileName(fileName: String): String? {
        val fileNameWithoutExtension = fileName.substringBeforeLast('.', missingDelimiterValue = fileName)
        return fileNameWithoutExtension.substringAfterLast('.', missingDelimiterValue = "")
            .takeIf { it.isNotBlank() }
            ?.takeIf { it.length in 2..8 }
            ?.lowercase(Locale.ROOT)
    }

    private fun resolveVideoPathForDetection(videoUri: Uri): String? {
        val normalizedScheme = videoUri.scheme?.lowercase(Locale.ROOT)
        return when (normalizedScheme) {
            null, "file" -> videoUri.path?.takeIf(::pathExists)
            "content" -> resolveContentVideoPath(videoUri)
            else -> null
        }
    }

    private fun resolveContentVideoPath(videoUri: Uri): String? {
        resolvePathFromDocumentId(videoUri)
            ?.let {
                Log.d(TAG, "resolveContent: found via documentId: $it")
                return it
            }

        val resolver = contentResolver ?: return null
        val projection = arrayOf("_data", MediaStore.MediaColumns.RELATIVE_PATH, MediaStore.MediaColumns.DISPLAY_NAME)
        val cursor = runCatching {
            resolver.query(videoUri, projection, null, null, null)
        }.getOrNull() ?: return null

        cursor.use { contentCursor ->
            if (!contentCursor.moveToFirst()) {
                return null
            }

            readStringColumn(contentCursor, "_data")
                ?.let {
                    Log.d(TAG, "resolveContent: found via _data: $it")
                    return it
                }

            val relativePath = readStringColumn(contentCursor, MediaStore.MediaColumns.RELATIVE_PATH)
            val displayName = readStringColumn(contentCursor, MediaStore.MediaColumns.DISPLAY_NAME)
            Log.d(TAG, "resolveContent: relativePath=$relativePath, displayName=$displayName")
            buildPrimaryExternalStoragePath(relativePath, displayName)
                ?.let {
                    Log.d(TAG, "resolveContent: found via relativePath+displayName: $it")
                    return it
                }
        }

        // Fallback: resolve display name from OpenableColumns then search in MediaStore
        resolvePathViaDisplayNameSearch(videoUri)?.let {
            Log.d(TAG, "resolveContent: found via displayName search: $it")
            return it
        }

        Log.d(TAG, "resolveContent: all resolve methods failed for $videoUri")
        return null
    }

    private fun resolvePathFromDocumentId(videoUri: Uri): String? {
        val documentId = runCatching {
            DocumentsContract.getDocumentId(videoUri)
        }.getOrNull() ?: return null

        if (documentId.startsWith("raw:", ignoreCase = true)) {
            return documentId.removePrefix("raw:")
        }

        val volumeName = documentId.substringBefore(':', missingDelimiterValue = "")
        val relativePath = documentId.substringAfter(':', missingDelimiterValue = "")
        if (volumeName.isBlank() || relativePath.isBlank()) {
            return null
        }

        val storageRoot = if (volumeName.equals("primary", ignoreCase = true)) {
            @Suppress("DEPRECATION")
            Environment.getExternalStorageDirectory()
        } else {
            File("/storage/$volumeName")
        }
        return File(storageRoot, relativePath).absolutePath
    }

    private fun readStringColumn(cursor: Cursor, columnName: String): String? {
        val columnIndex = cursor.getColumnIndex(columnName)
        if (columnIndex < 0 || cursor.isNull(columnIndex)) {
            return null
        }
        return cursor.getString(columnIndex)?.takeIf { it.isNotBlank() }
    }

    private fun buildPrimaryExternalStoragePath(relativePath: String?, displayName: String?): String? {
        val normalizedRelativePath = relativePath?.takeIf { it.isNotBlank() } ?: return null
        val normalizedDisplayName = displayName?.takeIf { it.isNotBlank() } ?: return null
        @Suppress("DEPRECATION")
        val externalRoot = Environment.getExternalStorageDirectory()
        return File(File(externalRoot, normalizedRelativePath), normalizedDisplayName).absolutePath
    }

    private fun resolvePathViaDisplayNameSearch(videoUri: Uri): String? {
        val resolver = contentResolver ?: return null

        // Step 1: Get display name from OpenableColumns
        val displayName = runCatching {
            resolver.query(videoUri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
        }.getOrNull()?.use { cursor ->
            if (cursor.moveToFirst()) {
                readStringColumn(cursor, OpenableColumns.DISPLAY_NAME)
            } else null
        } ?: return null

        Log.d(TAG, "resolveViaDisplayName: displayName=$displayName")

        // Step 2: Search MediaStore.Files for this exact filename
        val projection = arrayOf(MediaStore.MediaColumns.DATA, MediaStore.MediaColumns.RELATIVE_PATH)
        val selection = "${MediaStore.MediaColumns.DISPLAY_NAME} = ?"
        val selectionArgs = arrayOf(displayName)

        runCatching {
            resolver.query(
                MediaStore.Files.getContentUri("external"),
                projection, selection, selectionArgs, null
            )
        }.getOrNull()?.use { cursor ->
            if (cursor.moveToFirst()) {
                readStringColumn(cursor, MediaStore.MediaColumns.DATA)
                    ?.let { return it }

                val relativePath = readStringColumn(cursor, MediaStore.MediaColumns.RELATIVE_PATH)
                buildPrimaryExternalStoragePath(relativePath, displayName)
                    ?.let { return it }
            }
        }

        // Step 3: Try common storage directories
        @Suppress("DEPRECATION")
        val externalRoot = Environment.getExternalStorageDirectory()
        val commonDirs = listOf(
            "", "Download", "Downloads", "Movies", "Video", "Videos",
            "DCIM", "Documents", "Media"
        )
        for (dir in commonDirs) {
            val candidate = File(File(externalRoot, dir), displayName)
            if (candidate.exists() && candidate.isFile) {
                Log.d(TAG, "resolveViaDisplayName: found in common dir: ${candidate.absolutePath}")
                return candidate.absolutePath
            }
        }

        return null
    }

    private fun pathExists(path: String): Boolean = File(path).exists()

    private fun listSiblingFiles(videoFile: File): List<File>? {
        val parent = videoFile.parentFile ?: return null
        val files = parent.listFiles()
        if (files != null) return files.toList()

        val mediaStoreResults = querySiblingsFromMediaStore(parent.absolutePath)
        if (mediaStoreResults.isNotEmpty()) return mediaStoreResults

        val probedFiles = probeSubtitleFilesByPattern(parent, videoFile.nameWithoutExtension)
        return probedFiles.ifEmpty { null }
    }

    private fun probeSubtitleFilesByPattern(parentDir: File, videoBaseName: String): List<File> {
        val results = mutableListOf<File>()
        val extensions = supportedSubtitleExtensions()

        for (ext in extensions) {
            val exactMatch = File(parentDir, "$videoBaseName$ext")
            if (exactMatch.exists() && exactMatch.isFile) {
                results.add(exactMatch)
            }
        }

        val commonLanguageCodes = listOf(
            "vi", "en", "ja", "ko", "zh", "fr", "de", "es",
            "pt", "ru", "th", "id", "ar", "hi", "it", "pl"
        )
        for (lang in commonLanguageCodes) {
            for (ext in extensions) {
                val langMatch = File(parentDir, "$videoBaseName.$lang$ext")
                if (langMatch.exists() && langMatch.isFile) {
                    results.add(langMatch)
                }
            }
        }

        return results.distinctBy { it.absolutePath }
    }

    private fun querySiblingsFromMediaStore(parentPath: String): List<File> {
        val resolver = contentResolver ?: return emptyList()
        val results = mutableListOf<File>()
        val projection = arrayOf(MediaStore.MediaColumns.DATA)
        val selection = "${MediaStore.MediaColumns.DATA} LIKE ? AND ${MediaStore.MediaColumns.DATA} NOT LIKE ?"
        val selectionArgs = arrayOf("$parentPath/%", "$parentPath/%/%")

        runCatching {
            resolver.query(
                MediaStore.Files.getContentUri("external"),
                projection,
                selection,
                selectionArgs,
                null
            )?.use { cursor ->
                val dataIndex = cursor.getColumnIndex(MediaStore.MediaColumns.DATA)
                if (dataIndex >= 0) {
                    while (cursor.moveToNext()) {
                        cursor.getString(dataIndex)?.let { path ->
                            results.add(File(path))
                        }
                    }
                }
            }
        }
        return results
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
        private const val TAG = "SubtitleManager"

        private val STYLE_PRESETS = listOf(
            SubtitleStyleState(),
            SubtitleStyleState(fontSizeSp = 20, isBold = true, foregroundColor = Color.YELLOW),
            SubtitleStyleState(fontSizeSp = 22, isBold = true, foregroundColor = Color.WHITE, edgeMode = SubtitleEdgeMode.DropShadow)
        )

        internal fun isOffSourceId(sourceId: String): Boolean = sourceId == OFF_SUBTITLE_SOURCE_ID

        internal fun matchesSubtitleFilePattern(videoBaseName: String, fileName: String): Boolean {
            val candidateBaseName = fileName.substringBeforeLast('.', missingDelimiterValue = fileName)
            if (candidateBaseName.equals(videoBaseName, ignoreCase = true)) {
                return true
            }

            if (!candidateBaseName.startsWith("$videoBaseName.", ignoreCase = true)) {
                return false
            }

            val suffix = candidateBaseName.substring(videoBaseName.length + 1)
            return suffix.isNotBlank() && !suffix.contains('.')
        }

        internal fun isExactSubtitleFileMatch(videoBaseName: String, fileName: String): Boolean {
            return fileName.substringBeforeLast('.', missingDelimiterValue = fileName)
                .equals(videoBaseName, ignoreCase = true)
        }

        internal fun supportedSubtitleExtensions(): List<String> = listOf(".srt", ".ass", ".ssa", ".vtt")

        internal fun externalSourceId(uriValue: String): String = "external:$uriValue"

        internal fun externalSourceId(uri: Uri): String = "external:${uri}"

        internal fun embeddedSourceId(groupIndex: Int, trackIndex: Int): String =
            "embedded:${groupIndex}:${trackIndex}"
    }
}
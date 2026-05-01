package com.cxplayer.player

import androidx.media3.common.C
import androidx.media3.common.Format
import androidx.media3.common.Player
import androidx.media3.common.TrackSelectionOverride
import java.util.Locale

internal data class AudioTrackDescriptor(
    val id: String,
    val groupIndex: Int,
    val trackIndex: Int,
    val label: String,
    val languageTag: String?,
    val isSelected: Boolean,
    val isSelectable: Boolean
)

internal interface TrackSelectorSessionController {
    fun currentAudioTracks(): List<AudioTrackDescriptor>

    fun selectAudioTrack(groupIndex: Int, trackIndex: Int): Boolean
}

internal class PlayerTrackSelectorSessionController(
    private val player: Player
) : TrackSelectorSessionController {
    override fun currentAudioTracks(): List<AudioTrackDescriptor> {
        val descriptors = mutableListOf<AudioTrackDescriptor>()
        player.currentTracks.groups.forEachIndexed { groupIndex, group ->
            if (group.type != C.TRACK_TYPE_AUDIO) {
                return@forEachIndexed
            }

            for (trackIndex in 0 until group.length) {
                val format = group.getTrackFormat(trackIndex)
                descriptors += AudioTrackDescriptor(
                    id = audioSourceId(groupIndex, trackIndex),
                    groupIndex = groupIndex,
                    trackIndex = trackIndex,
                    label = resolveAudioTrackLabel(format, trackIndex),
                    languageTag = format.language,
                    isSelected = group.isTrackSelected(trackIndex),
                    isSelectable = group.isTrackSupported(trackIndex)
                )
            }
        }
        return descriptors
    }

    override fun selectAudioTrack(groupIndex: Int, trackIndex: Int): Boolean {
        val trackGroup = player.currentTracks.groups.getOrNull(groupIndex) ?: return false
        if (trackGroup.type != C.TRACK_TYPE_AUDIO || trackIndex !in 0 until trackGroup.length) {
            return false
        }

        val override = TrackSelectionOverride(trackGroup.mediaTrackGroup, listOf(trackIndex))
        player.trackSelectionParameters = player.trackSelectionParameters
            .buildUpon()
            .setTrackTypeDisabled(C.TRACK_TYPE_AUDIO, false)
            .clearOverridesOfType(C.TRACK_TYPE_AUDIO)
            .addOverride(override)
            .build()
        return true
    }

    companion object {
        internal fun audioSourceId(groupIndex: Int, trackIndex: Int): String =
            "audio:$groupIndex:$trackIndex"

        internal fun resolveAudioTrackLabel(
            format: Format,
            trackIndex: Int
        ): String {
            return resolveAudioTrackLabel(
                label = format.label,
                languageTag = format.language,
                channelCount = format.channelCount,
                sampleMimeType = format.sampleMimeType,
                trackIndex = trackIndex
            )
        }

        internal fun resolveAudioTrackLabel(
            label: String?,
            languageTag: String?,
            channelCount: Int,
            sampleMimeType: String?,
            trackIndex: Int
        ): String {
            label
                ?.takeIf { it.isNotBlank() }
                ?.let { return it }

            val parts = mutableListOf<String>()
            resolveLanguageLabel(languageTag)?.let(parts::add)
            resolveChannelLayoutLabel(channelCount)?.let(parts::add)
            resolveMimeTypeLabel(sampleMimeType)?.let(parts::add)

            return parts.joinToString(" ").ifBlank { "Audio ${trackIndex + 1}" }
        }

        private fun resolveLanguageLabel(languageTag: String?): String? {
            val normalizedLanguageTag = languageTag?.trim().orEmpty()
            if (normalizedLanguageTag.isEmpty()) {
                return null
            }

            val locale = Locale.forLanguageTag(normalizedLanguageTag)
            return locale.getDisplayLanguage(Locale.ENGLISH)
                .takeIf { it.isNotBlank() }
                ?.replaceFirstChar { character ->
                    if (character.isLowerCase()) {
                        character.titlecase(Locale.ENGLISH)
                    } else {
                        character.toString()
                    }
                }
                ?: normalizedLanguageTag
        }

        private fun resolveChannelLayoutLabel(channelCount: Int): String? {
            return when {
                channelCount <= 0 -> null
                channelCount == 1 -> "Mono"
                channelCount == 2 -> "Stereo"
                channelCount == 6 -> "5.1"
                channelCount == 8 -> "7.1"
                else -> "$channelCount ch"
            }
        }

        private fun resolveMimeTypeLabel(sampleMimeType: String?): String? {
            return sampleMimeType
                ?.substringAfterLast('/')
                ?.takeIf { it.isNotBlank() }
                ?.replace('-', ' ')
                ?.uppercase(Locale.ENGLISH)
        }
    }
}
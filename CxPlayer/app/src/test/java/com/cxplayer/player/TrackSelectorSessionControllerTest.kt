package com.cxplayer.player

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class TrackSelectorSessionControllerTest {
    @Test
    fun `audio source id stays stable for group and track indices`() {
        assertEquals(
            "audio:2:1",
            PlayerTrackSelectorSessionController.audioSourceId(2, 1)
        )
    }

    @Test
    fun `audio track label prefers explicit format label`() {
        val label = PlayerTrackSelectorSessionController.resolveAudioTrackLabel(
            label = "English 5.1 (AC3)",
            languageTag = "en",
            channelCount = 6,
            sampleMimeType = "audio/ac3",
            trackIndex = 0
        )

        assertEquals("English 5.1 (AC3)", label)
    }

    @Test
    fun `audio track label falls back to language channels and mime type`() {
        val label = PlayerTrackSelectorSessionController.resolveAudioTrackLabel(
            label = null,
            languageTag = "en",
            channelCount = 6,
            sampleMimeType = "audio/ac3",
            trackIndex = 0
        )

        assertEquals("English 5.1 AC3", label)
    }

    @Test
    fun `audio track label falls back to index when metadata is missing`() {
        val label = PlayerTrackSelectorSessionController.resolveAudioTrackLabel(
            label = null,
            languageTag = null,
            channelCount = 0,
            sampleMimeType = null,
            trackIndex = 2
        )

        assertEquals("Audio 3", label)
    }

    @Test
    fun `fake controller updates selected track when selection succeeds`() {
        val controller = FakeTrackSelectorSessionController(
            tracks = listOf(
                AudioTrackDescriptor(
                    id = "audio:0:0",
                    groupIndex = 0,
                    trackIndex = 0,
                    label = "English Stereo",
                    languageTag = "en",
                    isSelected = true,
                    isSelectable = true
                ),
                AudioTrackDescriptor(
                    id = "audio:0:1",
                    groupIndex = 0,
                    trackIndex = 1,
                    label = "Vietnamese Stereo",
                    languageTag = "vi",
                    isSelected = false,
                    isSelectable = true
                )
            )
        )

        val selected = controller.selectAudioTrack(groupIndex = 0, trackIndex = 1)

        assertTrue(selected)
        assertFalse(controller.currentAudioTracks().first().isSelected)
        assertTrue(controller.currentAudioTracks()[1].isSelected)
    }
}

private class FakeTrackSelectorSessionController(
    tracks: List<AudioTrackDescriptor>
) : TrackSelectorSessionController {
    private var currentTracks = tracks

    override fun currentAudioTracks(): List<AudioTrackDescriptor> = currentTracks

    override fun selectAudioTrack(groupIndex: Int, trackIndex: Int): Boolean {
        var found = false
        currentTracks = currentTracks.map { descriptor ->
            if (descriptor.groupIndex == groupIndex && descriptor.trackIndex == trackIndex && descriptor.isSelectable) {
                found = true
                descriptor.copy(isSelected = true)
            } else {
                descriptor.copy(isSelected = false)
            }
        }
        return found
    }
}
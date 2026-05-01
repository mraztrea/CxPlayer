package com.cxplayer.subtitle

import com.cxplayer.data.model.SrtEntry
import java.io.File

/**
 * Xuất danh sách SrtEntry ra file SRT chuẩn.
 */
object SrtExporter {
    fun write(entries: List<SrtEntry>, file: File) {
        file.bufferedWriter().use { writer ->
            entries.forEach { entry ->
                writer.appendLine("${entry.index}")
                writer.appendLine("${formatTime(entry.startMs)} --> ${formatTime(entry.endMs)}")
                writer.appendLine(entry.text)
                writer.appendLine()
            }
        }
    }

    /** Format milliseconds thành "HH:MM:SS,mmm". */
    fun formatTime(ms: Long): String {
        val totalSeconds = ms / 1000
        val hours = totalSeconds / 3600
        val minutes = (totalSeconds % 3600) / 60
        val seconds = totalSeconds % 60
        val millis = ms % 1000
        return "%02d:%02d:%02d,%03d".format(hours, minutes, seconds, millis)
    }
}

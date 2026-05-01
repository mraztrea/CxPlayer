package com.cxplayer.ui.controls

import android.text.InputType
import android.view.View
import android.widget.ArrayAdapter
import android.widget.EditText
import android.widget.LinearLayout
import android.widget.ListView
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.cxplayer.R
import com.cxplayer.network.NetworkBrowseConnectionState
import com.cxplayer.network.NetworkBrowseSession
import com.cxplayer.network.NetworkCredentialSet
import com.cxplayer.network.SharedLibraryEntry
import com.cxplayer.network.SharedLibraryEntryType
import com.cxplayer.network.SmbBrowser
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

internal class NetworkBrowserDialog(
    private val activity: AppCompatActivity,
    private val smbBrowser: SmbBrowser = SmbBrowser()
) {
    private var activeDialog: AlertDialog? = null
    private var executor: ExecutorService? = null

    fun show(
        initialCredentialSet: NetworkCredentialSet? = null,
        onPlayableFileSelected: (NetworkCredentialSet, SharedLibraryEntry) -> Unit
    ) {
        showCredentialDialog(
            initialCredentialSet = initialCredentialSet ?: NetworkCredentialSet(
                host = "",
                shareName = "",
                username = "",
                password = "",
                domain = null
            ),
            currentDirectoryPath = "",
            initialErrorMessage = null,
            onPlayableFileSelected = onPlayableFileSelected
        )
    }

    fun dismiss() {
        activeDialog?.dismiss()
        activeDialog = null
        executor?.shutdownNow()
        executor = null
    }

    private fun showCredentialDialog(
        initialCredentialSet: NetworkCredentialSet,
        currentDirectoryPath: String,
        initialErrorMessage: String?,
        onPlayableFileSelected: (NetworkCredentialSet, SharedLibraryEntry) -> Unit
    ) {
        val spacingPx = (activity.resources.displayMetrics.density * 12f).toInt()
        val hostInput = createTextInput(
            hint = activity.getString(R.string.player_network_browser_host_hint),
            initialValue = initialCredentialSet.host,
            spacingPx = spacingPx
        )
        val shareInput = createTextInput(
            hint = activity.getString(R.string.player_network_browser_share_hint),
            initialValue = initialCredentialSet.shareName,
            spacingPx = spacingPx
        )
        val userInput = createTextInput(
            hint = activity.getString(R.string.player_network_browser_username_hint),
            initialValue = initialCredentialSet.username,
            spacingPx = spacingPx
        )
        val passwordInput = createTextInput(
            hint = activity.getString(R.string.player_network_browser_password_hint),
            initialValue = initialCredentialSet.password,
            spacingPx = spacingPx,
            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
        )
        val domainInput = createTextInput(
            hint = activity.getString(R.string.player_network_browser_domain_hint),
            initialValue = initialCredentialSet.domain.orEmpty(),
            spacingPx = spacingPx
        )
        val errorView = TextView(activity).apply {
            setTextColor(ContextCompat.getColor(activity, android.R.color.holo_red_light))
            text = initialErrorMessage.orEmpty()
            visibility = if (initialErrorMessage.isNullOrBlank()) View.GONE else View.VISIBLE
        }
        val container = LinearLayout(activity).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(spacingPx, spacingPx, spacingPx, spacingPx)
            addView(hostInput)
            addView(shareInput)
            addView(userInput)
            addView(passwordInput)
            addView(domainInput)
            addView(errorView)
        }

        val dialog = AlertDialog.Builder(activity)
            .setTitle(R.string.player_network_browser_title)
            .setView(container)
            .setNegativeButton(android.R.string.cancel, null)
            .setPositiveButton(R.string.player_network_browser_connect, null)
            .create()
        dialog.setOnShowListener {
            dialog.getButton(AlertDialog.BUTTON_POSITIVE).setOnClickListener {
                val credentialSet = NetworkCredentialSet(
                    host = hostInput.text.toString(),
                    shareName = shareInput.text.toString(),
                    username = userInput.text.toString(),
                    password = passwordInput.text.toString(),
                    domain = domainInput.text.toString().takeIf { value -> value.isNotBlank() }
                )
                setCredentialInputsEnabled(
                    enabled = false,
                    inputs = listOf(hostInput, shareInput, userInput, passwordInput, domainInput)
                )
                errorView.text = ""
                errorView.visibility = View.GONE
                loadDirectory(
                    credentialSet = credentialSet,
                    directoryPath = currentDirectoryPath,
                    onSuccess = { session ->
                        dialog.dismiss()
                        showDirectoryDialog(
                            session = session,
                            onPlayableFileSelected = onPlayableFileSelected
                        )
                    },
                    onError = { message ->
                        errorView.text = message
                        errorView.visibility = View.VISIBLE
                        setCredentialInputsEnabled(
                            enabled = true,
                            inputs = listOf(hostInput, shareInput, userInput, passwordInput, domainInput)
                        )
                    }
                )
            }
        }
        replaceDialog(dialog)
    }

    private fun showDirectoryDialog(
        session: NetworkBrowseSession,
        onPlayableFileSelected: (NetworkCredentialSet, SharedLibraryEntry) -> Unit
    ) {
        val items = buildDialogItems(session)
        val listView = ListView(activity).apply {
            adapter = ArrayAdapter(
                context,
                android.R.layout.simple_list_item_1,
                items.map(DialogListItem::label)
            )
        }
        val dialog = AlertDialog.Builder(activity)
            .setTitle(resolveDialogTitle(session))
            .setView(listView)
            .setNegativeButton(android.R.string.cancel, null)
            .setNeutralButton(R.string.player_network_browser_change_account, null)
            .create()
        dialog.setOnShowListener {
            dialog.getButton(AlertDialog.BUTTON_NEUTRAL).setOnClickListener {
                dialog.dismiss()
                showCredentialDialog(
                    initialCredentialSet = session.credentialSet,
                    currentDirectoryPath = session.currentDirectoryPath,
                    initialErrorMessage = null,
                    onPlayableFileSelected = onPlayableFileSelected
                )
            }
        }
        listView.setOnItemClickListener { _, _, position, _ ->
            when (val item = items[position]) {
                is DialogListItem.Parent -> {
                    val parentPath = resolveParentPath(session.currentDirectoryPath)
                    loadDirectory(
                        credentialSet = session.credentialSet,
                        directoryPath = parentPath,
                        onSuccess = { nextSession ->
                            dialog.dismiss()
                            showDirectoryDialog(nextSession, onPlayableFileSelected)
                        },
                        onError = { message ->
                            dialog.dismiss()
                            showCredentialDialog(
                                initialCredentialSet = session.credentialSet,
                                currentDirectoryPath = parentPath,
                                initialErrorMessage = message,
                                onPlayableFileSelected = onPlayableFileSelected
                            )
                        }
                    )
                }

                is DialogListItem.Entry -> {
                    if (item.entry.entryType == SharedLibraryEntryType.Directory) {
                        loadDirectory(
                            credentialSet = session.credentialSet,
                            directoryPath = item.entry.path,
                            onSuccess = { nextSession ->
                                dialog.dismiss()
                                showDirectoryDialog(nextSession, onPlayableFileSelected)
                            },
                            onError = { message ->
                                dialog.dismiss()
                                showCredentialDialog(
                                    initialCredentialSet = session.credentialSet,
                                    currentDirectoryPath = session.currentDirectoryPath,
                                    initialErrorMessage = message,
                                    onPlayableFileSelected = onPlayableFileSelected
                                )
                            }
                        )
                    } else if (item.entry.isPlayableCandidate) {
                        dialog.dismiss()
                        onPlayableFileSelected(session.credentialSet, item.entry)
                    }
                }
            }
        }
        replaceDialog(dialog)
    }

    private fun loadDirectory(
        credentialSet: NetworkCredentialSet,
        directoryPath: String,
        onSuccess: (NetworkBrowseSession) -> Unit,
        onError: (String) -> Unit
    ) {
        worker().submit {
            val session = smbBrowser.browse(credentialSet, directoryPath)
            activity.runOnUiThread {
                if (activity.isFinishing || activity.isDestroyed) {
                    return@runOnUiThread
                }
                if (session.connectionState == NetworkBrowseConnectionState.Browsing) {
                    onSuccess(session)
                } else {
                    onError(
                        session.errorMessage
                            ?: activity.getString(R.string.player_network_browser_error_connection_generic)
                    )
                }
            }
        }
    }

    private fun buildDialogItems(session: NetworkBrowseSession): List<DialogListItem> {
        val items = mutableListOf<DialogListItem>()
        if (session.currentDirectoryPath.isNotEmpty()) {
            items += DialogListItem.Parent(activity.getString(R.string.player_network_browser_entry_parent))
        }
        items += session.entries.map { entry ->
            DialogListItem.Entry(
                entry = entry,
                label = when {
                    entry.entryType == SharedLibraryEntryType.Directory -> {
                        activity.getString(R.string.player_network_browser_entry_directory, entry.displayName)
                    }

                    entry.isPlayableCandidate -> {
                        activity.getString(R.string.player_network_browser_entry_playable, entry.displayName)
                    }

                    else -> {
                        activity.getString(R.string.player_network_browser_entry_file, entry.displayName)
                    }
                }
            )
        }
        return items
    }

    private fun resolveDialogTitle(session: NetworkBrowseSession): String {
        return if (session.currentDirectoryPath.isBlank()) {
            activity.getString(
                R.string.player_network_browser_browse_title,
                session.credentialSet.shareName
            )
        } else {
            activity.getString(
                R.string.player_network_browser_browse_path_title,
                session.credentialSet.shareName,
                session.currentDirectoryPath
            )
        }
    }

    private fun resolveParentPath(currentDirectoryPath: String): String {
        return currentDirectoryPath.substringBeforeLast('/', missingDelimiterValue = "")
    }

    private fun createTextInput(
        hint: String,
        initialValue: String,
        spacingPx: Int,
        inputType: Int = InputType.TYPE_CLASS_TEXT
    ): EditText {
        return EditText(activity).apply {
            this.hint = hint
            setText(initialValue)
            this.inputType = inputType
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                bottomMargin = spacingPx
            }
        }
    }

    private fun setCredentialInputsEnabled(
        enabled: Boolean,
        inputs: List<EditText>
    ) {
        inputs.forEach { input ->
            input.isEnabled = enabled
        }
    }

    private fun replaceDialog(dialog: AlertDialog) {
        activeDialog?.dismiss()
        activeDialog = dialog
        dialog.show()
    }

    private fun worker(): ExecutorService {
        val existing = executor
        if (existing != null && !existing.isShutdown) {
            return existing
        }
        return Executors.newSingleThreadExecutor().also { created ->
            executor = created
        }
    }
}

private sealed interface DialogListItem {
    val label: String

    data class Parent(
        override val label: String
    ) : DialogListItem

    data class Entry(
        val entry: SharedLibraryEntry,
        override val label: String
    ) : DialogListItem
}
package com.cxplayer.ui.player
import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.ValueAnimator
import android.app.PictureInPictureParams
import android.graphics.Typeface
import android.content.ContentResolver
import android.content.Intent
import android.content.SharedPreferences
import android.content.pm.ActivityInfo
import android.content.res.Configuration
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.SystemClock
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.ImageButton
import android.widget.LinearLayout
import android.widget.SeekBar
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.StringRes
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.PopupMenu
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.core.view.doOnLayout
import androidx.core.view.updatePadding
import androidx.media3.common.C
import androidx.media3.ui.AspectRatioFrameLayout
import androidx.media3.ui.PlayerView
import com.cxplayer.R
import com.cxplayer.databinding.ActivityPlayerBinding
import com.cxplayer.data.model.SonioxConfig
import com.cxplayer.data.model.SubtitleDisplayMode
import com.cxplayer.data.model.SubtitleEvent
import com.cxplayer.network.NetworkCredentialSet
import com.cxplayer.network.SharedLibraryEntry
import com.cxplayer.network.SharedLibraryEntryType
import com.cxplayer.player.AudioTrackDescriptor
import com.cxplayer.player.CxPlayerManager
import com.cxplayer.player.CxRenderersFactory
import com.cxplayer.player.CxRepeatMode
import com.cxplayer.player.PlaybackSnapshot
import com.cxplayer.player.PlaybackStateSnapshot
import com.cxplayer.player.SubtitleSourceDescriptor
import com.cxplayer.player.SubtitleSourceKind
import com.cxplayer.player.SubtitleManager
import com.cxplayer.subtitle.AiSubtitleManager
import com.cxplayer.subtitle.ConnectionState
import com.cxplayer.subtitle.SrtExporter
import com.cxplayer.subtitle.SubtitleCacheManager
import com.cxplayer.ui.controls.NetworkBrowserDialog
import com.cxplayer.ui.controls.TrackSelector
import com.cxplayer.ui.controls.TrackSelectorOptionUiModel
import com.cxplayer.ui.controls.TrackSelectorSection
import com.cxplayer.ui.controls.TrackSelectorSectionUiModel
import com.cxplayer.ui.controls.TrackSelectorSelection
import com.cxplayer.ui.controls.TrackSelectorUiModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileNotFoundException
import java.net.URI
import java.util.Locale
import kotlin.math.min
import kotlin.math.roundToInt

private const val STATE_PLAYBACK_INDEX = "state_playback_index"
private const val STATE_PLAYBACK_POSITION_MS = "state_playback_position_ms"
private const val STATE_PLAY_WHEN_READY = "state_play_when_ready"
private const val STATE_SUBTITLE_DISABLED_BY_USER = "state_subtitle_disabled_by_user"
private const val STATE_SUBTITLE_STYLE_PRESET_INDEX = "state_subtitle_style_preset_index"
private const val STATE_SCREEN_LOCKED = "state_screen_locked"
private const val STATE_RESIZE_MODE = "state_resize_mode"
private const val STATE_AUTOPLAY_ENABLED = "state_autoplay_enabled"
private const val STATE_TRANSPORT_EXPANDED = "state_transport_expanded"
private const val ACTION_OPEN_INTERNAL_SMB = "com.cxplayer.action.OPEN_INTERNAL_SMB"
private const val PREF_SONIOX_API_KEY = "pref_soniox_api_key"

private val SPEED_VALUES = floatArrayOf(1.0f, 1.25f, 1.5f, 2.0f, 0.5f, 0.75f)
private const val DEFAULT_SPEED_INDEX = 0
private const val CHROME_AUTO_HIDE_DELAY_MS = 5000L
private const val CHROME_LOCKED_AUTO_HIDE_DELAY_MS = 3000L
private const val AI_SUBTITLE_SYNC_INTERVAL_MS = 50L
private const val TRANSPORT_EXPAND_ANIMATION_DURATION_MS = 300L

class PlayerActivity : AppCompatActivity() {
    private lateinit var binding: ActivityPlayerBinding
    private lateinit var playerView: PlayerView
    private lateinit var audioManager: AudioManager
    private lateinit var gestureController: GestureController
    private lateinit var topChrome: ViewGroup
    private lateinit var bottomChrome: ViewGroup
    private lateinit var topRegion: ViewGroup
    private lateinit var timelineRow: ViewGroup
    private lateinit var transportRow: ViewGroup
    private lateinit var gestureOverlay: ViewGroup
    private lateinit var backButton: ImageButton
    private lateinit var titleView: TextView
    private lateinit var overflowButton: ImageButton
    private lateinit var gestureOverlayCueView: TextView
    private lateinit var gestureOverlayValueView: TextView
    private lateinit var currentTimeView: TextView
    private lateinit var durationView: TextView
    private lateinit var seekBar: SeekBar
    private lateinit var pipButton: ImageButton
    private lateinit var seekBackButton: ImageButton
    private lateinit var playPauseButton: ImageButton
    private lateinit var seekForwardButton: ImageButton
    private lateinit var skipPreviousButton: ImageButton
    private lateinit var skipNextButton: ImageButton
    private lateinit var shuffleButton: ImageButton
    private lateinit var repeatButton: ImageButton
    private lateinit var trackSelectorButton: ImageButton
    private lateinit var aiSubtitleButton: ImageButton
    private lateinit var aiSubtitleOverlay: LinearLayout
    private lateinit var aiSubtitleOriginalText: TextView
    private lateinit var aiSubtitleTranslationText: TextView
    private lateinit var aiSubtitleStatusText: TextView
    private lateinit var functionRow: ViewGroup
    private lateinit var functionRowExpandable: LinearLayout
    private lateinit var lockButton: ImageButton
    private lateinit var expandButton: ImageButton
    private lateinit var unlockButton: ImageButton
    private lateinit var speedButton: TextView
    private lateinit var subtitleButton: ImageButton
    private lateinit var resizeButton: ImageButton
    private lateinit var rotateButton: ImageButton
    private lateinit var audioTrackButton: ImageButton
    private lateinit var autoPlayButton: ImageButton
    private val playerManager by lazy(LazyThreadSafetyMode.NONE) { CxPlayerManager(this) }
    private val networkBrowserDialog by lazy(LazyThreadSafetyMode.NONE) { NetworkBrowserDialog(this) }
    private val trackSelector by lazy(LazyThreadSafetyMode.NONE) { TrackSelector(this) }
    private val subtitlePickerLauncher = registerForActivityResult(ActivityResultContracts.OpenDocument()) { uri ->
        uri ?: return@registerForActivityResult
        loadPickedSubtitle(uri)
    }
    private var subtitleManager: SubtitleManager? = null
    private var pendingLaunch: PendingLaunch? = null
    private var pendingSnapshot: PlaybackSnapshot? = null
    private var activeRequest: PlaybackRequest? = null
    private var subtitleDisabledByUser: Boolean = false
    private var subtitleStylePresetIndex: Int = 0
    private var lastSmbCredentialSet: NetworkCredentialSet? = null
    private var topSystemInsetPx: Int = 0
    private var bottomSystemInsetPx: Int = 0
    private var currentWindowBrightness: Float = 0.5f
    private var currentZoomScale: Float = 1f
    private var currentGestureOverlayState: GestureOverlayState? = null
    private var isScreenLocked: Boolean = false
    private var currentResizeMode: Int = AspectRatioFrameLayout.RESIZE_MODE_FIT
    private var isAutoPlayEnabled: Boolean = true
    private var currentSpeedIndex: Int = DEFAULT_SPEED_INDEX
    private var isChromeVisible: Boolean = true
    private var isTransportExpanded: Boolean = false
    private var isTransportAnimating: Boolean = false
    private var transportAnimator: ValueAnimator? = null
    private val autoHideHandler = android.os.Handler(android.os.Looper.getMainLooper())
    private val hideGestureOverlayRunnable = Runnable {
        currentGestureOverlayState = null
        if (::gestureOverlay.isInitialized) {
            gestureOverlay.visibility = View.GONE
        }
    }
    private val hideChromeRunnable = Runnable { hideChrome() }

    // AI Subtitle
    private val aiScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    private var aiSubtitleManager: AiSubtitleManager? = null
    private var aiSubtitleCollectJob: Job? = null
    private var aiConnectionCollectJob: Job? = null
    private var aiPlaybackSyncJob: Job? = null
    private val subtitleCacheManager by lazy(LazyThreadSafetyMode.NONE) { SubtitleCacheManager(this) }
    private val prefs: SharedPreferences by lazy {
        getSharedPreferences("cxplayer_prefs", MODE_PRIVATE)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityPlayerBinding.inflate(layoutInflater)
        setContentView(binding.root)

        playerView = binding.playerView
        bindChromeViews()
        audioManager = getSystemService(AudioManager::class.java)
        setVolumeControlStream(AudioManager.STREAM_MUSIC)
        initializeTopChrome()
        initializeBottomChrome()
        initializeGestureOverlay()
        initializeChromeLayoutBehavior()
        initializeGestureController()
        pendingSnapshot = restoreSnapshot(savedInstanceState)
        applyTransportExpandedState()
        updatePendingLaunch(intent)
        updateTopChrome()
    }

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        binding.playerRoot.post {
            renderChromeLayout(binding.playerRoot.height)
            applyTransportExpandedState()
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        pendingSnapshot = null
        subtitleDisabledByUser = false
        subtitleStylePresetIndex = 0
        updatePendingLaunch(intent)
        updateTopChrome()
        if (!isFinishing) {
            beginPlaybackSession()
        }
    }

    override fun onStart() {
        super.onStart()
        beginPlaybackSession()
    }

    override fun onSaveInstanceState(outState: Bundle) {
        captureSnapshot()
        pendingSnapshot?.let { snapshot ->
            outState.putInt(STATE_PLAYBACK_INDEX, snapshot.currentIndex)
            outState.putLong(STATE_PLAYBACK_POSITION_MS, snapshot.currentPositionMs)
            outState.putBoolean(STATE_PLAY_WHEN_READY, snapshot.playWhenReady)
        }
        outState.putBoolean(STATE_SUBTITLE_DISABLED_BY_USER, subtitleDisabledByUser)
        outState.putInt(STATE_SUBTITLE_STYLE_PRESET_INDEX, subtitleStylePresetIndex)
        outState.putBoolean(STATE_SCREEN_LOCKED, isScreenLocked)
        outState.putInt(STATE_RESIZE_MODE, currentResizeMode)
        outState.putBoolean(STATE_AUTOPLAY_ENABLED, isAutoPlayEnabled)
        outState.putBoolean(STATE_TRANSPORT_EXPANDED, isTransportExpanded)
        super.onSaveInstanceState(outState)
    }

    override fun onStop() {
        captureSnapshot()
        networkBrowserDialog.dismiss()
        trackSelector.dismiss()
        subtitleManager = null
        playerManager.release()
        syncPlayerState()
        super.onStop()
    }

    override fun onDestroy() {
        networkBrowserDialog.dismiss()
        trackSelector.dismiss()
        if (::gestureController.isInitialized) {
            gestureController.release()
        }
        if (::gestureOverlay.isInitialized) {
            gestureOverlay.removeCallbacks(hideGestureOverlayRunnable)
        }
        // AI Subtitle cleanup
        aiSubtitleManager?.stop()
        aiSubtitleCollectJob?.cancel()
        aiConnectionCollectJob?.cancel()
        aiScope.cancel()
        autoHideHandler.removeCallbacksAndMessages(null)
        subtitleManager = null
        playerManager.release()
        super.onDestroy()
    }

    fun playPlayback() {
        playerManager.play()
        syncPlayerState()
        scheduleAutoHideChrome()
    }

    fun pausePlayback() {
        playerManager.pause()
        syncPlayerState()
        cancelAutoHideChrome()
    }

    fun seekToPosition(positionMs: Long) {
        playerManager.seekTo(positionMs)
        syncPlayerState()
    }

    fun seekForward() {
        playerManager.seekForward()
        syncPlayerState()
    }

    fun seekBack() {
        playerManager.seekBack()
        syncPlayerState()
    }

    internal fun currentPlaybackSnapshot(): PlaybackSnapshot? = playerManager.exportSnapshot()

    internal fun currentPlaybackState(): PlaybackStateSnapshot = playerManager.currentState()

    internal fun hasSubtitleManager(): Boolean = subtitleManager != null

    internal fun openNetworkBrowserForTesting(): Boolean = showNetworkBrowser()

    internal fun openTrackSelectorForTesting(): Boolean = showTrackSelector()

    internal fun isTrackSelectorShowingForTesting(): Boolean = trackSelector.isShowing()

    internal fun disableSubtitlesViaTrackSelectorForTesting(): Boolean {
        val offSourceId = subtitleManager
            ?.availableSubtitleSources()
            ?.firstOrNull { descriptor -> descriptor.kind == SubtitleSourceKind.Off }
            ?.id
            ?: return false
        handleTrackSelectorSelection(
            TrackSelectorSelection(
                section = TrackSelectorSection.Subtitle,
                optionId = offSourceId
            )
        )
        return isSubtitleDisabledForTesting()
    }

    internal fun currentAvailableSubtitleSourceCount(): Int {
        return subtitleManager?.availableSubtitleSources()?.size ?: 0
    }

    internal fun cycleSubtitleSourceForTesting(): Boolean {
        return cycleSubtitleSource()
    }

    internal fun advanceSubtitleStyleForTesting(): Int {
        val manager = subtitleManager ?: return 0
        val updatedStyle = manager.cycleStylePreset()
        subtitleStylePresetIndex = manager.currentStylePresetIndex()
        return updatedStyle.fontSizeSp
    }

    internal fun currentSubtitleStyleFontSizeForTesting(): Int {
        return subtitleManager?.currentStyleState()?.fontSizeSp ?: 0
    }

    internal fun loadExternalSubtitleForTesting(uri: Uri): Boolean {
        val manager = subtitleManager ?: return false
        val loaded = manager.loadExternalSubtitle(uri)
        if (loaded) {
            onSubtitleEnabled()
        }
        return loaded
    }

    internal fun isSubtitleDisabledForTesting(): Boolean {
        return subtitleManager?.currentSelectionState()?.textTrackDisabled ?: true
    }

    internal fun currentGestureBrightness(): Float {
        return window.attributes.screenBrightness.takeIf { it >= 0f } ?: currentWindowBrightness
    }

    internal fun currentPlayerZoomScale(): Float = currentZoomScale

    internal fun currentMusicStreamVolume(): Int = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)

    internal fun isGestureOverlayVisible(): Boolean =
        ::gestureOverlay.isInitialized && gestureOverlay.visibility == View.VISIBLE

    internal fun currentGestureOverlayCue(): String =
        if (::gestureOverlayCueView.isInitialized) gestureOverlayCueView.text.toString() else ""

    internal fun currentGestureOverlayValue(): String =
        if (::gestureOverlayValueView.isInitialized) gestureOverlayValueView.text.toString() else ""

    internal fun hasChromeSkeleton(): Boolean =
        ::topChrome.isInitialized &&
            ::bottomChrome.isInitialized &&
            ::topRegion.isInitialized &&
            ::timelineRow.isInitialized &&
            ::transportRow.isInitialized &&
            ::functionRow.isInitialized

    private fun updatePendingLaunch(intent: Intent?) {
        when (val outcome = PlaybackRequestParser.fromIntent(intent, contentResolver)) {
            is LaunchOutcome.Rejected -> {
                pendingLaunch = null
                activeRequest = null
                showMessage(outcome.messageResId)
                finish()
            }

            is LaunchOutcome.Ready -> {
                pendingLaunch = PendingLaunch(
                    request = outcome.request,
                    messageResId = null
                )
                activeRequest = outcome.request
            }

            is LaunchOutcome.FallbackSelected -> {
                pendingLaunch = PendingLaunch(
                    request = outcome.request,
                    messageResId = outcome.messageResId
                )
                activeRequest = outcome.request
            }
        }
    }

    private fun beginPlaybackSession() {
        val launch = pendingLaunch ?: return
        activeRequest = launch.request
        playerManager.attach(playerView)
        playerManager.load(
            request = launch.request,
            snapshot = pendingSnapshot
        )
        launch.messageResId?.let { messageResId ->
            showMessage(messageResId)
            pendingLaunch = launch.copy(messageResId = null)
        }
        refreshSubtitleManager()
        autoDetectSubtitleForCurrentSource()
        pendingSnapshot = null
        syncPlayerState()
        updateTopChrome()
        scheduleAutoHideChrome()
    }

    private fun captureSnapshot() {
        pendingSnapshot = playerManager.exportSnapshot() ?: pendingSnapshot
    }

    private fun restoreSnapshot(savedInstanceState: Bundle?): PlaybackSnapshot? {
        subtitleDisabledByUser = savedInstanceState?.getBoolean(STATE_SUBTITLE_DISABLED_BY_USER, false) ?: false
        subtitleStylePresetIndex = savedInstanceState?.getInt(STATE_SUBTITLE_STYLE_PRESET_INDEX, 0) ?: 0
        isScreenLocked = savedInstanceState?.getBoolean(STATE_SCREEN_LOCKED, false) ?: false
        currentResizeMode = savedInstanceState?.getInt(STATE_RESIZE_MODE, AspectRatioFrameLayout.RESIZE_MODE_FIT) ?: AspectRatioFrameLayout.RESIZE_MODE_FIT
        isAutoPlayEnabled = savedInstanceState?.getBoolean(STATE_AUTOPLAY_ENABLED, true) ?: true
        isTransportExpanded = savedInstanceState?.getBoolean(STATE_TRANSPORT_EXPANDED, false) ?: false
        if (savedInstanceState == null || !savedInstanceState.containsKey(STATE_PLAYBACK_INDEX)) {
            return null
        }

        return PlaybackSnapshot(
            currentIndex = savedInstanceState.getInt(STATE_PLAYBACK_INDEX),
            currentPositionMs = savedInstanceState
                .getLong(STATE_PLAYBACK_POSITION_MS)
                .coerceAtLeast(0L),
            playWhenReady = savedInstanceState.getBoolean(STATE_PLAY_WHEN_READY, true)
        )
    }

    private fun bindChromeViews() {
        topChrome = binding.playerTopChrome
        bottomChrome = binding.playerBottomChrome
        topRegion = binding.playerTopRegion
        timelineRow = binding.playerTimelineRow
        transportRow = binding.playerTransportRow
        gestureOverlay = binding.playerGestureOverlay
        backButton = binding.playerBackButton
        titleView = binding.playerTitleView
        overflowButton = binding.playerOverflowButton
        gestureOverlayCueView = binding.playerGestureOverlayCueView
        gestureOverlayValueView = binding.playerGestureOverlayValueView
        currentTimeView = binding.playerCurrentTimeView
        durationView = binding.playerDurationView
        seekBar = binding.playerSeekBar
        pipButton = binding.playerPipButton
        seekBackButton = binding.playerSeekBackButton
        playPauseButton = binding.playerPlayPauseButton
        seekForwardButton = binding.playerSeekForwardButton
        skipPreviousButton = binding.playerSkipPreviousButton
        skipNextButton = binding.playerSkipNextButton
        shuffleButton = binding.playerShuffleButton
        repeatButton = binding.playerRepeatButton
        trackSelectorButton = binding.playerTrackSelectorButton
        aiSubtitleButton = binding.playerAiSubtitleButton
        aiSubtitleOverlay = binding.aiSubtitleOverlay
        aiSubtitleOriginalText = binding.aiSubtitleOriginalText
        aiSubtitleTranslationText = binding.aiSubtitleTranslationText
        aiSubtitleStatusText = binding.aiSubtitleStatusText
        functionRow = binding.playerFunctionRow
        functionRowExpandable = binding.playerFunctionRowExpandable
        lockButton = binding.playerLockButton
        expandButton = binding.playerExpandButton
        unlockButton = binding.playerUnlockButton
        speedButton = binding.playerSpeedButton
        subtitleButton = binding.playerSubtitleButton
        resizeButton = binding.playerResizeButton
        rotateButton = binding.playerRotateButton
        audioTrackButton = binding.playerAudioTrackButton
        autoPlayButton = binding.playerAutoPlayButton
    }

    private fun initializeTopChrome() {
        titleView.text = getString(R.string.player_title_fallback)
        backButton.setOnClickListener {
            onBackPressedDispatcher.onBackPressed()
        }
        overflowButton.setOnClickListener { showOverflowMenu() }
        aiSubtitleButton.setOnClickListener { toggleAiSubtitle() }
        aiSubtitleButton.setOnLongClickListener { showDisplayModeDialog(); true }
        overflowButton.setOnLongClickListener { showNetworkBrowser() }
    }

    private fun initializeBottomChrome() {
        currentTimeView.text = getString(R.string.player_time_placeholder)
        durationView.text = getString(R.string.player_time_placeholder)
        seekBar.max = 1000
        seekBar.progress = 0
        seekBar.isEnabled = false
        seekBar.setOnSeekBarChangeListener(
            object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                    if (!fromUser) {
                        return
                    }

                    currentTimeView.text = formatPlaybackTime(progress.toLong())
                }

                override fun onStartTrackingTouch(seekBar: SeekBar?) = Unit

                override fun onStopTrackingTouch(seekBar: SeekBar?) {
                    val targetPosition = seekBar?.progress?.toLong() ?: return
                    seekToPosition(targetPosition)
                }
            }
        )
        pipButton.setOnClickListener { enterPictureInPictureCompat() }
        seekBackButton.setOnClickListener { seekBack() }
        playPauseButton.setOnClickListener {
            val state = playerManager.currentState()
            if (state.hasActiveSession && state.playWhenReady) {
                pausePlayback()
            } else {
                playPlayback()
            }
        }
        seekForwardButton.setOnClickListener { seekForward() }
        skipPreviousButton.setOnClickListener {
            playerManager.seekToPrevious()
            refreshSubtitleManager()
            autoDetectSubtitleForCurrentSource()
            syncPlayerState()
            updateTopChrome()
        }
        skipNextButton.setOnClickListener {
            playerManager.seekToNext()
            refreshSubtitleManager()
            autoDetectSubtitleForCurrentSource()
            syncPlayerState()
            updateTopChrome()
        }
        repeatButton.setOnClickListener {
            val mode = playerManager.cycleRepeatMode()
            val feedbackResId = when (mode) {
                CxRepeatMode.Off -> R.string.player_repeat_off_feedback
                CxRepeatMode.All -> R.string.player_repeat_all_feedback
                CxRepeatMode.One -> R.string.player_repeat_one_feedback
            }
            showMessage(feedbackResId)
            syncPlayerState()
        }
        trackSelectorButton.setOnClickListener { showTrackSelector() }
        initializeFunctionRow()
        updateBottomChrome()
    }

    private fun initializeFunctionRow() {
        lockButton.setOnClickListener { setScreenLocked(true) }
        unlockButton.setOnClickListener { setScreenLocked(false) }
        expandButton.setOnClickListener { toggleTransportExpand() }
        subtitleButton.setOnClickListener {
            val manager = subtitleManager
            if (manager == null) {
                showMessage(R.string.player_no_subtitle_message)
                return@setOnClickListener
            }
            val sources = manager.availableSubtitleSources()
            val activeSources = sources.filter { it.kind != SubtitleSourceKind.Off }
            when {
                activeSources.isEmpty() -> showMessage(R.string.player_no_subtitle_message)
                activeSources.size == 1 -> cycleSubtitleSource()
                else -> showTrackSelector()
            }
        }
        subtitleButton.setOnLongClickListener { launchSubtitlePicker(); true }
        resizeButton.setOnClickListener { cycleResizeMode() }
        rotateButton.setOnClickListener { toggleRotation() }
        audioTrackButton.setOnClickListener { showTrackSelector() }
        shuffleButton.setOnClickListener {
            val enabled = playerManager.toggleShuffle()
            showMessage(if (enabled) R.string.player_shuffle_on_feedback else R.string.player_shuffle_off_feedback)
            syncPlayerState()
        }
        autoPlayButton.setOnClickListener {
            isAutoPlayEnabled = !isAutoPlayEnabled
            updateAutoPlayButton()
            showMessage(if (isAutoPlayEnabled) R.string.player_autoplay_on_feedback else R.string.player_autoplay_off_feedback)
        }
        speedButton.setOnClickListener { cyclePlaybackSpeed() }
        applyPlaybackSpeedSelection()
        applyTransportExpandedState()
        updateAutoPlayButton()
    }

    private fun cyclePlaybackSpeed() {
        currentSpeedIndex = (currentSpeedIndex + 1) % SPEED_VALUES.size
        applyPlaybackSpeedSelection()
    }

    private fun setScreenLocked(locked: Boolean) {
        isScreenLocked = locked
        if (::gestureController.isInitialized) {
            gestureController.isLocked = locked
        }
        if (locked) {
            collapseTransportRow(animate = true) {
                topChrome.visibility = View.GONE
                bottomChrome.visibility = View.GONE
                isChromeVisible = false
                unlockButton.visibility = View.VISIBLE
                applyImmersiveMode()
                autoHideHandler.postDelayed({
                    if (isScreenLocked && unlockButton.visibility == View.VISIBLE) {
                        unlockButton.visibility = View.GONE
                    }
                }, CHROME_LOCKED_AUTO_HIDE_DELAY_MS)
            }
        } else {
            unlockButton.visibility = View.GONE
            showChrome()
        }
    }

    private fun toggleTransportExpand() {
        if (isTransportAnimating) {
            return
        }

        setTransportExpanded(!isTransportExpanded, animate = true)
    }

    private fun collapseTransportRow(animate: Boolean, onComplete: (() -> Unit)? = null) {
        if (!isTransportExpanded && functionRowExpandable.visibility != View.VISIBLE) {
            applyTransportExpandedState()
            onComplete?.invoke()
            return
        }

        setTransportExpanded(expanded = false, animate = animate, onComplete = onComplete)
    }

    private fun setTransportExpanded(
        expanded: Boolean,
        animate: Boolean,
        onComplete: (() -> Unit)? = null
    ) {
        val targetHeight = if (expanded) {
            resources.getDimensionPixelSize(R.dimen.player_expanded_row_height)
        } else {
            0
        }
        val layoutParams = functionRowExpandable.layoutParams
        val currentHeight = functionRowExpandable.height.takeIf { it > 0 }
            ?: layoutParams.height.coerceAtLeast(0)

        transportAnimator?.cancel()
        transportAnimator = null
        isTransportAnimating = false

        if (!expanded) {
            functionRowExpandable.visibility = View.VISIBLE
        } else if (functionRowExpandable.visibility != View.VISIBLE) {
            updateExpandedRowHeight(0)
            functionRowExpandable.visibility = View.VISIBLE
        }

        if (!animate || currentHeight == targetHeight) {
            isTransportExpanded = expanded
            applyTransportExpandedState()
            if (isChromeVisible && !isScreenLocked) {
                scheduleAutoHideChrome()
            }
            onComplete?.invoke()
            return
        }

        val animator = ValueAnimator.ofInt(currentHeight, targetHeight)
        transportAnimator = animator
        isTransportAnimating = true
        animator.duration = TRANSPORT_EXPAND_ANIMATION_DURATION_MS
        animator.addUpdateListener { valueAnimator ->
            updateExpandedRowHeight(valueAnimator.animatedValue as Int)
        }
        animator.addListener(
            object : AnimatorListenerAdapter() {
                override fun onAnimationEnd(animation: Animator) {
                    if (transportAnimator !== animator) {
                        return
                    }

                    transportAnimator = null
                    isTransportAnimating = false
                    isTransportExpanded = expanded
                    applyTransportExpandedState()
                    if (isChromeVisible && !isScreenLocked) {
                        scheduleAutoHideChrome()
                    }
                    onComplete?.invoke()
                }

                override fun onAnimationCancel(animation: Animator) {
                    if (transportAnimator === animator) {
                        transportAnimator = null
                        isTransportAnimating = false
                    }
                }
            }
        )
        animator.start()
    }

    private fun applyTransportExpandedState() {
        if (!::functionRowExpandable.isInitialized || !::expandButton.isInitialized) {
            return
        }

        val targetHeight = if (isTransportExpanded) {
            resources.getDimensionPixelSize(R.dimen.player_expanded_row_height)
        } else {
            0
        }
        updateExpandedRowHeight(targetHeight)
        functionRowExpandable.visibility = if (targetHeight == 0) View.GONE else View.VISIBLE
        expandButton.setImageResource(
            if (isTransportExpanded) {
                R.drawable.ic_player_close
            } else {
                R.drawable.ic_player_expand
            }
        )
        expandButton.contentDescription = getString(
            if (isTransportExpanded) {
                R.string.player_collapse_content_description
            } else {
                R.string.player_expand_content_description
            }
        )
    }

    private fun updateExpandedRowHeight(height: Int) {
        val layoutParams = functionRowExpandable.layoutParams
        if (layoutParams.height != height) {
            layoutParams.height = height
            functionRowExpandable.layoutParams = layoutParams
        }
    }

    private fun applyPlaybackSpeedSelection() {
        val speed = SPEED_VALUES.getOrElse(currentSpeedIndex) { SPEED_VALUES[DEFAULT_SPEED_INDEX] }
        speedButton.text = formatPlaybackSpeedLabel(speed)
        playerManager.setPlaybackSpeed(speed)
    }

    private fun formatPlaybackSpeedLabel(speed: Float): String {
        val normalized = speed.toString().removeSuffix(".0")
        return normalized.uppercase(Locale.ROOT) + "X"
    }

    private fun enterPictureInPictureCompat() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return
        }

        enterPictureInPictureMode(PictureInPictureParams.Builder().build())
    }

    private fun showOverflowMenu() {
        val popup = PopupMenu(this, overflowButton)
        popup.menuInflater.inflate(R.menu.player_overflow, popup.menu)
        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                R.id.action_player_settings -> {
                    launchSubtitlePicker()
                    true
                }
                else -> false
            }
        }
        popup.show()
    }

    private fun cycleResizeMode() {
        currentResizeMode = when (currentResizeMode) {
            AspectRatioFrameLayout.RESIZE_MODE_FIT -> AspectRatioFrameLayout.RESIZE_MODE_FILL
            AspectRatioFrameLayout.RESIZE_MODE_FILL -> AspectRatioFrameLayout.RESIZE_MODE_ZOOM
            else -> AspectRatioFrameLayout.RESIZE_MODE_FIT
        }
        playerView.resizeMode = currentResizeMode
        val iconRes = when (currentResizeMode) {
            AspectRatioFrameLayout.RESIZE_MODE_FIT -> R.drawable.ic_player_resize_fit
            AspectRatioFrameLayout.RESIZE_MODE_FILL -> R.drawable.ic_player_resize_fill
            else -> R.drawable.ic_player_resize_zoom
        }
        resizeButton.setImageResource(iconRes)
        val labelRes = when (currentResizeMode) {
            AspectRatioFrameLayout.RESIZE_MODE_FIT -> R.string.player_resize_fit_label
            AspectRatioFrameLayout.RESIZE_MODE_FILL -> R.string.player_resize_fill_label
            else -> R.string.player_resize_zoom_label
        }
        showMessage(labelRes)
    }

    private fun toggleRotation() {
        requestedOrientation = when (requestedOrientation) {
            ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE -> ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
            ActivityInfo.SCREEN_ORIENTATION_PORTRAIT -> ActivityInfo.SCREEN_ORIENTATION_SENSOR
            else -> ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE
        }
    }

    private fun updateAutoPlayButton() {
        val iconRes = if (isAutoPlayEnabled) R.drawable.ic_player_autoplay else R.drawable.ic_player_autoplay_off
        autoPlayButton.setImageResource(iconRes)
        autoPlayButton.alpha = if (isAutoPlayEnabled) 1f else 0.5f
    }

    private fun toggleChromeVisibility() {
        if (isChromeVisible) {
            hideChrome()
        } else {
            showChrome()
        }
    }

    private fun showChrome() {
        if (!hasChromeSkeleton()) return
        isChromeVisible = true
        topChrome.visibility = View.VISIBLE
        bottomChrome.visibility = View.VISIBLE
        applyTransportExpandedState()
        exitImmersiveMode()
        scheduleAutoHideChrome()
    }

    private fun hideChrome() {
        if (!hasChromeSkeleton()) return
        if (isTransportExpanded) {
            collapseTransportRow(animate = true) {
                hideChrome()
            }
            return
        }
        isChromeVisible = false
        topChrome.visibility = View.GONE
        bottomChrome.visibility = View.GONE
        cancelAutoHideChrome()
        applyImmersiveMode()
    }

    private fun scheduleAutoHideChrome() {
        cancelAutoHideChrome()
        val state = playerManager.currentState()
        if (state.hasActiveSession && state.playWhenReady) {
            val delay = if (isScreenLocked) CHROME_LOCKED_AUTO_HIDE_DELAY_MS else CHROME_AUTO_HIDE_DELAY_MS
            autoHideHandler.postDelayed(hideChromeRunnable, delay)
        }
    }

    private fun cancelAutoHideChrome() {
        autoHideHandler.removeCallbacks(hideChromeRunnable)
    }

    private fun toggleUnlockButtonVisibility() {
        if (!isScreenLocked) return
        val isVisible = unlockButton.visibility == View.VISIBLE
        if (isVisible) {
            unlockButton.visibility = View.GONE
            applyImmersiveMode()
        } else {
            unlockButton.visibility = View.VISIBLE
            exitImmersiveMode()
            autoHideHandler.removeCallbacks(hideChromeRunnable)
            autoHideHandler.postDelayed({
                if (isScreenLocked && unlockButton.visibility == View.VISIBLE) {
                    unlockButton.visibility = View.GONE
                    applyImmersiveMode()
                }
            }, CHROME_LOCKED_AUTO_HIDE_DELAY_MS)
        }
    }

    private fun applyImmersiveMode() {
        val controller = WindowCompat.getInsetsController(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
    }

    private fun exitImmersiveMode() {
        val controller = WindowCompat.getInsetsController(window, window.decorView)
        controller.show(WindowInsetsCompat.Type.systemBars())
    }

    private fun refreshSubtitleManager() {
        subtitleManager = playerManager.subtitleSessionController()?.let { controller ->
            SubtitleManager(
                sessionController = controller,
                playerView = playerView,
                contentResolver = contentResolver
            ).also { manager ->
                manager.applyStylePreset(subtitleStylePresetIndex)
            }
        }
    }

    private fun launchSubtitlePicker() {
        if (subtitleManager == null) {
            return
        }
        subtitlePickerLauncher.launch(arrayOf("text/*", "application/octet-stream", "application/x-subrip"))
    }

    private fun showNetworkBrowser(): Boolean {
        networkBrowserDialog.show(
            initialCredentialSet = lastSmbCredentialSet,
            onPlayableFileSelected = ::playSelectedSmbEntry
        )
        return true
    }

    private fun showTrackSelector(): Boolean {
        val audioTracks = playerManager.trackSelectorSessionController()?.currentAudioTracks().orEmpty()
        val subtitleSources = subtitleManager?.availableSubtitleSources().orEmpty()
        if (audioTracks.isEmpty() && subtitleSources.isEmpty()) {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return false
        }

        val anchorView = when {
            subtitleButton.visibility == View.VISIBLE -> subtitleButton
            audioTrackButton.visibility == View.VISIBLE -> audioTrackButton
            else -> overflowButton
        }

        trackSelector.show(
            anchor = anchorView,
            model = buildTrackSelectorModel(audioTracks, subtitleSources),
            onSelection = ::handleTrackSelectorSelection
        )
        return true
    }

    private fun buildTrackSelectorModel(
        audioTracks: List<AudioTrackDescriptor>,
        subtitleSources: List<SubtitleSourceDescriptor>
    ): TrackSelectorUiModel {
        return TrackSelectorUiModel(
            audioSection = TrackSelectorSectionUiModel(
                title = getString(R.string.player_track_selector_audio_title),
                emptyLabel = getString(R.string.player_track_selector_audio_empty),
                options = audioTracks.map { descriptor ->
                    TrackSelectorOptionUiModel(
                        id = descriptor.id,
                        label = descriptor.label,
                        isSelected = descriptor.isSelected,
                        isEnabled = descriptor.isSelectable
                    )
                }
            ),
            subtitleSection = TrackSelectorSectionUiModel(
                title = getString(R.string.player_track_selector_subtitle_title),
                emptyLabel = getString(R.string.player_track_selector_subtitle_empty),
                options = subtitleSources.map { descriptor ->
                    TrackSelectorOptionUiModel(
                        id = descriptor.id,
                        label = descriptor.label,
                        isSelected = descriptor.isCurrentlySelected,
                        isEnabled = true
                    )
                }
            )
        )
    }

    private fun handleTrackSelectorSelection(selection: TrackSelectorSelection) {
        when (selection.section) {
            TrackSelectorSection.Audio -> handleAudioTrackSelection(selection.optionId)
            TrackSelectorSection.Subtitle -> handleSubtitleTrackSelection(selection.optionId)
        }
    }

    private fun handleAudioTrackSelection(optionId: String) {
        val controller = playerManager.trackSelectorSessionController() ?: run {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return
        }
        val descriptor = controller.currentAudioTracks().firstOrNull { track -> track.id == optionId } ?: run {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return
        }
        if (!descriptor.isSelectable) {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return
        }
        if (controller.selectAudioTrack(descriptor.groupIndex, descriptor.trackIndex)) {
            showMessage(getString(R.string.player_audio_feedback_selected, descriptor.label))
            syncPlayerState()
        } else {
            showMessage(R.string.player_track_selector_feedback_unavailable)
        }
    }

    private fun handleSubtitleTrackSelection(optionId: String) {
        val manager = subtitleManager ?: run {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return
        }
        val descriptor = manager.availableSubtitleSources().firstOrNull { source -> source.id == optionId } ?: run {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return
        }
        if (!manager.selectSubtitleSource(optionId)) {
            showMessage(R.string.player_track_selector_feedback_unavailable)
            return
        }

        if (descriptor.kind == SubtitleSourceKind.Off) {
            onSubtitleDisabled()
        } else {
            onSubtitleEnabled(getString(R.string.player_subtitle_feedback_loaded, descriptor.label))
        }
    }

    private fun playSelectedSmbEntry(
        credentialSet: NetworkCredentialSet,
        entry: SharedLibraryEntry
    ) {
        val smbUriValue = buildAuthenticatedSmbUri(credentialSet, entry)
        if (smbUriValue == null) {
            showMessage(R.string.player_network_browser_error_invalid_entry)
            return
        }

        val launchOutcome = PlaybackRequestParser.fromInput(
            LaunchRequestInput(
                sources = listOf(
                    LaunchSourceCandidate(
                        rawValue = smbUriValue,
                        mimeType = null,
                        isAccessible = true
                    )
                ),
                startIndex = 0,
                startPositionMs = 0L,
                origin = LaunchOrigin.InternalExplicit,
                rawAction = ACTION_OPEN_INTERNAL_SMB
            )
        )
        when (launchOutcome) {
            is LaunchOutcome.Rejected -> {
                showMessage(launchOutcome.messageResId)
            }

            is LaunchOutcome.Ready -> {
                lastSmbCredentialSet = credentialSet
                pendingSnapshot = null
                pendingLaunch = PendingLaunch(
                    request = launchOutcome.request,
                    messageResId = null
                )
                activeRequest = launchOutcome.request
                beginPlaybackSession()
                showMessage(
                    getString(
                        R.string.player_network_browser_feedback_playing,
                        entry.displayName
                    )
                )
            }

            is LaunchOutcome.FallbackSelected -> {
                lastSmbCredentialSet = credentialSet
                pendingSnapshot = null
                pendingLaunch = PendingLaunch(
                    request = launchOutcome.request,
                    messageResId = launchOutcome.messageResId
                )
                activeRequest = launchOutcome.request
                beginPlaybackSession()
            }
        }
    }

    private fun buildAuthenticatedSmbUri(
        credentialSet: NetworkCredentialSet,
        entry: SharedLibraryEntry
    ): String? {
        if (entry.entryType != SharedLibraryEntryType.File || !entry.isPlayableCandidate) {
            return null
        }

        val normalizedHost = credentialSet.host.trim()
        val normalizedShareName = credentialSet.shareName.trim().trim('/').trim('\\')
        val normalizedPath = entry.path.trim().trim('/').trim('\\').replace('\\', '/')
        if (normalizedHost.isEmpty() || normalizedShareName.isEmpty() || normalizedPath.isEmpty()) {
            return null
        }

        val principal = buildString {
            credentialSet.domain
                ?.trim()
                ?.takeIf { value -> value.isNotEmpty() }
                ?.let { domain ->
                    append(domain)
                    append(';')
                }
            append(credentialSet.username.trim())
        }.takeIf { value -> value.isNotBlank() }
        val userInfo = when {
            principal == null -> null
            credentialSet.password.isBlank() -> principal
            else -> "$principal:${credentialSet.password}"
        }

        return runCatching {
            URI(
                "smb",
                userInfo,
                normalizedHost,
                -1,
                "/$normalizedShareName/$normalizedPath",
                null,
                null
            ).toASCIIString()
        }.getOrNull()
    }

    private fun autoDetectSubtitleForCurrentSource() {
        if (subtitleDisabledByUser) {
            return
        }
        val manager = subtitleManager ?: return
        val currentSource = activeRequest
            ?.sources
            ?.getOrNull(playerManager.currentState().currentIndex.coerceAtLeast(0))
            ?: return
        val detectionResult = manager.autoDetectExternalSubtitle(Uri.parse(currentSource.uriValue))
        val subtitleFile = detectionResult.matchedFile ?: return
        val loaded = manager.loadExternalSubtitle(
            uri = Uri.fromFile(subtitleFile),
            mimeType = detectionResult.matchedMimeType ?: manager.resolveSubtitleMimeTypeFromName(subtitleFile.name) ?: return,
            isAutoDetected = true
        )
        if (loaded) {
            onSubtitleEnabled()
        }
    }

    private fun loadPickedSubtitle(uri: Uri) {
        val manager = subtitleManager ?: return
        runCatching {
            contentResolver.takePersistableUriPermission(uri, Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        val loaded = manager.loadExternalSubtitle(uri)
        if (loaded) {
            onSubtitleEnabled(getString(R.string.player_subtitle_feedback_loaded, uri.lastPathSegment ?: "subtitle"))
        }
    }

    private fun cycleSubtitleSource(): Boolean {
        val manager = subtitleManager ?: return false
        val sources = manager.availableSubtitleSources()
        if (sources.isEmpty()) {
            return false
        }

        val currentIndex = sources.indexOfFirst { it.isCurrentlySelected }.coerceAtLeast(0)
        val nextSource = sources[(currentIndex + 1) % sources.size]
        val changed = manager.selectSubtitleSource(nextSource.id)
        if (!changed) {
            return false
        }

        if (nextSource.id == "subtitle_source_off") {
            onSubtitleDisabled()
        } else {
            onSubtitleEnabled(getString(R.string.player_subtitle_feedback_loaded, nextSource.label))
        }
        return true
    }

    private fun onSubtitleEnabled(feedbackMessage: CharSequence? = null) {
        subtitleDisabledByUser = false
        feedbackMessage?.let(::showMessage)
        syncPlayerState()
    }

    private fun onSubtitleDisabled() {
        subtitleDisabledByUser = true
        showMessage(R.string.player_subtitle_feedback_none)
    }

    private fun initializeGestureOverlay() {
        gestureOverlay.visibility = View.GONE
        gestureOverlayCueView.text = ""
        gestureOverlayValueView.text = ""
    }

    private fun initializeGestureController() {
        currentWindowBrightness = resolveWindowBrightness()
        currentZoomScale = 1f
        gestureController = GestureController(
            playerView = playerView,
            onVolumeChange = ::applyVolumeDelta,
            onBrightnessChange = ::applyBrightnessDelta,
            onSeekDelta = ::applySeekDelta,
            onTogglePlayPause = ::togglePlayback,
            onFastForward = ::startTemporaryFastForward,
            onFastForwardEnd = ::endTemporaryFastForward,
            onZoom = ::applyZoomFactor,
            onSingleTapConfirmed = ::toggleChromeVisibility,
            onSingleTapWhileLocked = ::toggleUnlockButtonVisibility
        )
    }

    private fun initializeChromeLayoutBehavior() {
        ViewCompat.setOnApplyWindowInsetsListener(binding.playerRoot) { _, windowInsets ->
            val systemBarsInsets = windowInsets.getInsets(WindowInsetsCompat.Type.systemBars())
            topSystemInsetPx = systemBarsInsets.top
            bottomSystemInsetPx = systemBarsInsets.bottom
            renderChromeLayout(binding.playerRoot.height)
            windowInsets
        }
        binding.playerRoot.doOnLayout { root ->
            renderChromeLayout(root.height)
        }
        ViewCompat.requestApplyInsets(binding.playerRoot)
    }

    private fun updatePlaylistControls(state: PlaybackStateSnapshot) {
        val isPlaylist = state.playlistSize > 1
        skipPreviousButton.isEnabled = isPlaylist && state.hasPreviousMediaItem
        skipPreviousButton.alpha = if (skipPreviousButton.isEnabled) 1f else 0.3f
        skipNextButton.isEnabled = isPlaylist && state.hasNextMediaItem
        skipNextButton.alpha = if (skipNextButton.isEnabled) 1f else 0.3f
        shuffleButton.alpha = if (state.shuffleEnabled) 1f else 0.5f
        val repeatIconRes = when (state.repeatMode) {
            CxRepeatMode.Off -> R.drawable.ic_player_repeat_off
            CxRepeatMode.All -> R.drawable.ic_player_repeat_all
            CxRepeatMode.One -> R.drawable.ic_player_repeat_one
        }
        repeatButton.setImageResource(repeatIconRes)
    }

    private fun updateBottomChrome() {
        val state = playerManager.currentState()
        currentTimeView.text = if (state.hasActiveSession) {
            formatPlaybackTime(state.currentPositionMs)
        } else {
            getString(R.string.player_time_placeholder)
        }
        durationView.text = if (state.durationMs > 0L) {
            formatPlaybackTime(state.durationMs)
        } else {
            getString(R.string.player_time_placeholder)
        }
        seekBar.isEnabled = state.hasActiveSession && state.durationMs > 0L
        seekBar.max = if (state.durationMs > 0L) {
            min(state.durationMs, Int.MAX_VALUE.toLong()).toInt()
        } else {
            1000
        }
        seekBar.progress = min(state.currentPositionMs, seekBar.max.toLong()).toInt()
        val iconRes = if (state.hasActiveSession && state.playWhenReady) {
            R.drawable.ic_player_pause
        } else {
            R.drawable.ic_player_play
        }
        val descriptionRes = if (state.hasActiveSession && state.playWhenReady) {
            R.string.player_pause_content_description
        } else {
            R.string.player_play_content_description
        }
        playPauseButton.setImageResource(iconRes)
        playPauseButton.contentDescription = getString(descriptionRes)
        updatePlaylistControls(state)
    }

    private fun updateTopChrome() {
        titleView.text = resolveActiveTitle()
    }

    private fun applyVolumeDelta(delta: Float) {
        val volumeStep = delta.toInt()
        if (volumeStep == 0) {
            return
        }

        val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
        val targetVolume = (currentVolume + volumeStep).coerceIn(0, maxVolume)
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, targetVolume, 0)
        showGestureOverlay(
            GestureOverlayModel.formatVolume(resolvePercent(targetVolume, maxVolume))
        )
    }

    private fun applyBrightnessDelta(delta: Float) {
        currentWindowBrightness = (currentGestureBrightness() + delta).coerceIn(0.05f, 1f)
        window.attributes = window.attributes.apply {
            screenBrightness = currentWindowBrightness
        }
        showGestureOverlay(
            GestureOverlayModel.formatBrightness((currentWindowBrightness * 100f).roundToInt())
        )
    }

    private fun applySeekDelta(deltaMs: Long) {
        val state = playerManager.currentState()
        if (!state.hasActiveSession) {
            return
        }

        val maxPosition = state.durationMs.takeIf { it > 0L } ?: Long.MAX_VALUE
        val targetPosition = (state.currentPositionMs + deltaMs).coerceIn(0L, maxPosition)
        val appliedDelta = targetPosition - state.currentPositionMs
        seekToPosition(targetPosition)
        showGestureOverlay(GestureOverlayModel.formatSeekDelta(appliedDelta))
    }

    private fun togglePlayback() {
        val state = playerManager.currentState()
        if (state.hasActiveSession && state.playWhenReady) {
            pausePlayback()
        } else {
            playPlayback()
        }
    }

    private fun startTemporaryFastForward(speed: Float) {
        playerManager.setPlaybackSpeed(speed)
        showGestureOverlay(GestureOverlayModel.fastForwardActive(speedLabel = "2X"))
    }

    private fun endTemporaryFastForward() {
        playerManager.resetPlaybackSpeed()
        currentGestureOverlayState
            ?.takeIf { it.type == GestureOverlayType.FastForward }
            ?.let { overlayState ->
                showGestureOverlay(
                    GestureOverlayModel.scheduleDismiss(
                        current = overlayState,
                        updatedAtMs = SystemClock.uptimeMillis()
                    )
                )
            }
    }

    private fun applyZoomFactor(scaleFactor: Float) {
        currentZoomScale = (currentZoomScale * scaleFactor).coerceIn(1f, 3f)
        playerView.scaleX = currentZoomScale
        playerView.scaleY = currentZoomScale
    }

    private fun renderChromeLayout(rootHeight: Int) {
        if (rootHeight <= 0) {
            return
        }

        val compactChrome = rootHeight - topSystemInsetPx - bottomSystemInsetPx <
            resources.getDimensionPixelSize(R.dimen.player_compact_height_threshold)
        val horizontalPadding = resources.getDimensionPixelSize(R.dimen.player_chrome_horizontal_padding)
        val topVerticalPadding = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_chrome_compact_vertical_padding
            } else {
                R.dimen.player_top_chrome_vertical_padding
            }
        )
        val bottomTopPadding = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_chrome_compact_vertical_padding
            } else {
                R.dimen.player_bottom_chrome_top_padding
            }
        )
        val bottomBottomPadding = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_chrome_compact_bottom_padding
            } else {
                R.dimen.player_bottom_chrome_bottom_padding
            }
        )
        val transportRowTopMargin = resources.getDimensionPixelSize(
            if (compactChrome) {
                R.dimen.player_transport_row_margin_top_compact
            } else {
                R.dimen.player_transport_row_margin_top
            }
        )

        topChrome.updatePadding(
            left = horizontalPadding,
            top = topVerticalPadding + topSystemInsetPx,
            right = horizontalPadding,
            bottom = bottomTopPadding
        )
        bottomChrome.updatePadding(
            left = horizontalPadding,
            top = bottomTopPadding,
            right = horizontalPadding,
            bottom = bottomBottomPadding + bottomSystemInsetPx
        )
        (transportRow.layoutParams as? ViewGroup.MarginLayoutParams)?.let { layoutParams ->
            if (layoutParams.topMargin != transportRowTopMargin) {
                layoutParams.topMargin = transportRowTopMargin
                transportRow.layoutParams = layoutParams
            }
        }
        applyTransportExpandedState()
    }

    private fun formatPlaybackTime(positionMs: Long): String {
        val totalSeconds = positionMs.coerceAtLeast(0L) / 1_000L
        val seconds = totalSeconds % 60L
        val minutes = (totalSeconds / 60L) % 60L
        val hours = totalSeconds / 3_600L
        return if (hours > 0L) {
            String.format(Locale.ROOT, "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            String.format(Locale.ROOT, "%02d:%02d", minutes, seconds)
        }
    }

    private fun resolveActiveTitle(): String {
        val request = activeRequest ?: pendingLaunch?.request
        val source = request
            ?.sources
            ?.getOrNull(playerManager.currentState().currentIndex.coerceAtLeast(0))

        return source?.displayLabel
            ?.takeIf { it.isNotBlank() }
            ?: source?.uriValue?.let(::deriveTitleFromUri)
            ?: getString(R.string.player_title_fallback)
    }

    private fun deriveTitleFromUri(uriValue: String): String? {
        val uri = Uri.parse(uriValue)
        val lastSegment = uri.lastPathSegment
            ?.substringAfterLast('/')
            ?.takeIf { it.isNotBlank() }
        if (lastSegment != null) {
            return lastSegment
        }

        return uri.host?.takeIf { it.isNotBlank() }
    }

    private fun syncPlayerState() {
        if (!playerManager.currentState().hasActiveSession) {
            playerView.player = null
        }
        updateBottomChrome()
    }

    private fun showGestureOverlay(state: GestureOverlayState) {
        val resolvedState = GestureOverlayModel.replace(currentGestureOverlayState, state)
        currentGestureOverlayState = resolvedState
        gestureOverlay.removeCallbacks(hideGestureOverlayRunnable)
        gestureOverlayCueView.text = resolveGestureOverlayCueText(resolvedState)
        gestureOverlayValueView.text = resolvedState.valueText
        gestureOverlay.visibility = if (resolvedState.isVisible) View.VISIBLE else View.GONE

        if (!resolvedState.isStickyWhileGestureActive) {
            val dismissDelayMs = resolvedState.dismissDeadlineMs
                ?.let { deadline -> (deadline - SystemClock.uptimeMillis()).coerceAtLeast(0L) }
                ?: GESTURE_OVERLAY_AUTO_DISMISS_DELAY_MS
            gestureOverlay.postDelayed(hideGestureOverlayRunnable, dismissDelayMs)
        }
    }

    private fun resolveGestureOverlayCueText(state: GestureOverlayState): String {
        return when (state.type) {
            GestureOverlayType.Volume -> getString(R.string.player_gesture_overlay_volume_label)
            GestureOverlayType.Brightness -> getString(R.string.player_gesture_overlay_brightness_label)
            GestureOverlayType.SeekDelta -> if (state.valueText.startsWith("-")) {
                getString(R.string.player_gesture_overlay_seek_backward_label)
            } else {
                getString(R.string.player_gesture_overlay_seek_forward_label)
            }

            GestureOverlayType.FastForward -> getString(R.string.player_gesture_overlay_fast_forward_label)
        }
    }

    private fun resolvePercent(value: Int, maxValue: Int): Int {
        if (maxValue <= 0) {
            return 0
        }
        return ((value.toFloat() / maxValue.toFloat()) * 100f).roundToInt().coerceIn(0, 100)
    }

    private fun resolveWindowBrightness(): Float {
        return window.attributes.screenBrightness.takeIf { it >= 0f } ?: 0.5f
    }

    private fun showMessage(@StringRes messageResId: Int) {
        Toast.makeText(this, messageResId, Toast.LENGTH_SHORT).show()
    }

    private fun showMessage(message: CharSequence) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show()
    }

    // ═══════════════════════════════════════════════════════════
    // AI Subtitle Methods
    // ═══════════════════════════════════════════════════════════

    private fun toggleAiSubtitle() {
        val manager = aiSubtitleManager
        if (manager != null && manager.isActive.value) {
            stopAiSubtitle()
        } else {
            startAiSubtitle()
        }
    }

    private fun startAiSubtitle() {
        val apiKey = prefs.getString(PREF_SONIOX_API_KEY, null)
        if (apiKey.isNullOrBlank()) {
            showApiKeyDialog()
            return
        }
        doStartAiSubtitle(apiKey)
    }

    private fun doStartAiSubtitle(apiKey: String) {
        val manager = AiSubtitleManager(aiScope)
        aiSubtitleManager = manager
        val config = SonioxConfig(apiKey = apiKey)

        // Hook audio processor callback
        val renderersFactory = playerManager.renderersFactory()
        if (renderersFactory is CxRenderersFactory) {
            renderersFactory.audioProcessor.onPcmData = { pcmData ->
                manager.onAudioData(pcmData)
            }
        }

        manager.start(config)
        manager.updatePlaybackPosition(playerManager.currentState().currentPositionMs)
        showMessage(R.string.player_ai_subtitle_on)
        aiSubtitleButton.alpha = 1.0f
        aiSubtitleOverlay.visibility = View.VISIBLE

        // Collect subtitle events
        aiSubtitleCollectJob = aiScope.launch {
            manager.subtitleFlow.collect { event ->
                renderAiSubtitleEvent(event, manager.displayMode.value)
            }
        }

        // Collect connection state changes
        aiConnectionCollectJob = aiScope.launch {
            manager.connectionState.collectLatest { state ->
                updateAiConnectionStatus(state)
            }
        }

        aiPlaybackSyncJob = aiScope.launch {
            while (true) {
                manager.updatePlaybackPosition(playerManager.currentState().currentPositionMs)
                delay(AI_SUBTITLE_SYNC_INTERVAL_MS)
            }
        }
    }

    private fun stopAiSubtitle() {
        val manager = aiSubtitleManager ?: return
        val entries = manager.stop()

        // Clear audio callback
        val renderersFactory = playerManager.renderersFactory()
        if (renderersFactory is CxRenderersFactory) {
            renderersFactory.audioProcessor.onPcmData = null
        }

        aiSubtitleCollectJob?.cancel()
        aiConnectionCollectJob?.cancel()
        aiPlaybackSyncJob?.cancel()
        aiPlaybackSyncJob = null
        aiSubtitleManager = null
        aiSubtitleButton.alpha = 0.7f
        aiSubtitleOverlay.visibility = View.GONE
        aiSubtitleOriginalText.text = ""
        aiSubtitleTranslationText.text = ""
        showMessage(R.string.player_ai_subtitle_off)

        // Offer SRT export if we have entries
        if (entries.isNotEmpty()) {
            showSrtExportDialog(entries)
        }

        // Save to cache
        val videoUri = resolveCurrentVideoUri()
        if (videoUri != null && entries.isNotEmpty()) {
            aiScope.launch(Dispatchers.IO) {
                subtitleCacheManager.saveSubtitle(
                    videoUri = videoUri,
                    entries = entries,
                    language = "auto",
                    targetLanguage = "vi"
                )
            }
        }
    }

    private fun renderAiSubtitleEvent(event: SubtitleEvent, displayMode: SubtitleDisplayMode) {
        runOnUiThread {
            when (event) {
                is SubtitleEvent.Snapshot -> {
                    val showOriginal = displayMode != SubtitleDisplayMode.TRANSLATION_ONLY &&
                        event.originalText.isNotBlank()
                    val showTranslation = displayMode != SubtitleDisplayMode.ORIGINAL_ONLY &&
                        event.translationText.isNotBlank()

                    aiSubtitleOriginalText.text = event.originalText
                    aiSubtitleOriginalText.visibility = if (showOriginal) View.VISIBLE else View.GONE
                    aiSubtitleOriginalText.setTypeface(
                        null,
                        if (event.isOriginalProvisional) Typeface.ITALIC else Typeface.NORMAL
                    )

                    aiSubtitleTranslationText.text = event.translationText
                    aiSubtitleTranslationText.visibility = if (showTranslation) View.VISIBLE else View.GONE
                }
            }
        }
    }

    private fun updateAiConnectionStatus(state: ConnectionState) {
        runOnUiThread {
            when (state) {
                ConnectionState.CONNECTING -> {
                    aiSubtitleStatusText.text = getString(R.string.player_ai_subtitle_connecting)
                    aiSubtitleStatusText.visibility = View.VISIBLE
                }
                ConnectionState.RECONNECTING -> {
                    aiSubtitleStatusText.text = getString(R.string.player_ai_subtitle_reconnecting)
                    aiSubtitleStatusText.visibility = View.VISIBLE
                }
                ConnectionState.FAILED -> {
                    aiSubtitleStatusText.visibility = View.GONE
                    showMessage(R.string.player_ai_subtitle_failed)
                    stopAiSubtitle()
                }
                ConnectionState.ACTIVE -> {
                    aiSubtitleStatusText.visibility = View.GONE
                }
                else -> { /* IDLE, ERROR handled by reconnect */ }
            }
        }
    }

    private fun showApiKeyDialog() {
        val input = EditText(this).apply {
            hint = getString(R.string.player_ai_subtitle_api_key_hint)
            setSingleLine()
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.player_ai_subtitle_api_key_title)
            .setMessage(R.string.player_ai_subtitle_api_key_required)
            .setView(input)
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val key = input.text.toString().trim()
                if (key.isNotEmpty()) {
                    prefs.edit().putString(PREF_SONIOX_API_KEY, key).apply()
                    doStartAiSubtitle(key)
                }
            }
            .setNegativeButton(android.R.string.cancel, null)
            .show()
    }

    private fun showDisplayModeDialog() {
        val manager = aiSubtitleManager ?: return
        val modes = arrayOf(
            getString(R.string.player_ai_subtitle_mode_original),
            getString(R.string.player_ai_subtitle_mode_translation),
            getString(R.string.player_ai_subtitle_mode_both)
        )
        val currentIndex = when (manager.displayMode.value) {
            SubtitleDisplayMode.ORIGINAL_ONLY -> 0
            SubtitleDisplayMode.TRANSLATION_ONLY -> 1
            SubtitleDisplayMode.BOTH -> 2
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.player_ai_subtitle_display_mode_title)
            .setSingleChoiceItems(modes, currentIndex) { dialog, which ->
                val mode = when (which) {
                    0 -> SubtitleDisplayMode.ORIGINAL_ONLY
                    1 -> SubtitleDisplayMode.TRANSLATION_ONLY
                    else -> SubtitleDisplayMode.BOTH
                }
                manager.setDisplayMode(mode)
                updateDisplayModeVisibility(mode)
                dialog.dismiss()
            }
            .show()
    }

    private fun updateDisplayModeVisibility(mode: SubtitleDisplayMode) {
        when (mode) {
            SubtitleDisplayMode.ORIGINAL_ONLY -> {
                aiSubtitleOriginalText.visibility = View.VISIBLE
                aiSubtitleTranslationText.visibility = View.GONE
            }
            SubtitleDisplayMode.TRANSLATION_ONLY -> {
                aiSubtitleOriginalText.visibility = View.GONE
                aiSubtitleTranslationText.visibility = View.VISIBLE
            }
            SubtitleDisplayMode.BOTH -> {
                aiSubtitleOriginalText.visibility = View.VISIBLE
                aiSubtitleTranslationText.visibility = View.VISIBLE
            }
        }
    }

    private fun showSrtExportDialog(entries: List<com.cxplayer.data.model.SrtEntry>) {
        AlertDialog.Builder(this)
            .setTitle(R.string.player_ai_subtitle_export_title)
            .setMessage(R.string.player_ai_subtitle_export_message)
            .setPositiveButton(R.string.player_ai_subtitle_export_yes) { _, _ ->
                exportSrtFile(entries)
            }
            .setNegativeButton(R.string.player_ai_subtitle_export_no, null)
            .show()
    }

    private fun exportSrtFile(entries: List<com.cxplayer.data.model.SrtEntry>) {
        val downloadsDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
        val fileName = "CxPlayer_AI_${System.currentTimeMillis()}.srt"
        val file = File(downloadsDir, fileName)
        try {
            SrtExporter.write(entries, file)
            showMessage(getString(R.string.player_ai_subtitle_export_success, file.absolutePath))
        } catch (e: Exception) {
            showMessage("Export failed: ${e.message}")
        }
    }

    private fun resolveCurrentVideoUri(): String? {
        return activeRequest
            ?.sources
            ?.getOrNull(playerManager.currentState().currentIndex.coerceAtLeast(0))
            ?.uriValue
    }
}

private data class PendingLaunch(
    val request: PlaybackRequest,
    @param:StringRes val messageResId: Int?
)

data class PlaybackRequest(
    val sources: List<MediaSourceRef>,
    val startIndex: Int,
    val startPositionMs: Long,
    val origin: LaunchOrigin,
    val rawAction: String?
)

data class MediaSourceRef(
    val uriValue: String,
    val scheme: MediaScheme,
    val mimeType: String?,
    val isPlayableCandidate: Boolean,
    val displayLabel: String?
)

data class LaunchSourceCandidate(
    val rawValue: String,
    val mimeType: String?,
    val isAccessible: Boolean
)

data class LaunchRequestInput(
    val sources: List<LaunchSourceCandidate>,
    val startIndex: Int,
    val startPositionMs: Long,
    val origin: LaunchOrigin,
    val rawAction: String?
)

enum class LaunchOrigin {
    ExternalImplicit,
    InternalExplicit
}

enum class MediaScheme {
    Http,
    Https,
    Content,
    File,
    Smb;

    companion object {
        fun fromScheme(rawScheme: String?): MediaScheme? = when (rawScheme?.lowercase(Locale.ROOT)) {
            "http" -> Http
            "https" -> Https
            "content" -> Content
            "file" -> File
            "smb" -> Smb
            else -> null
        }
    }
}

sealed class LaunchOutcome(
    open val request: PlaybackRequest?,
    open val selectedIndex: Int,
    open val effectiveStartPositionMs: Long
) {
    data class Ready(
        override val request: PlaybackRequest,
        override val selectedIndex: Int,
        override val effectiveStartPositionMs: Long
    ) : LaunchOutcome(request, selectedIndex, effectiveStartPositionMs)

    data class FallbackSelected(
        override val request: PlaybackRequest,
        override val selectedIndex: Int,
        override val effectiveStartPositionMs: Long,
        @param:StringRes val messageResId: Int
    ) : LaunchOutcome(request, selectedIndex, effectiveStartPositionMs)

    data class Rejected(@param:StringRes val messageResId: Int) : LaunchOutcome(null, 0, 0L)
}

object PlayerLaunchExtras {
    const val EXTRA_MEDIA_URIS = "extra_media_uris"
    const val EXTRA_START_INDEX = "extra_start_index"
    const val EXTRA_START_POSITION_MS = "extra_start_position_ms"
}

object PlaybackRequestParser {
    private val supportedMimeTypes = setOf(
        "video/mp4",
        "video/3gpp",
        "video/webm",
        "video/x-matroska"
    )

    private val supportedExtensions = setOf("mp4", "3gp", "webm", "mkv")

    fun fromIntent(intent: Intent?, resolver: ContentResolver?): LaunchOutcome {
        if (intent == null) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val origin = if (intent.action == Intent.ACTION_VIEW || intent.data != null) {
            LaunchOrigin.ExternalImplicit
        } else {
            LaunchOrigin.InternalExplicit
        }

        val sourceCandidates = buildSourceCandidates(intent, resolver)
        if (sourceCandidates.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val requestInput = LaunchRequestInput(
            sources = sourceCandidates,
            startIndex = intent.getIntExtra(PlayerLaunchExtras.EXTRA_START_INDEX, 0),
            startPositionMs = intent
                .getLongExtra(PlayerLaunchExtras.EXTRA_START_POSITION_MS, 0L),
            origin = origin,
            rawAction = intent.action
        )

        return fromInput(requestInput)
    }

    fun fromInput(input: LaunchRequestInput): LaunchOutcome {
        if (input.sources.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_missing_source)
        }

        val sources = input.sources.mapNotNull { candidate ->
            buildMediaSource(candidate)
        }

        if (sources.isEmpty()) {
            return LaunchOutcome.Rejected(R.string.player_launch_error_unsupported_source)
        }

        val safeStartPosition = input.startPositionMs.coerceAtLeast(0L)
        val selectedIndex = input.startIndex.coerceIn(0, sources.lastIndex)
        val normalizedRequest = PlaybackRequest(
            sources = sources,
            startIndex = selectedIndex,
            startPositionMs = safeStartPosition,
            origin = input.origin,
            rawAction = input.rawAction
        )

        return if (selectedIndex == input.startIndex) {
            LaunchOutcome.Ready(
                request = normalizedRequest,
                selectedIndex = selectedIndex,
                effectiveStartPositionMs = safeStartPosition
            )
        } else {
            LaunchOutcome.FallbackSelected(
                request = normalizedRequest,
                selectedIndex = selectedIndex,
                effectiveStartPositionMs = safeStartPosition,
                messageResId = R.string.player_launch_error_invalid_index
            )
        }
    }

    private fun extractUris(intent: Intent): List<Uri> {
        val extraUris = getParcelableUris(intent)
        if (!extraUris.isNullOrEmpty()) {
            return extraUris
        }

        return listOfNotNull(intent.data)
    }

    private fun buildSourceCandidates(
        intent: Intent,
        resolver: ContentResolver?
    ): List<LaunchSourceCandidate> {
        return extractUris(intent).map { uri ->
            val normalizedUri = normalizeUri(uri)
            LaunchSourceCandidate(
                rawValue = normalizedUri.toString(),
                mimeType = resolveMimeType(normalizedUri, intent.type, resolver),
                isAccessible = canAccessSource(
                    normalizedUri,
                    MediaScheme.fromScheme(normalizedUri.scheme),
                    resolver
                )
            )
        }
    }

    private fun getParcelableUris(intent: Intent): ArrayList<Uri>? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            intent.getParcelableArrayListExtra(PlayerLaunchExtras.EXTRA_MEDIA_URIS, Uri::class.java)
        } else {
            @Suppress("DEPRECATION")
            intent.getParcelableArrayListExtra(PlayerLaunchExtras.EXTRA_MEDIA_URIS)
        }
    }

    private fun buildMediaSource(candidate: LaunchSourceCandidate): MediaSourceRef? {
        if (!candidate.isAccessible) {
            return null
        }

        val normalizedValue = normalizeUriValue(candidate.rawValue)
        val mediaScheme = MediaScheme.fromScheme(parseUri(normalizedValue)?.scheme) ?: return null
        if (!isSupportedVideo(normalizedValue, candidate.mimeType)) {
            return null
        }

        return MediaSourceRef(
            uriValue = normalizedValue,
            scheme = mediaScheme,
            mimeType = candidate.mimeType,
            isPlayableCandidate = true,
            displayLabel = normalizedValue.substringAfterLast('/')
        )
    }

    private fun normalizeUri(rawUri: Uri): Uri {
        val normalizedScheme = rawUri.scheme?.lowercase(Locale.ROOT)
        return rawUri.buildUpon().scheme(normalizedScheme).build()
    }

    private fun normalizeUriValue(rawValue: String): String {
        val parsedUri = parseUri(rawValue) ?: return rawValue
        val scheme = parsedUri.scheme?.lowercase(Locale.ROOT) ?: return rawValue
        return parsedUri.toString().replaceFirst("${parsedUri.scheme}:", "$scheme:")
    }

    private fun resolveMimeType(
        uri: Uri,
        intentMimeType: String?,
        resolver: ContentResolver?
    ): String? {
        return when {
            !intentMimeType.isNullOrBlank() -> intentMimeType.lowercase(Locale.ROOT)
            uri.scheme.equals("content", ignoreCase = true) && resolver != null -> {
                resolver.getType(uri)?.lowercase(Locale.ROOT)
            }

            else -> null
        }
    }

    private fun isSupportedVideo(uriValue: String, mimeType: String?): Boolean {
        if (mimeType != null && mimeType in supportedMimeTypes) {
            return true
        }

        val extension = uriValue.substringAfterLast('/')
            ?.substringAfterLast('.', missingDelimiterValue = "")
            ?.lowercase(Locale.ROOT)
            .orEmpty()

        return extension in supportedExtensions
    }

    private fun canAccessSource(
        uri: Uri,
        mediaScheme: MediaScheme?,
        resolver: ContentResolver?
    ): Boolean {
        if (mediaScheme == null) {
            return false
        }

        return when (mediaScheme) {
            MediaScheme.Http, MediaScheme.Https -> true
            MediaScheme.File -> uri.path?.let { File(it).exists() } == true
            MediaScheme.Smb -> true
            MediaScheme.Content -> {
                if (resolver == null) {
                    true
                } else {
                    try {
                        resolver.openAssetFileDescriptor(uri, "r")?.close()
                        true
                    } catch (_: SecurityException) {
                        false
                    } catch (_: FileNotFoundException) {
                        false
                    }
                }
            }
        }
    }

    private fun parseUri(rawValue: String): URI? {
        return try {
            URI.create(rawValue)
        } catch (_: IllegalArgumentException) {
            null
        }
    }
}

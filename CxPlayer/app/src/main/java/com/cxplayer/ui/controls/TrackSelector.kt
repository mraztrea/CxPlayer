package com.cxplayer.ui.controls

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.CheckedTextView
import android.widget.LinearLayout
import android.widget.PopupWindow
import android.widget.TextView
import com.cxplayer.R

internal enum class TrackSelectorSection {
    Audio,
    Subtitle
}

internal data class TrackSelectorOptionUiModel(
    val id: String,
    val label: String,
    val isSelected: Boolean,
    val isEnabled: Boolean = true
)

internal data class TrackSelectorSectionUiModel(
    val title: String,
    val emptyLabel: String,
    val options: List<TrackSelectorOptionUiModel>
)

internal data class TrackSelectorUiModel(
    val audioSection: TrackSelectorSectionUiModel,
    val subtitleSection: TrackSelectorSectionUiModel
)

internal data class TrackSelectorSelection(
    val section: TrackSelectorSection,
    val optionId: String
)

internal data class TrackSelectorPopupPlacement(
    val x: Int,
    val y: Int
)

internal class TrackSelector(
    private val context: Context
) {
    private var popupWindow: PopupWindow? = null

    fun show(
        anchor: View,
        model: TrackSelectorUiModel,
        onSelection: (TrackSelectorSelection) -> Unit
    ) {
        dismiss()
        val contentView = LayoutInflater.from(context).inflate(R.layout.popup_track_selector, null)
        val viewRefs = TrackSelectorViewRefs.bind(contentView)
        val rootView = anchor.rootView
        val viewport = android.graphics.Rect().also(rootView::getWindowVisibleDisplayFrame)
        val marginPx = (context.resources.displayMetrics.density * 12f).toInt()
        bindSection(
            container = viewRefs.audioContainer,
            emptyView = viewRefs.audioEmptyView,
            titleView = viewRefs.audioTitleView,
            section = TrackSelectorSection.Audio,
            model = model.audioSection,
            onSelection = onSelection
        )
        bindSection(
            container = viewRefs.subtitleContainer,
            emptyView = viewRefs.subtitleEmptyView,
            titleView = viewRefs.subtitleTitleView,
            section = TrackSelectorSection.Subtitle,
            model = model.subtitleSection,
            onSelection = onSelection
        )

        val availableWidth = ((viewport.width().takeIf { it > 0 } ?: rootView.width) - (marginPx * 2)).coerceAtLeast(1)
        val availableHeight = ((viewport.height().takeIf { it > 0 } ?: rootView.height) - (marginPx * 2)).coerceAtLeast(1)
        contentView.measure(
            View.MeasureSpec.makeMeasureSpec(availableWidth, View.MeasureSpec.AT_MOST),
            View.MeasureSpec.makeMeasureSpec(availableHeight, View.MeasureSpec.AT_MOST)
        )

        val anchorLocation = IntArray(2)
        anchor.getLocationInWindow(anchorLocation)
        val placement = resolvePopupPlacement(
            anchorLeft = anchorLocation[0],
            anchorTop = anchorLocation[1],
            anchorWidth = anchor.width,
            anchorHeight = anchor.height,
            popupWidth = contentView.measuredWidth.coerceAtLeast(1),
            popupHeight = contentView.measuredHeight.coerceAtLeast(1),
            viewportLeft = viewport.left,
            viewportTop = viewport.top,
            viewportRight = viewport.right,
            viewportBottom = viewport.bottom,
            marginPx = marginPx
        )

        popupWindow = PopupWindow(
            contentView,
            contentView.measuredWidth.coerceAtLeast(1),
            contentView.measuredHeight.coerceAtLeast(1),
            true
        ).apply {
            isOutsideTouchable = true
            isClippingEnabled = true
            setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
            elevation = anchor.resources.displayMetrics.density * 8f
        }
        popupWindow?.showAtLocation(rootView, Gravity.TOP or Gravity.START, placement.x, placement.y)
    }

    fun dismiss() {
        popupWindow?.dismiss()
        popupWindow = null
    }

    fun isShowing(): Boolean = popupWindow?.isShowing == true

    private fun bindSection(
        container: LinearLayout,
        emptyView: TextView,
        titleView: TextView,
        section: TrackSelectorSection,
        model: TrackSelectorSectionUiModel,
        onSelection: (TrackSelectorSelection) -> Unit
    ) {
        titleView.text = model.title
        container.removeAllViews()
        emptyView.text = model.emptyLabel
        emptyView.visibility = if (model.options.isEmpty()) View.VISIBLE else View.GONE
        container.visibility = if (model.options.isEmpty()) View.GONE else View.VISIBLE

        model.options.forEach { option ->
            val optionView = LayoutInflater.from(container.context)
                .inflate(R.layout.item_track_selector_option, container, false) as CheckedTextView
            optionView.text = option.label
            optionView.isChecked = option.isSelected
            optionView.isEnabled = option.isEnabled
            optionView.alpha = if (option.isEnabled) 1f else 0.5f
            optionView.setOnClickListener {
                if (!option.isEnabled) {
                    return@setOnClickListener
                }
                onSelection(TrackSelectorSelection(section = section, optionId = option.id))
                dismiss()
            }
            container.addView(optionView)
        }
    }

    companion object {
        internal fun resolvePopupPlacement(
            anchorLeft: Int,
            anchorTop: Int,
            anchorWidth: Int,
            anchorHeight: Int,
            popupWidth: Int,
            popupHeight: Int,
            viewportLeft: Int,
            viewportTop: Int,
            viewportRight: Int,
            viewportBottom: Int,
            marginPx: Int
        ): TrackSelectorPopupPlacement {
            val minX = viewportLeft + marginPx
            val maxX = (viewportRight - popupWidth - marginPx).coerceAtLeast(minX)
            val preferredX = anchorLeft + anchorWidth - popupWidth
            val resolvedX = preferredX.coerceIn(minX, maxX)

            val anchorBottom = anchorTop + anchorHeight
            val spaceBelow = viewportBottom - anchorBottom - marginPx
            val spaceAbove = anchorTop - viewportTop - marginPx
            val preferredY = if (spaceBelow >= popupHeight || spaceBelow >= spaceAbove) {
                anchorBottom
            } else {
                anchorTop - popupHeight
            }
            val minY = viewportTop + marginPx
            val maxY = (viewportBottom - popupHeight - marginPx).coerceAtLeast(minY)
            val resolvedY = preferredY.coerceIn(minY, maxY)

            return TrackSelectorPopupPlacement(x = resolvedX, y = resolvedY)
        }
    }
}

private data class TrackSelectorViewRefs(
    val audioTitleView: TextView,
    val audioEmptyView: TextView,
    val audioContainer: LinearLayout,
    val subtitleTitleView: TextView,
    val subtitleEmptyView: TextView,
    val subtitleContainer: LinearLayout
) {
    companion object {
        fun bind(root: View): TrackSelectorViewRefs {
            return TrackSelectorViewRefs(
                audioTitleView = root.findViewById(R.id.trackSelectorAudioTitleView),
                audioEmptyView = root.findViewById(R.id.trackSelectorAudioEmptyView),
                audioContainer = root.findViewById(R.id.trackSelectorAudioContainer),
                subtitleTitleView = root.findViewById(R.id.trackSelectorSubtitleTitleView),
                subtitleEmptyView = root.findViewById(R.id.trackSelectorSubtitleEmptyView),
                subtitleContainer = root.findViewById(R.id.trackSelectorSubtitleContainer)
            )
        }
    }
}
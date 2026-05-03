# Implementation Plan: Transport Row Redesign

**Branch**: `014-transport-row-redesign` | **Date**: 2026-05-03 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/011-transport-row-redesign/spec.md`

## Summary

Tổ chức lại bố cục transport row trong CxPlayer thành 2 trạng thái: thu gọn (collapsed) với 5 nút chính (PiP, Previous, Play/Pause, Next, Subtitle) và mở rộng (expanded) với thêm 1 hàng nút phụ (Shuffle, Rewind, Speed, Fast Forward, Repeat) phía trên. Nút Lock và Expand/Close nằm bên phải. Animation slide up/down cho chuyển đổi trạng thái.

## Technical Context

**Language/Version**: Kotlin (Android), XML layouts  
**Primary Dependencies**: AndroidX, Media3 (ExoPlayer), ViewBinding  
**Storage**: N/A (pure UI refactor)  
**Testing**: Manual UI testing trên thiết bị  
**Target Platform**: Android 7.0+ (API 24+)  
**Project Type**: Mobile app (Android video player)  
**Performance Goals**: Animation chuyển đổi < 300ms, 60fps  
**Constraints**: Giữ nguyên logic playback hiện tại, chỉ thay đổi bố cục UI  
**Scale/Scope**: 1 Activity (PlayerActivity), 1 layout file (activity_player.xml)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

Constitution chưa được cấu hình (placeholder). Không có gates cần kiểm tra — PASS.

## Project Structure

### Documentation (this feature)

```text
specs/011-transport-row-redesign/
├── plan.md              # This file
├── spec.md              # Feature specification
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output (minimal - UI state only)
└── checklists/
    └── requirements.md  # Spec quality checklist
```

### Source Code (repository root)

```text
CxPlayer/app/src/main/
├── res/layout/
│   └── activity_player.xml          # Layout chính — refactor bottom chrome
├── res/values/
│   ├── dimens.xml                   # Thêm/sửa dimensions cho expanded row
│   └── strings.xml                  # Content descriptions mới (nếu cần)
├── res/drawable/
│   └── ic_player_expand.xml         # Icon expand/close (nếu chưa có)
└── java/com/cxplayer/ui/player/
    └── PlayerActivity.kt            # Logic expand/collapse, binding, animation
```

**Structure Decision**: Single project, Android app. Thay đổi tập trung trong `CxPlayer/app/` module, chủ yếu ở layout XML và PlayerActivity.kt.

## Complexity Tracking

Không có violations — feature đơn giản, chỉ tổ chức lại UI layout.

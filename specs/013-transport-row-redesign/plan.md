# Implementation Plan: Transport Row Redesign

**Branch**: `013-transport-row-redesign` | **Date**: 2026-05-03 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/013-transport-row-redesign/spec.md`
**User Note**: Thu nhỏ height transport row, chỉ vừa 1 hàng nút.

## Summary

Tối ưu lại giao diện transport row theo ảnh mẫu: loại bỏ Function Row, gộp tất cả nút vào transport row dạng collapse/expand. Mặc định chỉ hiển thị 5 nút cơ bản (Resize, Prev, Play/Pause, Next, Subtitle) căn giữa. Nút Lock + Expand nằm floating bên phải. Khi expand, nút phụ xuất hiện ở hai đầu, nút cơ bản giữ nguyên vị trí giữa. Thu nhỏ height transport row chỉ vừa 1 hàng nút.

## Technical Context

**Language/Version**: Kotlin (Android), minSdk 24, targetSdk 35  
**Primary Dependencies**: AndroidX Media3 (ExoPlayer), ViewBinding  
**Storage**: N/A (chỉ thay đổi UI layout)  
**Testing**: Manual testing trên thiết bị  
**Target Platform**: Android 7.0+  
**Project Type**: Mobile App (Video Player)  
**Performance Goals**: Animation ≤ 300ms, smooth 60fps  
**Constraints**: Layout chỉ sử dụng XML + Kotlin, không dùng Compose  
**Scale/Scope**: Thay đổi 3-4 file (1 layout XML, 1 dimens XML, 1-2 Kotlin files, 1-2 drawable)

## Constitution Check

*GATE: Constitution template chưa được cấu hình — skip gate check.*

## Project Structure

### Documentation (this feature)

```text
specs/013-transport-row-redesign/
├── plan.md              # This file
├── spec.md              # Feature specification
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output (layout model)
├── checklists/
│   └── requirements.md  # Spec quality checklist
└── tasks.md             # Phase 2 output (by /speckit.tasks)
```

### Source Code (files affected)

```text
CxPlayer/app/src/main/
├── res/
│   ├── layout/
│   │   └── activity_player.xml         # Main layout - restructure transport row
│   ├── values/
│   │   └── dimens.xml                  # Update transport row dimensions
│   └── drawable/
│       ├── ic_player_expand.xml        # NEW: expand icon
│       └── ic_player_collapse.xml      # NEW: collapse icon
└── java/com/cxplayer/ui/player/
    └── PlayerActivity.kt               # Expand/collapse logic, remove Function Row code
```

**Structure Decision**: Thay đổi thuần UI — chỉ sửa layout XML, dimens, thêm 2 drawable icons, cập nhật PlayerActivity.kt.

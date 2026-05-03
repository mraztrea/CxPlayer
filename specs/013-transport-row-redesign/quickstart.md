# Quickstart: Transport Row Redesign

## Tổng quan thay đổi

Redesign transport row theo pattern collapse/expand:
- **Xoá** Function Row hoàn toàn
- **Thu nhỏ** transport row height (48dp, vừa 1 hàng nút)
- **Collapsed**: 5 nút cơ bản (Resize, Prev, Play, Next, Subtitle) căn giữa
- **Expanded**: Thêm 7 nút phụ ở hai đầu
- **Floating buttons**: Lock + Expand bên phải màn hình

## Files cần thay đổi

1. `CxPlayer/app/src/main/res/layout/activity_player.xml` — Restructure layout
2. `CxPlayer/app/src/main/res/values/dimens.xml` — Update dimensions
3. `CxPlayer/app/src/main/res/drawable/ic_player_expand.xml` — NEW
4. `CxPlayer/app/src/main/res/drawable/ic_player_collapse.xml` — NEW
5. `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt` — Expand/collapse logic

## Thứ tự triển khai

1. Tạo drawable icons mới (expand/collapse)
2. Sửa dimens.xml (thu nhỏ transport row)
3. Restructure activity_player.xml (xoá function row, thêm floating buttons, sắp xếp lại nút)
4. Cập nhật PlayerActivity.kt (xoá function row init, thêm expand/collapse logic)
5. Kiểm tra trên thiết bị

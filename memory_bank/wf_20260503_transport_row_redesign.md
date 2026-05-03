# Workflow: Transport Row Redesign

## Pham vi

- Refactor bottom chrome cua `PlayerActivity` thanh 2 trang thai collapsed/expanded.
- Thay `Spinner` toc do bang `TextView` click-to-cycle.
- Bo sung nut PiP va enable `supportsPictureInPicture` cho `PlayerActivity`.

## Files da sua

- `CxPlayer/app/src/main/AndroidManifest.xml`
- `CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt`
- `CxPlayer/app/src/main/java/com/cxplayer/ui/player/PlayerActivity.kt`
- `CxPlayer/app/src/main/res/drawable/ic_player_close.xml`
- `CxPlayer/app/src/main/res/drawable/ic_player_expand.xml`
- `CxPlayer/app/src/main/res/drawable/ic_player_pip.xml`
- `CxPlayer/app/src/main/res/layout/activity_player.xml`
- `CxPlayer/app/src/main/res/values/dimens.xml`
- `CxPlayer/app/src/main/res/values/strings.xml`
- `specs/011-transport-row-redesign/tasks.md`

## Xac thuc

- Build: `rtk proxy .\gradlew.bat :app:assembleDebug`
- Ket qua: `BUILD SUCCESSFUL`

## Huong dan manual

- Mo video va xac nhan hang transport collapsed mac dinh gom 5 nut: PiP, Previous, Play/Pause, Next, Subtitle.
- Bam Expand va xac nhan function row slide down/up dung 300ms, icon doi giua chevron va close.
- Bam Lock khi dang expanded va xac nhan function row collapse truoc khi chrome bi an.
- Cho chrome auto-hide khi dang expanded va xac nhan lan hien tiep theo quay ve collapsed.
- Xoay portrait/landscape va xac nhan expanded state duoc giu, layout khong vo.
- Thu PiP tren thiet bi ho tro Android 8+.

## Migration / Lenh bo sung

- Khong co migration database.
- Khong can lenh setup bo sung ngoai build verify o tren.

# Feature Specification: Player Launch Entry

**Feature Branch**: `[001-player-activity]`  
**Created**: 2026-04-29  
**Status**: Draft  
**Input**: User description: "Thực hiện task 1.2 trong _docs\plans\phase-1-core-player.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Open a video from another app (Priority: P1)

A user opens a supported video file or direct video link from a file manager, browser, or another app and is taken straight to the dedicated player screen.

**Why this priority**: Opening external video sources is the main entry point required to make the player usable in Phase 1.

**Independent Test**: From another app, open a supported video source and confirm the player screen launches with that source selected and ready to begin playback.

**Acceptance Scenarios**:

1. **Given** a supported single video source, **When** the user chooses to open it with the player, **Then** the player screen opens directly and targets that video.
2. **Given** a supported direct web video link, **When** the user opens it with the player, **Then** the player screen accepts the link and attempts playback without requiring manual re-entry.
3. **Given** a source shared through a content provider, **When** the player is selected, **Then** the player screen opens and uses the shared source if access is allowed.

### User Story 2 - Start from a selected item and position (Priority: P2)

A user or calling flow opens the player with multiple media sources and expects playback to begin from a chosen item and time offset.

**Why this priority**: Multi-item launch and resume offset support are part of the entry contract for the player screen.

**Independent Test**: Launch the player with multiple sources, a selected starting item, and a starting time; confirm the correct item is chosen and the requested starting point is honored when possible.

**Acceptance Scenarios**:

1. **Given** a launch request with multiple video sources, **When** the request includes a valid starting item index, **Then** the player opens on that selected item.
2. **Given** a launch request with a valid starting time, **When** the player loads the selected item, **Then** playback begins from that requested point or the nearest valid point within the media.

### User Story 3 - Receive clear feedback for invalid launch requests (Priority: P3)

A user should not see a crash or blank player screen when the incoming launch request is missing data or contains unsupported media.

**Why this priority**: Invalid launch handling protects the app experience and keeps the player entry point trustworthy.

**Independent Test**: Trigger launch requests with missing sources, invalid selected item references, and unsupported media types; confirm the app fails gracefully with clear feedback.

**Acceptance Scenarios**:

1. **Given** a launch request with no playable sources, **When** the player is opened, **Then** the user receives a clear error outcome and playback does not start.
2. **Given** a launch request that references an item outside the available source list, **When** the player opens, **Then** the app falls back to a safe default item or stops with clear feedback instead of crashing.
3. **Given** an unsupported media type, **When** the user routes it to the player, **Then** the app rejects the request cleanly without entering a broken playback state.

### Edge Cases

- A direct web link is syntactically valid but unreachable at the time the player is opened.
- A shared content source is selected but the calling app no longer grants access permission.
- The requested starting time is greater than the media duration.
- The launch request contains duplicate or partially invalid sources.
- The player is asked to open a playlist where only some items are playable.

## Requirements *(mandatory)*

### Functional Requirements

- FR-001: The system MUST provide a dedicated full-screen player entry screen for playback requests handled in Phase 1.
- FR-002: The system MUST accept playback launch requests containing one or more video sources.
- FR-003: The system MUST support launch requests originating from direct web links, local file paths, and shared content sources.
- FR-004: The system MUST recognize supported video formats defined for Phase 1 and route them to the player entry screen.
- FR-005: When a launch request contains multiple sources, the system MUST allow the request to identify which source opens first.
- FR-006: When a launch request contains a starting playback position, the system MUST attempt to begin from that point or the nearest valid point within the selected media.
- FR-007: If the requested starting source is invalid for the provided source list, the system MUST fail safely by choosing a valid fallback source or presenting a clear error outcome.
- FR-008: If a launch request contains no playable sources, the system MUST prevent playback start and present a clear user-facing failure outcome.
- FR-009: If the player cannot access a provided source because the source is unavailable or permission is missing, the system MUST present a clear failure outcome without crashing.
- FR-010: The system MUST open repeated requests to the player in a way that avoids creating stacked duplicate player experiences for the same user flow.
- FR-011: The system MUST keep the scope of this feature limited to launch entry, source selection, and initial start position; playback controls, lifecycle restoration, and screen layout behavior are out of scope for this specification.

### Key Entities *(include if feature involves data)*

- **Playback Request**: The incoming request that identifies the list of video sources, the preferred starting source, and the preferred starting position.
- **Media Source**: A playable video target supplied from a local file, shared content source, or direct web link.
- **Launch Outcome**: The result of handling a playback request, including successful player entry or a clear failure outcome.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- SC-001: 95% of valid single-source launch requests open the player on the requested media within 3 seconds under normal device conditions.
- SC-002: 95% of valid direct web video launch requests show the player on the requested media within 5 seconds under normal network conditions.
- SC-003: 100% of invalid or unsupported launch requests end with a clear failure outcome and no application crash.
- SC-004: In test scenarios with multiple valid sources, the requested starting source is selected correctly in 100% of cases.
- SC-005: In test scenarios with a valid starting position, playback begins at the requested point or nearest valid point in at least 95% of cases.

## Assumptions

- Phase 1 only needs to support the video source types and formats called out in task 1.2 of the core player plan.
- This feature defines the player entry behavior only; on-screen controls, gestures, lifecycle handling, and playback state restoration are specified in later tasks.
- When a start position exceeds the selected media length, the player may clamp to the nearest valid point instead of rejecting the request.
- Clear failure outcomes may be shown as in-app messaging or equivalent user-visible feedback, as long as the app does not crash or leave the user in a broken state.

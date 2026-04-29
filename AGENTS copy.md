## 🚨 CRITICAL RULE: Reference Code 🚨

- You may specifically read these files to understand intended behavior, design patterns, or legacy logic, but you must implement the solutions afresh in the appropriate `apps/` or `share/` directories following the project's current architecture (Clean Architecture/NestJS/Next.js).
- Sử dụng tiếng Việt Nam để tạo tài liệu và phản hồi cho tôi.
- Nếu sửa vào nhiều file code, hãy tạo 1 file work flow , tên file dạng wf_{YYYYMMDD}_{tên workflow}.md trong thư mục memory_bank. Nếu quá trình làm việc cần migrate database hay cần chạy lệnh gì, hãy thêm hướng dẫn vào file này.
**- Lập trình trên môi trường windows nên hãy sử dụng các lệnh terminal của PowerShell (sử dụng pwsh  thay cho powershell), không sử dụng các lệnh linux.**
- Nội dung của git commit phải sử dụng tiếng Việt. Vẫn giữ nguyên các tiền tố như: "fix", "feat", "docs", "style", "refactor", "perf", "test", "chore", "revert".
- Nếu cần sử dụng Code-Index MCP, hãy thực hiện set_project_path và index project trước khi bắt đầu sử dụng.
- Nếu cần sử dụng codebase-memory-mcp, hãy thực hiện index_repository trước khi bắt đầu sử dụng.
- Nếu cần sử dụng Serena MCP, hãy thực hiện `activate_project` và `check_onboarding_performed` trước khi bắt đầu sử dụng. Chi tiết xem mục **Serena MCP** bên dưới.
- Không sử dụng Morph-Mcp để search codebase (warpgrep_codebase_search), chỉ sử dụng để edit file (edit_file tool).


# First Rule

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---
**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

## 📁 Quy tắc tổ chức thư mục Usecases

Khi tạo usecase mới trong bất kỳ module nào (ví dụ: `applications`, `jobs`, `users`...), **PHẢI** phân loại vào đúng thư mục con theo chức năng:

```
usecases/
├── submission/   # Tạo mới entity + side-effects (tạo record, snapshot, schedule job, thông báo sau khi tạo)
├── workflow/     # Chuyển trạng thái / state transition (confirm, reject, pay, approve...)
├── queries/      # Truy vấn / đọc dữ liệu (get, list, check, search...)
└── helpers/      # Utility functions / helpers dùng chung bởi nhiều usecase
```

**Ví dụ thực tế** (`apps/api-portal/src/modules/applications/core/application/usecases/`):

| Nhóm | File |
|------|------|
| `submission/` | `apply-job`, `introduce-cv`, `handle-apply-post-create`, `handle-submit-cv-post-create` |
| `workflow/` | `admin-confirm-candidate`, `candidate-confirm-application`, `candidate-reject-application`, `employer-pay-application`, `employer-reject-application` |
| `queries/` | `check-apply-status`, `get-employer-applications`, `get-employer-application-detail` |
| `helpers/` | `application-notification.helper`, `application-workflow.helper` |

> **Lý do:** Khi số lượng usecase tăng nhiều, việc phân nhóm giúp dễ navigate, dễ maintain và thể hiện rõ Clean Architecture (Command vs Query separation).


# Chú ý logic:
- Các endpoint API của Admin phải sử dụng tiền tố v1/admin/. Không sử dụng chung với API Endpoint của User (v1/).
- Các selectbox có lượng dữ liệu lớn đều dùng theo cách này (hiển thị Autocomplete, fetch data khi người dùng gõ tìm kiếm, debounce API call, không render tất cả data ra DOM một lúc).
- Toàn bộ dự án đều dùng chung 1 drive storage được cấu hình trong file `apps\api-portal\.env` (Hiện tại đang set `FILE_STORAGE_DRIVER=s3`).


## 📧 Quy tắc tạo Email / Templates
- Tất cả các email được tạo ra sau này đều phải tuân thủ chuẩn: **Căn lề trái (Align Left)** phần nội dung (không sử dụng align center). Mặc định khai báo cục bộ hoặc thêm class hỗ trợ căn trái.

## 🎨 UI & Styling
- Mặc định sử dụng màu primary của hệ thống là `#17677b` (trong Tailwind ứng với class `brand-500` hoặc các class `brand-*`). Tránh tự ý sử dụng các màu mặc định như `blue-600`, hãy dùng `brand-500`.

# Hướng dẫn tham khảo code cũ

**Tham khảo về cấu trúc dự án cần xây dựng:**
- [architecture-and-design-patterns.md](docs/architecture-and-design-patterns.md)
- [GitNexus](repo "recland-v3"):Sử dụng GitNexus với Repo "recland-v3" để tham khảo cấu trúc code cũ. (đây là phiên bản cũ V3)
**Tham khảo về logic xử lý luồng tuyển dụng:**
- [GitNexus](repo "Recland"): Sử dụng GitNexus với Repo "Recland" để tham khảo logic xử lý luồng tuyển dụng. (đây là phiên bản cũ V2, sử dụng Laravel và VueJS)


## 📚 LLM Wiki — Quy tắc tra cứu & cập nhật luồng tuyển dụng

### TRƯỚC khi thực hiện skill `speckit-specify` liên quan đến luồng tuyển dụng
**BẮT BUỘC** đọc wiki trước khi viết spec — để spec biết bối cảnh đã implement:
1. Đọc `_wiki/wiki/syntheses/status-implementation-audit.md` — xem trạng thái nào **đã** / **chưa** implement, tránh re-implement hoặc bỏ sót dependency
2. Đọc `_wiki/wiki/INDEX.md` — tìm entity/concept liên quan đến feature đang cần spec
3. Đọc các trang wiki entity liên quan (ví dụ: `_wiki/wiki/entities/admin-pending-approval.md`, `_wiki/wiki/concepts/state-machine-overview.md`)

> **Lý do:** Spec mới phải biết trạng thái hiện tại của codebase, logic nghiệp vụ đã ghi nhận, và P priority còn dở để tránh mâu thuẫn.

### SAU KHI skill `speckit-implement` hoàn thành
**BẮT BUỘC** cập nhật wiki ngay sau khi implement xong:
1. **Cập nhật `_wiki/wiki/syntheses/status-implementation-audit.md`:**
   - Đánh dấu trạng thái mới implement là ✅ Đầy đủ
   - Ghi rõ: usecase file path, controller endpoint, notification logic, frontend component
   - Cập nhật bảng tổng quan (số đã implement / tổng)
   - Đánh ~~strikethrough~~ những priority đã done trong bảng `Ưu tiên triển khai`
2. **Thêm entry vào `_wiki/wiki/LOG.md`:**
   - Format: `### UPDATE — Spec XXX hoàn thành: [tên feature]`
   - Nội dung: ngày, spec ID, files tạo/sửa, logic đặc biệt cần ghi nhớ (ví dụ: NTD không nhận thông báo khi reject, lý do lưu vào note)
3. Cập nhật frontmatter `updated:` của file synthesis

> **Wiki root:** `_wiki/` — đọc `_wiki/CLAUDE.md` để hiểu schema trước khi sửa


<!-- serena:start -->
## 🧠 Serena MCP — Semantic Code Intelligence & Memory

Dự án này sử dụng **Serena MCP** để cung cấp khả năng điều hướng code theo ngữ nghĩa (semantic) và lưu trữ context qua các phiên làm việc.

### Khởi tạo bắt buộc (mỗi phiên làm việc mới)

**TRƯỚC KHI bắt đầu bất kỳ task nào**, PHẢI thực hiện tuần tự:
1. `activate_project({ project: "d:\\Projects\\HRI\\recland-v4" })` — Kích hoạt dự án.
2. `check_onboarding_performed()` — Kiểm tra onboarding đã hoàn thành chưa.
3. Nếu **chưa** onboard → gọi `onboarding()`, thu thập thông tin dự án và ghi vào memory.
4. Nếu **đã** onboard → đọc memory `project_overview` và `style_and_conventions` để nạp context.

### Ưu tiên sử dụng Serena tools cho Code Navigation

Khi cần tìm hiểu, điều hướng, hoặc chỉnh sửa code, **ưu tiên Serena MCP tools** theo thứ tự:

| Mục đích | Tool Serena | Thay vì |
|----------|-------------|---------|
| Xem tổng quan symbols trong file | `get_symbols_overview` | Đọc toàn bộ file |
| Tìm định nghĩa function/class | `find_symbol` | `grep_search` |
| Xem body của 1 symbol cụ thể | `find_symbol` (include_body=true) | `view_file` toàn bộ |
| Tìm ai gọi/tham chiếu tới symbol | `find_referencing_symbols` | `grep_search` |
| Sửa nội dung function/method | `replace_symbol_body` | Edit thủ công |
| Thêm code sau 1 symbol | `insert_after_symbol` | Edit thủ công |
| Đổi tên symbol toàn codebase | `rename_symbol` | Find & Replace |

### Lưu Memory sau Task

Khi hoàn thành task phức tạp hoặc phát hiện pattern/convention quan trọng:
- Sử dụng `write_memory` để ghi lại thông tin hữu ích cho các phiên sau.
- Tổ chức memory theo topic (ví dụ: `auth/login_flow`, `applications/state_machine`).
- Đọc memory bằng `read_memory` khi bắt đầu task liên quan.

### Không bao giờ

- KHÔNG bắt đầu làm việc mà chưa `activate_project` + `check_onboarding_performed`.
- KHÔNG đọc toàn bộ file khi chỉ cần xem 1 function — dùng `find_symbol` với `include_body=true`.
- KHÔNG dùng grep để tìm định nghĩa symbol — dùng `find_symbol`.
- KHÔNG dùng find & replace để đổi tên symbol — dùng `rename_symbol`.
<!-- serena:end -->


<!-- gitnexus:start -->
# GitNexus — Code Intelligence

This project is indexed by GitNexus as **recland-v4** (15910 symbols, 27827 relationships, 300 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

> If any GitNexus tool warns the index is stale, run `npx gitnexus analyze` in terminal first.

## Always Do

- **MUST run impact analysis before editing any symbol.** Before modifying a function, class, or method, run `gitnexus_impact({target: "symbolName", direction: "upstream"})` and report the blast radius (direct callers, affected processes, risk level) to the user.
- **MUST run `gitnexus_detect_changes()` before committing** to verify your changes only affect expected symbols and execution flows.
- **MUST warn the user** if impact analysis returns HIGH or CRITICAL risk before proceeding with edits.
- When exploring unfamiliar code, use `gitnexus_query({query: "concept"})` to find execution flows instead of grepping. It returns process-grouped results ranked by relevance.
- When you need full context on a specific symbol — callers, callees, which execution flows it participates in — use `gitnexus_context({name: "symbolName"})`.

## Never Do

- NEVER edit a function, class, or method without first running `gitnexus_impact` on it.
- NEVER ignore HIGH or CRITICAL risk warnings from impact analysis.
- NEVER rename symbols with find-and-replace — use `gitnexus_rename` which understands the call graph.
- NEVER commit changes without running `gitnexus_detect_changes()` to check affected scope.

## Resources

| Resource | Use for |
|----------|---------|
| `gitnexus://repo/recland-v4/context` | Codebase overview, check index freshness |
| `gitnexus://repo/recland-v4/clusters` | All functional areas |
| `gitnexus://repo/recland-v4/processes` | All execution flows |
| `gitnexus://repo/recland-v4/process/{name}` | Step-by-step execution trace |

## CLI

| Task | Read this skill file |
|------|---------------------|
| Understand architecture / "How does X work?" | `.claude/skills/gitnexus/gitnexus-exploring/SKILL.md` |
| Blast radius / "What breaks if I change X?" | `.claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md` |
| Trace bugs / "Why is X failing?" | `.claude/skills/gitnexus/gitnexus-debugging/SKILL.md` |
| Rename / extract / split / refactor | `.claude/skills/gitnexus/gitnexus-refactoring/SKILL.md` |
| Tools, resources, schema reference | `.claude/skills/gitnexus/gitnexus-guide/SKILL.md` |
| Index, status, clean, wiki CLI commands | `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` |

<!-- gitnexus:end -->


<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
at `specs/137-email-activation/plan.md`
<!-- SPECKIT END -->

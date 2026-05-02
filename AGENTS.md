<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan:
`specs/010-ai-subtitle-generation/plan.md`
<!-- SPECKIT END -->

## 🚨 CRITICAL RULE: Reference Code 🚨

- Sử dụng tiếng Việt Nam để tạo tài liệu và phản hồi cho tôi.
- Nếu sửa vào nhiều file code, hãy tạo 1 file work flow , tên file dạng wf_{YYYYMMDD}_{tên workflow}.md trong thư mục memory_bank. Nếu quá trình làm việc cần migrate database hay cần chạy lệnh gì, hãy thêm hướng dẫn vào file này.
**- Lập trình trên môi trường windows nên hãy sử dụng các lệnh terminal của PowerShell (sử dụng pwsh  thay cho powershell), không sử dụng các lệnh linux.**
- Nội dung của git commit phải sử dụng tiếng Việt. Vẫn giữ nguyên các tiền tố như: "fix", "feat", "docs", "style", "refactor", "perf", "test", "chore", "revert"
- **CHANGELOG TRACKING**: Mỗi khi hoàn thành sửa/thêm 1 tính năng, PHẢI update dòng "Hello $name!" trong [MainActivity.kt](CxPlayer/app/src/main/java/com/cxplayer/MainActivity.kt#L36) thành changelog ngắn gọn. Format: `[FEATURE/FIX]: Mô tả tính năng - ngày giờ`. Ví dụ: `[FEATURE]: Track selector UI - 2026-05-01` hoặc `[FIX]: Subtitle timing sync - 2026-05-01`. Kể cả sửa 1 dòng code cũng phải update lại dòng này.
- Nếu cần sử dụng Serena MCP, hãy thực hiện `activate_project` và `check_onboarding_performed` trước khi bắt đầu sử dụng. Chi tiết xem mục **Serena MCP** bên dưới.

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

This project is indexed by GitNexus as **CxPlayer** (1888 symbols, 4907 relationships, 154 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

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
| `gitnexus://repo/CxPlayer/context` | Codebase overview, check index freshness |
| `gitnexus://repo/CxPlayer/clusters` | All functional areas |
| `gitnexus://repo/CxPlayer/processes` | All execution flows |
| `gitnexus://repo/CxPlayer/process/{name}` | Step-by-step execution trace |

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


# context-mode — MANDATORY routing rules

You have context-mode MCP tools available. These rules are NOT optional — they protect your context window from flooding. A single unrouted command can dump 56 KB into context and waste the entire session. Antigravity does NOT have hooks, so these instructions are your ONLY enforcement mechanism. Follow them strictly.

## Think in Code — MANDATORY

When you need to analyze, count, filter, compare, search, parse, transform, or process data: **write code** that does the work via `mcp__context-mode__ctx_execute(language, code)` and `console.log()` only the answer. Do NOT read raw data into context to process mentally. Your role is to PROGRAM the analysis, not to COMPUTE it. Write robust, pure JavaScript — no npm dependencies, only Node.js built-ins (`fs`, `path`, `child_process`). Always use `try/catch`, handle `null`/`undefined`, and ensure compatibility with both Node.js and Bun. One script replaces ten tool calls and saves 100x context.

## BLOCKED commands — do NOT use these

### curl / wget — FORBIDDEN
Do NOT use `curl` or `wget` via `run_command`. They dump raw HTTP responses directly into your context window.
Instead use:
- `mcp__context-mode__ctx_fetch_and_index(url, source)` to fetch and index web pages
- `mcp__context-mode__ctx_execute(language: "javascript", code: "const r = await fetch(...)")` to run HTTP calls in sandbox

### Inline HTTP — FORBIDDEN
Do NOT run inline HTTP calls via `run_command` with `node -e "fetch(..."`, `python -c "requests.get(..."`, or similar patterns. They bypass the sandbox and flood context.
Instead use:
- `mcp__context-mode__ctx_execute(language, code)` to run HTTP calls in sandbox — only stdout enters context

### Direct web fetching — FORBIDDEN
Do NOT use `read_url_content` for large pages. Raw HTML can exceed 100 KB.
Instead use:
- `mcp__context-mode__ctx_fetch_and_index(url, source)` then `mcp__context-mode__ctx_search(queries)` to query the indexed content

## REDIRECTED tools — use sandbox equivalents

### Shell (>20 lines output)
`run_command` is ONLY for: `git`, `mkdir`, `rm`, `mv`, `cd`, `ls`, `npm install`, `pip install`, and other short-output commands.
For everything else, use:
- `mcp__context-mode__ctx_batch_execute(commands, queries)` — run multiple commands + search in ONE call
- `mcp__context-mode__ctx_execute(language: "shell", code: "...")` — run in sandbox, only stdout enters context

### File reading (for analysis)
If you are reading a file to **edit** it → `view_file` / `replace_file_content` is correct (edit needs content in context).
If you are reading to **analyze, explore, or summarize** → use `mcp__context-mode__ctx_execute_file(path, language, code)` instead. Only your printed summary enters context. The raw file stays in the sandbox.

### Search (large results)
Search results can flood context. Use `mcp__context-mode__ctx_execute(language: "shell", code: "grep ...")` to run searches in sandbox. Only your printed summary enters context.

## Tool selection hierarchy

1. **GATHER**: `mcp__context-mode__ctx_batch_execute(commands, queries)` — Primary tool. Runs all commands, auto-indexes output, returns search results. ONE call replaces 30+ individual calls. Each command: `{label: "descriptive header", command: "..."}`. Label becomes FTS5 chunk title — descriptive labels improve search.
2. **FOLLOW-UP**: `mcp__context-mode__ctx_search(queries: ["q1", "q2", ...])` — Query indexed content. Pass ALL questions as array in ONE call.
3. **PROCESSING**: `mcp__context-mode__ctx_execute(language, code)` | `mcp__context-mode__ctx_execute_file(path, language, code)` — Sandbox execution. Only stdout enters context.
4. **WEB**: `mcp__context-mode__ctx_fetch_and_index(url, source)` then `mcp__context-mode__ctx_search(queries)` — Fetch, chunk, index, query. Raw HTML never enters context.
5. **INDEX**: `mcp__context-mode__ctx_index(content, source)` — Store content in FTS5 knowledge base for later search.

## Output constraints

- Keep responses under 500 words.
- Write artifacts (code, configs, PRDs) to FILES — never return them as inline text. Return only: file path + 1-line description.
- When indexing content, use descriptive source labels so others can `search(source: "label")` later.

## ctx commands

| Command | Action |
|---------|--------|
| `ctx stats` | Call the `stats` MCP tool and display the full output verbatim |
| `ctx doctor` | Call the `doctor` MCP tool, run the returned shell command, display as checklist |
| `ctx upgrade` | Call the `upgrade` MCP tool, run the returned shell command, display as checklist |
| `ctx purge` | Call the `purge` MCP tool with confirm: true. Warns before wiping the knowledge base. |

After /clear or /compact: knowledge base and session stats are preserved. Use `ctx purge` if you want to start fresh.

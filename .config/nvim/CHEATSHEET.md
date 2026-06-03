# IDE Cheatsheet (tmux + nvim)

Quick reference. For a walkthrough if you're new to nvim, see `BEGINNERS-GUIDE.md`.

> **Tip:** in nvim, press `Space` and pause — **which-key** pops up a menu of every shortcut. You rarely need to memorize this sheet.

---

## Layer 1 — the IDE frame (tmux)

Launch with `ide` (or `ide ~/path/to/project`). The tmux **prefix** is `Ctrl-b` — press it, release, then the key.

| Keys | Action |
|------|--------|
| `ide` | open the IDE (or re-attach if already running) |
| `C-b b` | toggle the **left Claude sidebar** (keeps its session + history) |
| `C-b t` | toggle the **bottom terminal** |
| `C-b g` | **lazygit** popup (git operations) over the current repo |
| `C-b r` | reload tmux config |
| `C-b h/j/k/l` | move between tmux panes |
| `C-b d` | detach (leaves everything running; `ide` re-attaches) |
| `C-b Q` | **close** the IDE session entirely (asks y/n) |
| `ide close` | close just **this** IDE window (others keep running; ends the session if it's the last window). `ide stop` is the same |
| `ide kill` | tear down the **whole** IDE session (every window) |
| `C-b |` / `C-b -` | manual vertical / horizontal tmux split |
| `C-b C-q` | cut the current pane into **quarters** (2×2 grid: TL, TR, BL, BR); cursor lands top-left |

Editor defaults to `nvim`. Run `IDE_EDITOR=vim ide` to use vim instead.

---

## Layer 2 — the editor (nvim) · leader = `Space`

### Files & search
| Keys | Action |
|------|--------|
| `Space f f` | find files (fuzzy) |
| `Space f g` | grep a keyword across all files (preview = peek, `Enter` = open) |
| `Space f w` | grep the word under the cursor |
| `Space f b` | jump between open files (buffers) |
| `Space f r` | resume the last search |
| `Space f h` | search help docs |

Inside the search popup: type to filter · `Ctrl-n`/`Ctrl-p` (or arrows) move · `Enter` opens · `Ctrl-v` opens in a vertical split · `Ctrl-x` in a horizontal split · `Esc` (twice) closes.

### File tree (right side)
| Keys | Action |
|------|--------|
| `Space e` | toggle the file tree |
| `Space o` | jump focus into the tree |

Inside the tree: `Enter` open · `a` add file/dir · `d` delete · `r` rename · `c` copy · `x` cut · `p` paste · `H` toggle hidden files · `?` show all tree keys.

### Splits (windows)
| Keys | Action |
|------|--------|
| `Space s v` | split vertically |
| `Space s h` | split horizontally |
| `Space s x` | close this split |
| `Space s o` | close all *other* splits |
| `Space s e` | equalize split sizes |
| `Ctrl-h/j/k/l` | move focus left/down/up/right |
| `Space w h/j/k/l` | **relocate** the split (far-left/bottom/top/far-right) |
| `Ctrl-arrows` | resize the current split |

### Tabs & groups
Each **tab page** is an "editor group" with its own tab strip (via scope.nvim) — the top strip only shows files belonging to the group you're in.
| Keys | Action |
|------|--------|
| `Shift-h` / `Shift-l` | previous / next file **within the current group** |
| `Space b p` | pick a file in the group by letter |
| `Space b d` | close the current file |
| `Space t n` | new **group** (tab page) with its own file set |
| `Space t c` | close the group |
| `Space ]` / `Space [` | switch to next / previous group |

### Git
| Keys | Action |
|------|--------|
| `Space g d` | **diff your branch vs dev** (auto-detects dev/develop/main/master) |
| `Space g c` | close the diff view |
| `Space g h` | history of the current file |
| `Space g H` | history of the whole repo |
| `]c` / `[c` | next / previous change in the current file |
| `Space g p` | preview the change under the cursor |
| `Space g b` | git blame for the current line |
| `Space g s` / `Space g r` | stage / reset the change under the cursor |
| `C-b g` (tmux) | full lazygit TUI for everything else |

Inside the diff view: `Tab`/`Shift-Tab` cycle changed files · `Space g c` closes it.

### Code intelligence (clangd / LSP)
Powered by **clangd** (C/C++). Linting is automatic — clangd runs clang-tidy and underlines problems as you go. These maps are active in any file the language server attached to.
| Keys | Action |
|------|--------|
| `g d` | **jump to definition** (Telescope: preview it, or `Ctrl-v`/`Ctrl-x` to open in a v/h split) |
| `Space c v` / `Space c h` | jump to definition in a **new vertical / horizontal split** |
| `g D` | jump to declaration |
| `g i` | jump to implementation |
| `g y` | jump to type definition |
| `g r` | find all **references** |
| `K` | **hover** — show docs / signature for the symbol under the cursor |
| `Space c a` | code **action** (quick-fixes, includes) |
| `Space c r` | **rename** the symbol everywhere |
| `Space c f` | format the buffer |
| `Space c s` | list symbols in this file |
| `]d` / `[d` | next / previous **diagnostic** (lint problem) |
| `Space c d` | show the full diagnostic message under the cursor |
| `Space c l` | list **all** diagnostics in the project |

**Autocomplete** (nvim-cmp) pops up as you type. `Ctrl-Space` forces it open · `Ctrl-n`/`Ctrl-p` move · `Enter` accepts the highlighted item · `Tab`/`Shift-Tab` move through the menu and snippet fields · `Ctrl-e` dismisses · `Ctrl-d`/`Ctrl-u` scroll the doc popup.

**Telling clangd where your `compile_commands.json` is.** Each repo carries a
merged `compile_commands.json` **at its root**; clangd finds it by searching a
file's parent directories — no env var, no global flag, and it works across
every repo at once. Generate/refresh the merged DB with that repo's
`scripts/gen_compile_commands.sh` (it collects the per-subproject databases the
build emits and merges them to the root). clangd auto-reloads the file whenever
you re-run the script — no need to restart nvim.

Per-project flag tweaks (no rebuild) go in a **`.clangd`** file at the repo root:
```yaml
CompileFlags:
  Add: [-std=c17, -D SOME_MACRO]   # applied to every file, live
```
Editing `.clangd` takes effect immediately — clangd re-reads it with no rebuild.

### General (same as vim)
`:w` save · `:q` quit window · `:qa` quit nvim · `:wqa` save all & quit · `Esc` clears search highlight.

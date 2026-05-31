# Neovim Beginner's Guide (for a vim user)

You've used vim but never nvim. Good news: **you already know ~90% of this.** Neovim *is* vim — every motion, every mode, `:w`, `:q`, `dd`, `ciw`, `/search`, visual mode, macros — all identical. This guide only covers the *new* things this particular setup adds on top.

---

## 1. The one habit to build: the leader key

The **leader** is the `Space` bar. Almost every feature here starts with it.

Press `Space` and **pause for half a second**. A menu (which-key) pops up showing every shortcut available, grouped by category (`f` = find, `g` = git, `s` = split, …). Keep pressing letters to drill in, e.g. `Space` → `f` → `f` runs "find files".

**You don't need to memorize anything.** When you forget a key, press `Space` and read the menu. This is your safety net.

---

## 2. What's different from your vim

| In vim you did… | Here you do… |
|---|---|
| `:e path/to/file` | `Space f f`, then fuzzy-type the name |
| `:grep foo` / `:vimgrep` | `Space f g`, then type `foo` (live results + preview) |
| `:vsplit` / `:split` | still work, or `Space s v` / `Space s h` |
| `:Explore` / netrw | `Space e` (a real file tree on the right) |
| `:!git diff dev` in a shell | `Space g d` (visual side-by-side diff vs dev) |
| edited `~/.vimrc` (vimscript) | config is Lua in `~/.config/nvim/` — but you don't need to touch it to *use* nvim |

Everything else — your editing muscle memory — is unchanged.

---

## 3. A normal session, start to finish

**Open the IDE.** In a terminal: `ide`. You get three areas (this is *tmux*, the outer frame, not nvim):
- left = a terminal running Claude Code (toggle with `Ctrl-b` then `b`)
- bottom = a terminal (toggle with `Ctrl-b` then `t`)
- center = **nvim** — this is where you live

**Open a file.** Press `Space f f`. A search box appears with a preview on the right. Type part of a filename; the list narrows as you type. Move with `Ctrl-n`/`Ctrl-p` (or arrow keys), watch the preview update, press `Enter` to open it. (`Esc` `Esc` backs out without opening.)

**Find some code.** Press `Space f g` ("grep"). Type any text — say a function name. It searches *every file* live; each match shows in a preview so you can **peek** before committing. `Enter` jumps straight to that line in that file. Want it in a split instead? `Ctrl-v` (vertical) or `Ctrl-x` (horizontal) instead of `Enter`.

**Browse the tree.** Press `Space e` to toggle the file tree on the right. Move with `j`/`k`, open with `Enter`, create a file with `a`, delete with `d`, rename with `r`. Press `?` inside the tree to see all its keys. `Space e` again hides it.

**Work in splits.** `Space s v` makes a vertical split, `Space s h` a horizontal one. Move between them with `Ctrl-h/j/k/l` (left/down/up/right). To *rearrange* them, `Space w h/j/k/l` shoves the current split to that edge. Close one with `Space s x`.

**Switch between open files.** Every file you open becomes a "tab" in the strip across the top. `Shift-l` = next, `Shift-h` = previous. `Space b d` closes the current one.

**Check git / compare to dev.** `Space g d` opens a side-by-side diff of your branch against the team's base branch (it auto-finds `dev`, then `develop`, `main`, or `master`). A list of changed files appears; `Tab`/`Shift-Tab` cycle through them, the diff shows on the right. `Space g c` closes it. While editing, changed lines are marked in the gutter — `]c`/`[c` jump between them, `Space g p` previews one.

**Do git operations.** For staging, committing, switching branches, etc., press `Ctrl-b` then `g` — a **lazygit** window pops up over your screen. It's a friendly full git UI; press `?` inside it for help, `q` to close.

**Save & quit.** Exactly like vim: `:w` saves, `:q` closes a split, `:wqa` saves everything and quits nvim, then `Ctrl-b d` detaches the IDE (or just close the terminal).

---

## 4. Tabs & "editor groups" — the important mental model

VSCode has editor groups, each with its own tab bar. nvim can't do tabs *per split* (open files are global to nvim — there's no native way to give each side-by-side split its own tab strip). Instead, the unit of grouping is the **tab page**, and `scope.nvim` makes each tab page keep its own file list. Think of a **tab page = an editor group**:

- The strip at the top shows **only the files in your current group**, not everything you've ever opened.
- `Shift-l` / `Shift-h` cycle through the files **in this group**.
- `Space t n` makes a **new group** (a fresh tab page with an empty file list). Open files there and they belong to that group.
- `Space ]` / `Space [` switch between groups. `Space t c` closes a group.
- Inside any group you can still split (`Space s v` / `Space s h`) for side-by-side editing.

So instead of "two splits each with their own tabs," you have "two groups you flip between, each with its own tabs, and you split inside whichever group you're working in." That's the nvim-native equivalent — and the closest thing that actually exists.

---

## 5. Code intelligence (jump-to-definition, autocomplete, linting)

This is the big "it's a real IDE now" part. A **language server** (clangd, for C/C++) reads your code and understands it — so you get the things you'd expect from VSCode/Cursor. It attaches automatically when you open a C file.

**Jump to a definition.** Put your cursor on a function/variable and press `g d`. If there's one definition, you land on it. If there are several, a Telescope picker opens with a preview so you can peek first. Want the definition in a *split* so you keep your current file visible? Two ways: inside the picker press `Ctrl-v` (vertical) or `Ctrl-x` (horizontal); or skip the picker entirely with `Space c v` / `Space c h`. Jump *back* where you came from with `Ctrl-o` (same as vim's jumplist).

**See what something is.** Press `K` (capital) on a symbol — a popup shows its type, signature, and docs. Press `K` again (or move) to dismiss.

**Other jumps:** `g D` declaration · `g i` implementation · `g r` all references · `g y` type definition. (Heads-up: these override a couple of rarely-used vim defaults like `gr`; that's normal for an IDE setup.)

**Autocomplete.** Just type — a menu of suggestions appears (from clangd, snippets, open buffers, paths). `Ctrl-n`/`Ctrl-p` move through it, `Enter` accepts the highlighted one, `Tab` also moves down. `Ctrl-Space` forces the menu open if it didn't appear. `Ctrl-e` dismisses it. Nothing is inserted until you pick something, so you can ignore it and keep typing.

**Linting — it's automatic.** clangd runs **clang-tidy** in the background and underlines problems with a colored squiggle plus a sign in the gutter. You don't run anything. Jump between problems with `]d` (next) / `[d` (previous). The short message shows inline; press `Space c d` to read the full message, or `Space c l` to list every problem in the project in a Telescope picker.

**Fix / refactor.** `Space c a` offers code actions (auto-add a missing include, apply a clang-tidy fix, etc.). `Space c r` renames a symbol everywhere it's used. `Space c f` formats the file.

**Pointing clangd at your build.** clangd needs a `compile_commands.json` to know each file's compiler flags. You already merge all of them into one with `~/scripts/merge_compile_commands.sh`. Tell nvim where that merged file lives with an env var in your shell rc:
```sh
export CLANGD_CDB_DIR=/home/ldap/yjkim/tmp
```
That's the same path as your old Cursor `--compile-commands-dir`. **The rebuild annoyance you mentioned has a real fix:** instead of (or in addition to) the env var, put a `.clangd` file at your project root and add flags there under `CompileFlags.Add:` — those apply to every file *instantly*, with no rebuild and no re-merge. See `CHEATSHEET.md` → "Code intelligence" for the exact snippet. And when you *do* re-run the merge script, clangd notices the new `compile_commands.json` on its own — no need to restart nvim.

---

## 6. Will this work on a new machine?

Yes, automatically. Your whole nvim config lives in `~/.config/nvim/` and is in your dotfiles. On a new machine:

1. `dotfiles pull` (brings the config down)
2. run `nvim` once — it **bootstraps itself**: it auto-clones the plugin manager (lazy.nvim) and then installs every plugin, builds the fuzzy-finder, and downloads syntax parsers. Wait ~30 seconds, quit, reopen, done.

You do **not** install a plugin manager separately — the config does it for you. The only non-config things the new machine needs are: `git`, a C compiler (`gcc`/`cc`), `ripgrep` (`rg`), and `lazygit`. If `lazygit` is missing there, the `Ctrl-b g` popup won't open — reinstall it (it's a single binary; download from its GitHub releases into `~/.local/bin/`). `lazy-lock.json` in the config pins exact plugin versions so a new machine matches this one.

---

## 7. Troubleshooting

- **No autocomplete / no jump-to-definition / no squiggles.** The language server may not have started. Run `:LspInfo` (or `:checkhealth vim.lsp`) to see if `clangd` is attached. If it's not, check `clangd` is installed (`:!which clangd`). If it attached but can't resolve `#include`s or symbols, it can't find your `compile_commands.json` — set `CLANGD_CDB_DIR` or add a `.clangd` file (see section 5).
- **Icons look like boxes (□).** Your terminal font isn't a Nerd Font. Install one (e.g. "JetBrainsMono Nerd Font") and select it in your terminal emulator's settings. Everything still *works* without it.
- **`Space` does nothing / no menu.** Make sure you're in **normal mode** (press `Esc` first). The menu only appears in normal mode.
- **Copy/paste to other apps doesn't work.** nvim uses the system clipboard via `xclip`/`xsel` (both installed here). On a new machine you may need to install one of them.
- **A plugin seems broken after an update.** Run `:Lazy` to open the plugin manager UI — press `S` to sync, `r` to restore pinned versions from the lockfile.
- **"How do I see all keybindings?"** `Space` (and wait), or `:Telescope keymaps` to fuzzy-search every mapping.
- **I'm stuck in some popup.** `Esc` or `q` gets you out of almost everything. `:qa!` force-quits nvim entirely.

---

## 8. Learn vim/nvim deeper

- Run `:Tutor` inside nvim for the built-in 30-minute interactive tutorial.
- `:help <topic>` for anything (e.g. `:help windows`, `:help :split`).
- You don't need to learn Lua to *use* this — only if you later want to tweak the config in `~/.config/nvim/lua/`.

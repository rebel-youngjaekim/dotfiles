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

## 4. "Tabs" — a heads-up

This trips up people coming from VSCode. In nvim there are **two** different things both called "tabs":

1. **Buffer tabs** (the strip at the top) = your open files. This is what feels like VSCode tabs. Switch with `Shift-h`/`Shift-l`. There's one shared strip, not one-per-split — that's just how vim works (open files are global).
2. **Tab pages** (`Space t n`) = a whole separate *layout* of splits, like a second virtual desktop inside nvim. You probably won't need these often; ignore them until you do.

Day to day, just think "buffer tabs = my open files" and use `Shift-h`/`Shift-l`.

---

## 5. Will this work on a new machine?

Yes, automatically. Your whole nvim config lives in `~/.config/nvim/` and is in your dotfiles. On a new machine:

1. `dotfiles pull` (brings the config down)
2. run `nvim` once — it **bootstraps itself**: it auto-clones the plugin manager (lazy.nvim) and then installs every plugin, builds the fuzzy-finder, and downloads syntax parsers. Wait ~30 seconds, quit, reopen, done.

You do **not** install a plugin manager separately — the config does it for you. The only non-config things the new machine needs are: `git`, a C compiler (`gcc`/`cc`), `ripgrep` (`rg`), and `lazygit`. If `lazygit` is missing there, the `Ctrl-b g` popup won't open — reinstall it (it's a single binary; download from its GitHub releases into `~/.local/bin/`). `lazy-lock.json` in the config pins exact plugin versions so a new machine matches this one.

---

## 6. Troubleshooting

- **Icons look like boxes (□).** Your terminal font isn't a Nerd Font. Install one (e.g. "JetBrainsMono Nerd Font") and select it in your terminal emulator's settings. Everything still *works* without it.
- **`Space` does nothing / no menu.** Make sure you're in **normal mode** (press `Esc` first). The menu only appears in normal mode.
- **Copy/paste to other apps doesn't work.** nvim uses the system clipboard via `xclip`/`xsel` (both installed here). On a new machine you may need to install one of them.
- **A plugin seems broken after an update.** Run `:Lazy` to open the plugin manager UI — press `S` to sync, `r` to restore pinned versions from the lockfile.
- **"How do I see all keybindings?"** `Space` (and wait), or `:Telescope keymaps` to fuzzy-search every mapping.
- **I'm stuck in some popup.** `Esc` or `q` gets you out of almost everything. `:qa!` force-quits nvim entirely.

---

## 7. Learn vim/nvim deeper

- Run `:Tutor` inside nvim for the built-in 30-minute interactive tutorial.
- `:help <topic>` for anything (e.g. `:help windows`, `:help :split`).
- You don't need to learn Lua to *use* this — only if you later want to tweak the config in `~/.config/nvim/lua/`.

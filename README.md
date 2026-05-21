# dotfiles

My personal dotfiles, tracked using the [bare-repo pattern](https://www.atlassian.com/git/tutorials/dotfiles). The repo's work-tree is `$HOME`, so tracked files live at their natural paths (`~/.bashrc`, `~/.vimrc`, `~/.tmux.conf`) and the git metadata lives in `~/.dotfiles/` — no symlinks, no extra tooling.

## What's tracked

- `.bashrc`
- `.tmux.conf`
- `.vimrc`
- `.dotfiles-install.sh` — bootstrap script (see below)
- `README.md` — this file

## Install on a new machine

One-liner:

```sh
curl -fsSL https://raw.githubusercontent.com/rebel-youngjaekim/dotfiles/main/.dotfiles-install.sh | bash
```

The script will:

1. Clone the bare repo to `~/.dotfiles`.
2. Check out the tracked files into `$HOME`. Any pre-existing files that would be overwritten get moved to `~/.dotfiles-backup/` first.
3. Set `status.showUntrackedFiles no` so `dotfiles status` only reports tracked files.

After it finishes, add this alias to your shell rc (it's already in the tracked `.bashrc`):

```sh
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

## Day-to-day usage

```sh
dotfiles status                  # see modified tracked files
dotfiles add .vimrc              # stage a change
dotfiles commit -m "tweak vim"   # commit
dotfiles push                    # push to GitHub
dotfiles pull                    # pull updates from another machine
```

## Adding a new file to track

```sh
dotfiles add .config/some-tool/config
dotfiles commit -m "track some-tool config"
dotfiles push
```

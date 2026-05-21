#!/usr/bin/env bash
# Bootstrap script for the bare-repo dotfiles setup.
#
# Usage on a fresh machine:
#   curl -fsSL https://raw.githubusercontent.com/rebel-youngjaekim/dotfiles/main/.dotfiles-install.sh | bash
#
# Or, if already cloned:
#   bash ~/.dotfiles-install.sh

set -euo pipefail

REPO_URL="https://github.com/rebel-youngjaekim/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

dotfiles() {
    git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

if [ ! -d "$DOTFILES_DIR" ]; then
    if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
        echo "Cloning via gh (handles private repos) ..."
        gh repo clone rebel-youngjaekim/dotfiles "$DOTFILES_DIR" -- --bare
    else
        echo "Cloning $REPO_URL into $DOTFILES_DIR ..."
        git clone --bare "$REPO_URL" "$DOTFILES_DIR"
    fi
else
    echo "$DOTFILES_DIR already exists — fetching latest."
    dotfiles fetch origin
fi

mkdir -p "$BACKUP_DIR"

echo "Checking out dotfiles into \$HOME ..."
if ! dotfiles checkout 2>/dev/null; then
    echo "Conflicting files exist — backing them up to $BACKUP_DIR/"
    dotfiles checkout 2>&1 \
        | grep -E "^\s+\." \
        | awk '{print $1}' \
        | while read -r f; do
            mkdir -p "$BACKUP_DIR/$(dirname "$f")"
            mv "$HOME/$f" "$BACKUP_DIR/$f"
        done
    dotfiles checkout
fi

dotfiles config status.showUntrackedFiles no

echo
echo "Done. Add this alias to your shell rc if you want the 'dotfiles' command:"
echo "  alias dotfiles='git --git-dir=\$HOME/.dotfiles --work-tree=\$HOME'"

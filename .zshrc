# catppuccin-ish colors for zsh

# ── LS_COLORS (fixes the dark blue directory problem) ──
# di=lavender, ln=sky, ex=green, archives=mauve, images=peach
export LS_COLORS='di=38;5;147:ln=38;5;117:ex=38;5;151:*.tar=38;5;183:*.zip=38;5;183:*.gz=38;5;183:*.png=38;5;216:*.jpg=38;5;216:*.jpeg=38;5;216:*.md=38;5;223'
export CLICOLOR=1

# macOS BSD ls uses LSCOLORS instead of LS_COLORS
# order: dir, symlink, socket, pipe, exec, block, char, suid, sgid, sticky+writable, sticky, writable
export LSCOLORS='ExGxFxDxCxDxDxhbhdacEc'

# ── prompt: user  host  ~/path  (branch)  ❯ ──
setopt PROMPT_SUBST
parse_git_branch() {
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    [ -n "$branch" ] && echo "($branch)"
}
PROMPT='%F{147}%n%f  %F{117}%m%f  %F{151}%~%f  %F{223}$(parse_git_branch)%f  %F{218}❯%f '

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export TERM=xterm-256color

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export PATH="$HOME/.local/bin:$PATH"

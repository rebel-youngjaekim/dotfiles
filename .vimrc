" ── vim config · catppuccin-ish ──

syntax on
set mouse=a
let mapleader = " "
set fileformat=unix
set encoding=UTF-8

" indent
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent smartindent smarttab expandtab
set nowrap

" ui
set number
set scrolloff=8
set cursorline
set cuc
set showcmd
set noshowmode
set conceallevel=1
set splitright
set termguicolors

" cursorline only in the focused window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" no bells, no temp files
set noerrorbells visualbell t_vb=
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" clipboard + search
set clipboard=unnamed
set ignorecase smartcase incsearch hlsearch

" mappings
nnoremap <CR> :noh<CR><CR>:<backspace>
nnoremap <C-`> :botright vertical 50terminal<CR>

" ── colors: catppuccin mocha-ish ──
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif

" transparent bg — inherits terminal
hi Normal        guibg=NONE ctermbg=NONE guifg=#cdd6f4

" ui
hi LineNr        guifg=#6c7086 guibg=NONE
hi CursorLineNr  guifg=#f5c2e7 guibg=NONE
hi CursorLine    guibg=#313244
hi CursorColumn  guibg=#313244
hi VertSplit     guifg=#45475a guibg=NONE
hi StatusLine    guifg=#cdd6f4 guibg=#313244
hi StatusLineNC  guifg=#6c7086 guibg=#1e1e2e
hi Visual        guibg=#45475a
hi Search        guifg=#1e1e2e guibg=#f9e2af
hi IncSearch     guifg=#1e1e2e guibg=#fab387
hi MatchParen    guifg=#f5c2e7 gui=bold
hi Pmenu         guifg=#cdd6f4 guibg=#313244
hi PmenuSel      guifg=#1e1e2e guibg=#b4befe
hi SignColumn    guibg=NONE
hi NonText       guifg=#45475a
hi EndOfBuffer   guifg=#1e1e2e

" syntax
hi Comment       guifg=#6c7086 gui=italic
hi Constant      guifg=#fab387
hi String        guifg=#a6e3a1
hi Number        guifg=#fab387
hi Identifier    guifg=#cdd6f4
hi Function      guifg=#89b4fa
hi Statement     guifg=#cba6f7
hi Keyword       guifg=#cba6f7
hi Operator      guifg=#94e2d5
hi PreProc       guifg=#f5c2e7
hi Type          guifg=#f9e2af
hi Special       guifg=#f5c2e7
hi Todo          guifg=#1e1e2e guibg=#f9e2af gui=bold
hi Error         guifg=#f38ba8
hi Title         guifg=#b4befe gui=bold

" :terminal colors (used by <C-`> terminal split)
let g:terminal_ansi_colors = [
    \ '#45475a', '#f38ba8', '#a6e3a1', '#f9e2af', '#89b4fa', '#f5c2e7', '#94e2d5', '#bac2de',
    \ '#585b70', '#f38ba8', '#a6e3a1', '#f9e2af', '#89b4fa', '#f5c2e7', '#94e2d5', '#a6adc8',
\]

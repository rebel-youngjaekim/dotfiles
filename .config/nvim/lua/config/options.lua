-- ── options · ported from ~/.vimrc ──
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ui
opt.number = true
opt.scrolloff = 8
opt.cursorline = true
opt.showcmd = true
opt.showmode = false        -- lualine shows the mode
opt.conceallevel = 1
opt.termguicolors = true
opt.mouse = "a"
opt.signcolumn = "yes"      -- stable gutter for gitsigns

-- splits open down/right (you had splitright)
opt.splitright = true
opt.splitbelow = true

-- indent
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.wrap = false

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- clipboard (unnamedplus = system clipboard on linux)
opt.clipboard = "unnamedplus"

-- no swap/backup, persistent undo
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- no bells
opt.errorbells = false

-- cursorline only in the focused window (matches your BgHighlight augroup)
local grp = vim.api.nvim_create_augroup("BgHighlight", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", { group = grp, command = "setlocal cursorline" })
vim.api.nvim_create_autocmd("WinLeave", { group = grp, command = "setlocal nocursorline" })

-- ── general keymaps ── (leader = space)
-- Plugin-specific maps live in each plugin spec under lua/plugins/.
local map = vim.keymap.set

-- clear search highlight
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- ── splits ──
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<CR>",  { desc = "Split horizontal" })
map("n", "<leader>sx", "<cmd>close<CR>",  { desc = "Close split" })
map("n", "<leader>so", "<cmd>only<CR>",   { desc = "Close other splits" })
map("n", "<leader>se", "<C-w>=",          { desc = "Equalize splits" })

-- move focus between splits
map("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })

-- move the split itself around (H/J/K/L = relocate window)
map("n", "<leader>wh", "<C-w>H", { desc = "Move split far left" })
map("n", "<leader>wj", "<C-w>J", { desc = "Move split to bottom" })
map("n", "<leader>wk", "<C-w>K", { desc = "Move split to top" })
map("n", "<leader>wl", "<C-w>L", { desc = "Move split far right" })

-- resize splits
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Grow split height" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Shrink split height" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Shrink split width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Grow split width" })

-- ── tab pages (whole-screen layouts; distinct from bufferline tabs) ──
map("n", "<leader>tn", "<cmd>tabnew<CR>",   { desc = "New tab page" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab page" })
map("n", "<leader>]",  "<cmd>tabnext<CR>",  { desc = "Next tab page" })
map("n", "<leader>[",  "<cmd>tabprev<CR>",  { desc = "Prev tab page" })

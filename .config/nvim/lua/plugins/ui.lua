-- ── statusline (current branch) + bufferline (tabs across the top) ──
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
          section_separators = "",
          component_separators = "|",
        },
        sections = {
          lualine_b = { "branch", "diff", "diagnostics" }, -- current git branch lives here
        },
      })
    end,
  },
  {
    -- a single tab strip of all open files (vim buffers are global, not per-split)
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<S-l>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
      { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer tab" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>",      desc = "Pick buffer tab" },
      { "<leader>bd", "<cmd>bdelete<cr>",             desc = "Close buffer tab" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          offsets = {
            { filetype = "neo-tree", text = "Explorer", separator = true },
          },
        },
      })
    end,
  },
}

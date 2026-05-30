-- ── neo-tree · file tree on the RIGHT ──
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle right<cr>", desc = "Toggle file tree" },
    { "<leader>o", "<cmd>Neotree focus right<cr>",  desc = "Focus file tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = { position = "right", width = 35 },
      filesystem = {
        follow_current_file = { enabled = true }, -- reveal the file you're editing
        use_libuv_file_watcher = true,            -- live-update on disk changes
        filtered_items = { hide_dotfiles = false, hide_gitignored = false },
      },
    })
  end,
}

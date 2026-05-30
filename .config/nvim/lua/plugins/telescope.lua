-- ── telescope · fuzzy find files + grep-in-files (peek or open) ──
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Grep in files" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
    {
      -- visual mode: grep whatever text you've selected (a phrase, etc.)
      "<leader>fw",
      function()
        vim.cmd('noautocmd normal! "vy')
        require("telescope.builtin").grep_string({ search = vim.fn.getreg("v") })
      end,
      mode = "x",
      desc = "Grep selection",
    },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Open buffers" },
    { "<leader>fr", "<cmd>Telescope resume<cr>",      desc = "Resume last search" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        -- the preview pane on the right IS the "peek"; <CR> opens the file.
        layout_strategy = "horizontal",
        layout_config = { preview_width = 0.55 },
        path_display = { "truncate" },
      },
    })
    pcall(telescope.load_extension, "fzf")
  end,
}

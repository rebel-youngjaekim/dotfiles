-- ── git · inline hunks (gitsigns) + branch-vs-dev comparison (diffview) ──
return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          local function map(m, l, r, d)
            vim.keymap.set(m, l, r, { buffer = bufnr, desc = d })
          end
          map("n", "]c", function() gs.nav_hunk("next") end, "Next git hunk")
          map("n", "[c", function() gs.nav_hunk("prev") end, "Prev git hunk")
          map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gd", function() require("config.git").compare_dev() end, desc = "Diff: branch vs dev" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>",          desc = "Close diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",  desc = "File history (this file)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",    desc = "File history (repo)" },
    },
    config = function()
      require("diffview").setup({})
    end,
  },
}

-- ── which-key · press <leader> (Space) and pause to see every shortcut ──
-- The single most useful thing for discovering this setup. Group labels below
-- describe what each leader prefix is for.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({})
    wk.add({
      { "<leader>c", group = "code / LSP" },
      { "<leader>f", group = "find / search" },
      { "<leader>g", group = "git" },
      { "<leader>s", group = "split" },
      { "<leader>w", group = "move window" },
      { "<leader>b", group = "buffer (tab)" },
      { "<leader>t", group = "tab page" },
    })
  end,
}

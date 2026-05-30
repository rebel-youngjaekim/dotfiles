-- ── catppuccin mocha · transparent (matches your ~/.vimrc look) ──
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true, -- inherit the terminal bg, like your old config
      integrations = {
        neotree = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        native_lsp = { enabled = true },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

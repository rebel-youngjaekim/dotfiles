-- ── treesitter · syntax highlighting backbone ──
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- stable configs.setup API
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "lua", "python", "bash",
        "vim", "vimdoc", "markdown", "json", "yaml", "make",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

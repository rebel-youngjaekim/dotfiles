-- ── autocomplete · nvim-cmp ──
-- The popup menu that suggests completions as you type. Sources, in priority
-- order: the LSP (clangd) → snippets → words in open buffers → file paths.
-- Pure-Lua and battle-tested, so it just works on a fresh machine.
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- load the first time you enter insert mode
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP completions (clangd)
    "hrsh7th/cmp-buffer", -- words from open buffers
    "hrsh7th/cmp-path", -- filesystem paths
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    {
      "L3MON4D3/LuaSnip", -- snippet engine
      build = "make install_jsregexp", -- optional regex transforms; harmless if it fails
      dependencies = { "rafamadriz/friendly-snippets" }, -- ready-made snippets
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- force the menu open
        ["<C-e>"] = cmp.mapping.abort(), -- dismiss it
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- accept (only if one is selected)
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- scroll the doc popup
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        -- Tab / Shift-Tab: move through the menu, or jump between snippet fields
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}

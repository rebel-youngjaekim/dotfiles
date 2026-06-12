-- ── LSP · clangd for C/C++ ──
-- Gives you: jump-to-definition, hover docs, autocomplete (via nvim-cmp), and
-- LINTING — clangd runs clang-tidy and surfaces issues as native diagnostics,
-- so there's no separate linter plugin to manage.
--
-- nvim 0.11+ ships a native LSP API (vim.lsp.config / vim.lsp.enable); we let
-- nvim-lspconfig provide clangd's defaults (root detection, filetypes) and
-- layer our own cmd + completion capabilities on top.
return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- ── diagnostics (this is your "linting" — fed by clangd --clang-tidy) ──
    vim.diagnostic.config({
      virtual_text = { spacing = 2, prefix = "●" },
      signs = true,
      underline = true,
      update_in_insert = false, -- don't churn while you type
      severity_sort = true,
      float = { border = "rounded", source = true },
    })

    -- ── completion capabilities advertised to the server (from nvim-cmp) ──
    local caps = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      caps = cmp_lsp.default_capabilities(caps)
    end

    -- ── clangd command (your Cursor clangd.arguments, ported) ──
    -- No --compile-commands-dir on purpose: that flag is GLOBAL (one dir for
    -- every project), so it can't serve multiple repos. Instead each repo
    -- carries a merged compile_commands.json at its root, and clangd's default
    -- per-file parent-directory search picks the right one automatically.
    -- Generate the merged DB with the repo's scripts/gen_compile_commands.sh.
    local cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
    }

    vim.lsp.config("clangd", { cmd = cmd, capabilities = caps })
    vim.lsp.enable("clangd")

    -- ── buffer-local keymaps, set only once a server attaches ──
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("ide_lsp_attach", { clear = true }),
      callback = function(ev)
        local tb = require("telescope.builtin")
        local function m(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = "LSP: " .. desc })
        end

        -- navigation (Telescope pickers = preview/peek; Ctrl-v / Ctrl-x in the
        -- picker open the result in a vertical / horizontal split)
        m("gd", tb.lsp_definitions, "Definition (peek; C-v/C-x = split)")
        m("gD", vim.lsp.buf.declaration, "Declaration")
        m("gi", tb.lsp_implementations, "Implementation")
        m("gy", tb.lsp_type_definitions, "Type definition")
        m("gr", tb.lsp_references, "References")
        m("K", vim.lsp.buf.hover, "Hover docs")

        -- definition straight into a fresh split (no picker)
        m("<leader>cv", function()
          vim.cmd("vsplit")
          vim.lsp.buf.definition()
        end, "Definition → vertical split")
        m("<leader>ch", function()
          vim.cmd("split")
          vim.lsp.buf.definition()
        end, "Definition → horizontal split")

        -- code actions
        m("<leader>ca", vim.lsp.buf.code_action, "Code action")
        m("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
        m("<leader>cf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format buffer")
        m("<leader>cs", tb.lsp_document_symbols, "Document symbols")

        -- inlay hints (clangd shows parameter names + deduced types inline).
        -- Off by default; toggle per-buffer on demand so they don't clutter.
        m("<leader>ci", function()
          local on = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
          vim.lsp.inlay_hint.enable(not on, { bufnr = ev.buf })
        end, "Toggle inlay hints")

        -- diagnostics ("linting" results)
        m("<leader>cd", vim.diagnostic.open_float, "Line diagnostics (full message)")
        m("<leader>cl", tb.diagnostics, "List all diagnostics")
        m("]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")
        m("[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, "Prev diagnostic")
      end,
    })

    -- nvim 0.11 sets a few unfamiliar default LSP maps (grn/gra/grr/gri); drop
    -- them so our classic single-key scheme (gr = references, etc.) is instant.
    for _, k in ipairs({ "grn", "grr", "gri" }) do
      pcall(vim.keymap.del, "n", k)
    end
    pcall(vim.keymap.del, "n", "gra")
    pcall(vim.keymap.del, "x", "gra")
  end,
}

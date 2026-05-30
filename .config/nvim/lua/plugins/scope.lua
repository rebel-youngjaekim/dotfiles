-- ── scope.nvim · scope buffers to tab pages ──
-- Makes each tab page act like a VSCode "editor group": the bufferline at the
-- top only shows files belonging to the current tab page, and cycling
-- (Shift-h / Shift-l) stays within that group.
return {
  "tiagovla/scope.nvim",
  lazy = false,
  config = function()
    require("scope").setup({})
  end,
}

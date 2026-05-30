-- ── git helpers ──
local M = {}

-- Open a diffview of your current branch vs the project's base branch.
-- Tries common base-branch names and uses the first that exists.
-- `ref...HEAD` (three dots) = what changed on your branch since it forked off the base.
function M.compare_dev()
  local candidates = {
    "origin/dev", "dev",
    "origin/develop", "develop",
    "origin/main", "main",
    "origin/master", "master",
  }
  for _, ref in ipairs(candidates) do
    vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", ref })
    if vim.v.shell_error == 0 then
      vim.cmd("DiffviewOpen " .. ref .. "...HEAD")
      vim.notify("Diffview: comparing " .. ref .. "...HEAD", vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No dev/main/master base branch found to compare against", vim.log.levels.WARN)
end

return M

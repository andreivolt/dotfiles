local M = {}

M.setup = function()
  vim.g.gitblame_highlight_group = "Question"
  vim.g.gitblame_enabled = 0
end

return M

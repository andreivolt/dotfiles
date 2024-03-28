local M = {}

M.setup = function()
  require('nvim-lightbulb').setup({
    autocmd = {
      enabled = true
    }
  })
end

return M

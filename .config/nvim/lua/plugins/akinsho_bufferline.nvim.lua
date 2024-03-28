local M = {}

M.setup = function()
  require('bufferline').setup {
    options = {
      always_show_bufferline = false,
      enforce_regular_tabs = true
    }
  }
end

return M

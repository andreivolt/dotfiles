local M = {}

M.setup = function()
  require("ibl").setup {
    exclude = {
      filetypes = { 'help', 'packer' },
      buftypes = { 'terminal', 'nofile' }
    },
    indent = {
      char = "▎"
    }
  }
end

return M

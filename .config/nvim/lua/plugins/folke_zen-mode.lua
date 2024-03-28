local M = {}

M.setup = function()
  require('zen-mode').setup {
    window = {
      width = 100,
    },
    options = {
      signcolumn = 'no',
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = '0',
      list = false,
    },
    plugins = {
      tmux = {
        enabled = true,
      },
      gitsigns = {
        enabled = false,
      },
      kitty = {
        enabled = true,
        font = '+2',
      },
      options = {
        enabled = true,
        showcmd = false,
        laststatus = 0,
      }
    }
  }
end

return M

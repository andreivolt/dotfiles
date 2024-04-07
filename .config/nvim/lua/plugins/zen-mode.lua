return {
  "folke/zen-mode.nvim",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>" },
  },
  opts = {
    window = {
      width = 65,
      height = 0.95,
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
        font = '+5',
      },
      options = {
        enabled = true,
        showcmd = false,
        laststatus = 0,
      }
    },
    on_open = function()
      vim.cmd('ScrollbarHide')
    end,
    on_close = function()
      vim.cmd('ScrollbarShow')
    end
  },
  cmd = "ZenMode",
}

return {
  "folke/zen-mode.nvim",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>" },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, 'ZenBg', { bg = 'NONE' })
    require("zen-mode").setup(opts)
  end,
  opts = {
    window = {
      width = 75,
      height = 0.8,
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
      options = {
        enabled = true,
        showcmd = false,
        laststatus = 0,
      }
    },
    on_open = function()
      vim.cmd('ScrollbarHide')
      vim.cmd('set statuscolumn=""') -- TODO
      vim.cmd('IBLDisable')
      vim.opt_local.list = false
      vim.cmd('DisableWhitespace')
    end,
    on_close = function()
      vim.cmd('ScrollbarShow')
      vim.cmd('IBLEnable')
      vim.cmd('EnableWhitespace')
    end
  },
  cmd = "ZenMode",
}

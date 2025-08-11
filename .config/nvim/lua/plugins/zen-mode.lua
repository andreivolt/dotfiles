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
      width = 80,
      height = 0.85,
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
    end,
    on_close = function()
      vim.cmd('ScrollbarShow')
    end
  },
  cmd = "ZenMode",
}

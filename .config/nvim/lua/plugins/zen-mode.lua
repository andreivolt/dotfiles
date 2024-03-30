return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = { "<leader>z" },
  opts = {
    window = {
      width = 90,
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
        font = '+3',
      },
      options = {
        enabled = true,
        showcmd = false,
        laststatus = 0,
      }
    }
  },
  init = function()
    vim.keymap.set("n", "<leader>z", require("zen-mode").toggle)
  end,
}

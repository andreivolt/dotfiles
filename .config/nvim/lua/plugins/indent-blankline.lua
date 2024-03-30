return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  opts = {
    exclude = {
      filetypes = {
        'help',
      },
      buftypes = {
        'terminal',
        'nofile',
      }
    },
    indent = {
      char = "┊"
    }
  },
}

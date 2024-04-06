return {
  "lewis6991/gitsigns.nvim",
  config = true,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
  event = "VeryLazy",
}

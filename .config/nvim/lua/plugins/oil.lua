return {
  'stevearc/oil.nvim',
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  lazy = false,
}

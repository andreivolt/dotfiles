return {
  'petertriho/nvim-scrollbar',
  opts = {
    handlers = {
      cursor = false,
    },
  },
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  event = "VeryLazy",
}

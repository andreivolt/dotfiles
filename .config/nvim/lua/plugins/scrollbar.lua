return {
  'petertriho/nvim-scrollbar',
  config = true,
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  event = "VeryLazy",
}

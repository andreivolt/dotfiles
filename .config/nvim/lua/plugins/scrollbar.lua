return {
  'petertriho/nvim-scrollbar',
  lazy = true,
  event = "BufReadPost",
  config = true,
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  }
}

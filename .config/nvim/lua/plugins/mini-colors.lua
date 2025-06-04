return {
  'echasnovski/mini.nvim',
  event = "VeryLazy",
  config = function()
    require('mini.colors').setup()
  end
}

return {
  "f-person/auto-dark-mode.nvim",
  event = "VeryLazy",
  opts = {
    set_dark_mode = function()
      vim.cmd("colorscheme aurora")
    end,
    set_light_mode = function()
      vim.cmd("colorscheme aurora")
    end,
  },
}
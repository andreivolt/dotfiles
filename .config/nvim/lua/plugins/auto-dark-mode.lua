return {
  "f-person/auto-dark-mode.nvim",
  enabled = vim.fn.executable("dbus-send") == 1,
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
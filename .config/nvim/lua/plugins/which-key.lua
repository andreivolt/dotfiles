return {
  "folke/which-key.nvim",
  keys = "<leader>",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    require("which-key").setup()
  end,
  lazy = true,
}

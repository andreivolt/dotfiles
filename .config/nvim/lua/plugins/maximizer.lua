return {
  "szw/vim-maximizer",
  keys = {
    {"<c-w>m", "<cmd>MaximizerToggle<cr>", {mode = "n"}}
  },
  cmd = "MaximizerToggle",
  config = function()
    vim.g.maximizer_set_default_mapping = false
  end,
  lazy = true,
}

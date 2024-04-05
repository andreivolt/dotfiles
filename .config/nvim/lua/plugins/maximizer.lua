return {
  "szw/vim-maximizer",
  keys = {
    {"<c-w>m", "<cmd>MaximizerToggle<cr>", {mode = "n"}}
  },
  config = function()
    vim.g.maximizer_set_default_mapping = false
  end,
  cmd = "MaximizerToggle",
}

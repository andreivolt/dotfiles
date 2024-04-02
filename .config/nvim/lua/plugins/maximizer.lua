return {
  "szw/vim-maximizer",
  keys = {
    {"n", "<c-w>m", "<cmd>MaximizerToggle<cr>"}
  },
  cmd = {"MaximizerToggle"},
  config = function()
    vim.g.maximizer_set_default_mapping = false
  end,
  lazy = true,
}

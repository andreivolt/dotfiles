return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
  end,
  event = {
    'BufReadPre',
    'BufNewFile',
  },
}

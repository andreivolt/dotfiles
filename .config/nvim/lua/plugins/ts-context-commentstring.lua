return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
  end,
}

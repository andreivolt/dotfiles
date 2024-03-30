vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '.envrc',
  callback = function()
    if vim.fn.executable 'direnv' then vim.cmd('!direnv allow') end
  end,
})

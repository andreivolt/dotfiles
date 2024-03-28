vim.api.nvim_create_augroup('SetSpell', {})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {'*.txt', '*.md'},
  command = 'setlocal spell',
  group = 'SetSpell',
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit' },
  command = 'setlocal spell',
  group = 'SetSpell',
})

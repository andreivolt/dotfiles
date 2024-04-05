vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'gitcommit',
    'markdown',
    'text',
  },
  callback = function()
    vim.opt_local.spell = true
  end
})

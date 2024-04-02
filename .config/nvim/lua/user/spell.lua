vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'gitcommit',
    'markdown',
    'text',
  },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spellcapcheck = ''
    vim.opt_local.spelloptions = 'camel'
  end
})

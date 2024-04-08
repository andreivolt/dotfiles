vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'gitcommit',
    'markdown',
    'text',
  },
  callback = function()
    vim.wo.foldcolumn = '1'

    vim.opt_local.spellcapcheck = ''

    vim.keymap.set('n', 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true, buffer = true })
    vim.keymap.set('n', 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true, buffer = true })
  end
})

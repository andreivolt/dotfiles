local ft = {
  'gitcommit',
  'markdown',
  'scratch',
  'text',
}

return {
  'dkarter/bullets.vim',
  ft = ft,
  init = function()
    vim.g.bullets_enabled_file_types = ft
    vim.g.bullets_pad_right = false
  end,
}

local file_types = {
  'gitcommit',
  'markdown',
  'scratch',
  'text',
}

return {
  'dkarter/bullets.vim',
  ft = file_types,
  init = function()
    vim.g.bullets_enabled_file_types = file_types
    vim.g.bullets_pad_right = false
  end,
}

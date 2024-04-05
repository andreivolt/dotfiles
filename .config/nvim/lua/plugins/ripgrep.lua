return {
  "jremmen/vim-ripgrep",
  init = function()
    vim.g.rg_command = 'rg --vimgrep --hidden --smart-case'
    vim.g.rg_highlight = true
  end,
  cmd = {
    'Rg',
    'RgRoot',
  },
}

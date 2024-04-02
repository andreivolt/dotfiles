return {
  "jremmen/vim-ripgrep",
  cmd = { 'Rg', 'RgRoot' },
  init = function()
    vim.g.rg_command = 'rg --vimgrep --hidden --smart-case'
    vim.g.rg_highlight = true
  end,
  lazy = true
}

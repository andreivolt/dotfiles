return {
  "kevinhwang91/nvim-hlslens",
  keys = {
    { 'n', 'n', function() vim.cmd('execute "normal! " . v:count1 . "n"'); require('hlslens').start() end, kopts },
    { 'n', 'N', function() vim.cmd('execute "normal! " . v:count1 . "N"'); require('hlslens').start() end, kopts },
    { 'n', '*', function() vim.cmd('normal! *'); require('hlslens').start() end, kopts },
    { 'n', '#', function() vim.cmd('normal! #'); require('hlslens').start() end, kopts },
    { 'n', 'g*', function() vim.cmd('normal! g*'); require('hlslens').start() end, kopts },
    { 'n', 'g#', function() vim.cmd('normal! g#'); require('hlslens').start() end, kopts },
    { 'n', '<Leader>l', function() vim.cmd('noh') end, kopts },
  },
  lazy = true
}

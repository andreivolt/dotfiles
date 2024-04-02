local kopts = { mode = "n", noremap = true, silent = true}

return {
  "kevinhwang91/nvim-hlslens",
  keys = {
    { 'n', function() vim.cmd('execute "normal! " . v:count1 . "n"'); require('hlslens').start() end, kopts },
    { 'N', function() vim.cmd('execute "normal! " . v:count1 . "N"'); require('hlslens').start() end, kopts },
    { '*', function() vim.cmd('normal! *'); require('hlslens').start() end, kopts },
    { '#', function() vim.cmd('normal! #'); require('hlslens').start() end, kopts },
    { 'g*', function() vim.cmd('normal! g*'); require('hlslens').start() end, kopts },
    { 'g#', function() vim.cmd('normal! g#'); require('hlslens').start() end, kopts },
  },
}

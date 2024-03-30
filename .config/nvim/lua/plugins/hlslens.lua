return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    require('hlslens').setup()

    local kopts = {noremap = true, silent = true}

    vim.keymap.set('n', 'n', function() vim.cmd('execute "normal! " . v:count1 . "n"'); require('hlslens').start() end, kopts)
    vim.keymap.set('n', 'N', function() vim.cmd('execute "normal! " . v:count1 . "N"'); require('hlslens').start() end, kopts)
    vim.keymap.set('n', '*', function() vim.cmd('normal! *'); require('hlslens').start() end, kopts)
    vim.keymap.set('n', '#', function() vim.cmd('normal! #'); require('hlslens').start() end, kopts)
    vim.keymap.set('n', 'g*', function() vim.cmd('normal! g*'); require('hlslens').start() end, kopts)
    vim.keymap.set('n', 'g#', function() vim.cmd('normal! g#'); require('hlslens').start() end, kopts)
    vim.keymap.set('n', '<Leader>l', function() vim.cmd('noh') end, kopts)
  end,
  lazy = true
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'txt',
  callback = function()
    vim.opt.foldcolumn = '1'

    vim.bo.expandtab = false
    vim.bo.tabstop = 4;
    vim.bo.shiftwidth = 4

    vim.o.foldminlines = 0
    vim.o.foldmethod = 'indent'

    vim.cmd('RainbowLevelsOn')
  end
})

-- maintain aligment after folding TODO
-- local indent_level = fn.indent(vim.v.foldstart)
-- local indent = fn['repeat'](' ', indent_level)

function MyFoldText()
    local indent = vim.fn.indent(vim.v.foldstart) - vim.o.shiftwidth
    return string.rep(' ', indent) .. '+' .. string.rep('-', vim.o.shiftwidth - 2) .. ' ' .. string.gsub(vim.fn.getline(vim.v.foldstart), '^%s*', '')
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'text',
  callback = function()
    vim.wo.foldcolumn = '1'

    vim.bo.expandtab = false
    vim.bo.tabstop = 4;
    vim.bo.shiftwidth = 4

    vim.wo.foldminlines = 0
    vim.wo.foldmethod = 'indent'
    vim.wo.foldtext = 'v:lua.MyFoldText()'
  end
})

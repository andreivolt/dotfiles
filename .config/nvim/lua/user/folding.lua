-- maintain aligment after folding TODO
-- local indent_level = fn.indent(vim.v.foldstart)
-- local indent = fn['repeat'](' ', indent_level)
function MyFoldText()
    local indent = vim.fn.indent(vim.v.foldstart) - vim.o.shiftwidth
    return string.rep(' ', indent) .. '+' .. string.rep('-', vim.o.shiftwidth - 2) .. ' ' .. string.gsub(vim.fn.getline(vim.v.foldstart), '^%s*', '')
end

vim.o.foldtext = 'v:lua.MyFoldText()'

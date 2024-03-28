vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '.pryrc',
    callback = function()
        vim.o.filetype = 'ruby'
    end
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.json.jbuilder',
    callback = function()
        vim.o.filetype = 'ruby'
    end
})

require 'lspconfig'.solargraph.setup {}

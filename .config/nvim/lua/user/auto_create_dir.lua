vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(event)
    if event.match:match('^%w%w+://') then return end

    local file = vim.uv.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

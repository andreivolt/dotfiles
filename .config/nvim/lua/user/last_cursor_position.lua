-- when editing a file, always jump to the last known cursor position. expect git commit messages
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    local line = vim.fn.line

    local not_in_event_handler = line("'\"") > 0 and line("'\"") <= line("$")

    -- not vim.regex([[commit\|rebase]]):match_str(vim.bo.filetype) TODO

    if not (ft == "gitcommit") and not_in_event_handler then vim.fn.execute('normal g`"') end
  end
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, [["]])
    if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then vim.api.nvim_win_set_cursor(0, mark) end
  end
})

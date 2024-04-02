function no_scroll_at_eof()
  local curpos = vim.api.nvim_win_get_cursor(0)
  local lnum = curpos[1]
  local len = vim.api.nvim_buf_line_count(0)

  if lnum + vim.api.nvim_win_get_height(0) >= len then
    vim.cmd('normal! zb')
  end
end

vim.keymap.set('n', '<c-f>', '<c-f>:lua no_scroll_at_eof()<cr>', { noremap = true, silent = true })

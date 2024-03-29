vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "FocusGained"}, {
  pattern = "*",
  callback = function()
    local filename = vim.fn.expand("%:t")
    if filename ~= "" then
      vim.fn.system("tmux rename-window ' " .. filename .. "'")
    else
      vim.fn.system("tmux rename-window ' <no file>'")
    end
  end
})

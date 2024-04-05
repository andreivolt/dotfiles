vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "FocusGained" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      local filename = vim.fn.expand("%:t")

      vim.fn.system(
        "tmux rename-window '"
        .. (filename ~= "" and filename or " <no file>") ..
        "'"
      )
    end
  end
})

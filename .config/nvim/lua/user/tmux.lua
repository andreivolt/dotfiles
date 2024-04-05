vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "FocusGained" }, {
  pattern = "*",
  callback = function()
    if not vim.bo.buftype == "" then return end

    local filename = vim.fn.expand("%:t")

    vim.fn.system(
      "tmux rename-window '"
      .. (filename ~= "" and filename or " <no file>") ..
      "'"
    )
  end
})

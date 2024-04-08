vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "FocusGained" }, {
  pattern = "*",
  callback = function()
    if not vim.bo.buftype == "" or vim.bo.buftype == "nofile" then return end

    local bufname = vim.fn.expand("%")
    if bufname:match(".*/edir.sh$") or bufname:match(".*/dir%w+$") then return end

    local filename = vim.fn.expand("%:t")

    vim.fn.system("tmux rename-window '" .. (filename ~= "" and filename or " <no file>") .. "'")
  end
})

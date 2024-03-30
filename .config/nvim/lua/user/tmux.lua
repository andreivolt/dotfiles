vim.api.nvim_create_autocmd({
  "BufEnter",
  "BufWritePost",
  "FocusGained",
},
{
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      local filename = vim.fn.expand("%:t")

      if filename ~= "" then
        vim.fn.system("tmux rename-window ' " .. filename .. "'")
      else
        vim.fn.system("tmux rename-window ' <no file>'")
      end
    end
  end
})

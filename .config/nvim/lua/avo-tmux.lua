-- tmux window title
-- if (vim.env.TMUX ~= nil) TODO
if os.getenv('TMUX') then
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufReadPost', 'FileReadPost', 'BufNewFile' }, {
    pattern = '*',
    callback = function()
        if vim.o.buftype == "" then
            -- vim.fn.system("tmux rename-window '" .. vim.fn.expand("%:t:S") .. " [vim]'")
            vim.fn.system("tmux rename-window '" .. vim.fn.expand("%:t:S") .. " '")
            -- os.execute TODO
        end
    end
  })
  vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
      vim.fn.system("tmux rename-window zsh")
      vim.fn.system("tmux set-window automatic-rename on")
    end,
  })
  -- vim.api.nvim_create_autocmd({ 'BufEnter' }, '*', [[let &titlestring = ' ' . expand("%:t")]] }) TODO
end

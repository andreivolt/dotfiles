vim.g.neovide_cursor_animation_length = 0.02
-- vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_scroll_animation_length = 0.07
vim.opt.linespace = -2
vim.g.neovide_transparency = 0.8
vim.g.neovide_window_blurred = true

vim.api.nvim_create_autocmd({"VimEnter", "BufWinEnter"}, {
  callback = function()
    if vim.bo.buftype == "" then vim.wo.winbar = "%f" end
  end,
})

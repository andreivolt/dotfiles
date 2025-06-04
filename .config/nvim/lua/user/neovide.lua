vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_hide_mouse_when_typing = true
-- vim.g.neovide_input_macos_alt_is_meta = true -- TODO {
vim.g.neovide_remember_window_size = false
vim.g.neovide_scroll_animation_length = 0.07
vim.g.neovide_opacity = 0.7
vim.g.neovide_window_blurred = true
vim.opt.linespace = -2

-- vim.opt.fillchars = { vert = " " }

-- TODO
vim.opt.guicursor = {
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175"
}

-- vim.api.nvim_create_autocmd({"VimEnter", "BufWinEnter"}, {
--   callback = function()
--     if vim.bo.buftype == "" then vim.wo.winbar = "%f" end
--   end,
-- })
--

-- vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste", noremap = true })
-- vim.keymap.set("v", "<D-c>", '"+ygv', { desc = "Copy", noremap = true })
-- vim.keymap.set("v", "<D-v>", '"+p', { desc = "Paste", noremap = true })
-- vim.keymap.set("i", "<D-v>", '<c-r>+', { desc = "Paste", noremap = true, silent = false })
-- vim.keymap.set("t", "<D-v>", '<C-\\\\><C-n>"+pa', { desc = "Paste", noremap = true })

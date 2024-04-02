local util = require('user.util')

vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch)

vim.keymap.set("n", "<leader><leader>", function()
  if vim.fn.expand("#") == "" then return end
  vim.cmd("edit #")
end)

vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>bp", vim.cmd.bprev)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

vim.keymap.set("n", "<leader>gd", function()
  local file_path = vim.fn.expand('%:p')
  vim.cmd('bdelete!')
  if vim.fn.delete(file_path) == 0 then
    vim.notify('File deleted: ' .. vim.fn.fnamemodify(file_path, ':t'), vim.log.levels.INFO)
  else
    vim.notify('Failed', vim.log.levels.ERROR)
  end
end)

vim.keymap.set("n", "gp", "[v]")

vim.keymap.set("v", "<tab>", ">gv")
vim.keymap.set("v", "<s-tab>", "<gv")
-- vim.keymap.set("n", "<tab>", ">>")
-- vim.keymap.set("n", "<s-tab>", "<<")

vim.keymap.set("n", "<leader>tn", function() vim.cmd("set number!") end)
vim.keymap.set("n", "<leader>ts", function() vim.cmd("set spell!") end)

vim.keymap.set("n", "<leader>u", util.open_url)

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "gf", function() vim.cmd("edit <cfile>") end)

vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")

vim.keymap.set('x', 'v', require('nvim-treesitter.incremental_selection').node_incremental)
vim.keymap.set('x', 'V', require('nvim-treesitter.incremental_selection').node_decremental)

vim.keymap.set("v", "y", function() return 'my"' .. vim.v.register .. "y`y" end, { expr = true })

vim.keymap.set("n", "n", "nzzzv", { desc = "center search hits vertically on screen and expand folds if hit is inside" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "center search hits vertically on screen and expand folds if hit is inside" })
-- vim.keymap.set("v", "y", "ygv<Esc>") -- TODO

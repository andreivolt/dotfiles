local util = require('user.util')

vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "clear search" })

vim.keymap.set("n", "<leader><leader>", function() if vim.fn.expand("#") == "" then return end vim.cmd("edit #") end, { desc = "alternate file" })

vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "next buffer" })
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "delete buffer" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprev, { desc = "previous buffer" })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "close buffer" })
vim.keymap.set("n", "<leader>qa", vim.cmd.qall, { desc = "quit" })

vim.keymap.set("n", "<leader>gd", function() vim.cmd("Delete!") end, { desc = "delete file" })

vim.keymap.set("n", "gp", "[v]", { desc = "reselect pasted" })

vim.keymap.set("v", "<tab>", ">gv", { desc = "indent" })
vim.keymap.set("v", "<s-tab>", "<gv", { desc = "unindent" })

vim.keymap.set("n", "<leader>tn", function() vim.cmd("set number!") end, { desc = "line numbers" })
vim.keymap.set("n", "<leader>ts", function() vim.cmd("set spell!") end, { desc = "spelling" })

vim.keymap.set("n", "<leader>u", util.open_url)

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "gf", function() vim.cmd("edit <cfile>") end)

vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")

vim.keymap.set('x', 'v', require('nvim-treesitter.incremental_selection').node_incremental)
vim.keymap.set('x', 'V', require('nvim-treesitter.incremental_selection').node_decremental)

vim.keymap.set("v", "y", function() return 'my"' .. vim.v.register .. "y`y" end, { expr = true, desc = "yank and keep selection" })

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>")
-- vim.keymap.set("v", "y", "ygv<Esc>", { desc = "yank and keep selection" }) -- TODO

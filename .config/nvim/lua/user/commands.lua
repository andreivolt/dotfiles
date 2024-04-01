local util = require('user.util')

vim.api.nvim_create_user_command("CopyFullName", function() util.clip(vim.fn.expand("%")) end, {})
vim.api.nvim_create_user_command("CopyPath", function() util.clip(vim.fn.expand("%:h")) end, {})
vim.api.nvim_create_user_command("CopyFileName", function() util.clip(vim.fn.expand("%:t")) end, {})
vim.api.nvim_create_user_command("CopyPathAndLineNumber", function() util.clip(string.format("%s:%d", vim.fn.bufname(), vim.fn.line("."))) end, {})

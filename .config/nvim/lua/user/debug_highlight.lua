vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.ex",
  command = 'syn match Error "IO.puts\\|IO.inspect"',
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.rb",
  command = 'syn match Error "binding.pry\\|debugger"',
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*.js", "*.ts", "*.tsx"},
  command = 'syn match Error "console.log"',
})


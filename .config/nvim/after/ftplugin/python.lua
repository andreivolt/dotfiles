if vim.fn.executable("black") == 1 then
  vim.opt_local.formatprg = "black --fast --quiet -"
end

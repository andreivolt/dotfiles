return {
  "ntpeters/vim-better-whitespace",
  init = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        vim.cmd("<cmd>StripWhitespaceOnChangedLines<cr>")
      end,
    })
  end,
  event = "VeryLazy",
  lazy = false
}

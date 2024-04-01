return {
  "thiagoalessio/rainbow_levels.vim",
  ft = "text",
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'text',
      callback = function()
        vim.cmd("RainbowLevelsOn")
      end
    })
  end
}

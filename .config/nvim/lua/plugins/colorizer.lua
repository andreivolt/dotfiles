return {
  "norcalli/nvim-colorizer.lua",
  event = { 'BufReadPost', 'BufNewFile' },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "" then
          require'colorizer'.attach_to_buffer()
        end
      end,
    })
  end,
  opts = {
    "*",
  },
  lazy = true,
}


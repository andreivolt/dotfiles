return {
  "akinsho/bufferline.nvim",
  enabled = false,
  tag = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      always_show_bufferline = false,
      enforce_regular_tabs = true
    }
  },
  lazy = true,
  init = function()
    vim.api.nvim_set_hl(0, 'BufferLineFill', {bg = '#222222'})
  end
}

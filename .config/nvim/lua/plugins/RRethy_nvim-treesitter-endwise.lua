local M = {}

M.setup = function()
  require("nvim-treesitter.configs").setup({
    endwise = {
      enable = true,
    },
  })
end

return M

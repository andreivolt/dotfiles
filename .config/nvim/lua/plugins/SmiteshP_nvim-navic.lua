local M = {}

M.setup = function()
  require("nvim-navic").setup({
    lazy_update_context = true,
    lsp = {
      auto_attach = true
    }
  })
end

return M

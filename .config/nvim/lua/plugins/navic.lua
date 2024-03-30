return {
  "SmiteshP/nvim-navic",
  enabled = false,
  dependencies = "neovim/nvim-lspconfig",
  opts = {
    lazy_update_context = true,
    lsp = {
      auto_attach = true
    }
  }
}

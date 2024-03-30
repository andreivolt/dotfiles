return {
  "folke/neodev.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    'hrsh7th/nvim-cmp'
  },
  ft = { "lua" },
  config = function(_, opts)
    require("neodev").setup(opts)

    require("lspconfig").lua_ls.setup({
      inlay_hints = { enabled = true },
      settings = {
        Lua = {
          telemetry = {
            enable = false
          },
          diagnostics = {
            globals = { 'vim', 'hs', 'spoon' },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
}

return {
  "folke/neodev.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    'hrsh7th/nvim-cmp',
    "SmiteshP/nvim-navic",
  },
  init = function()
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end,
  config = function(_, opts)
    require("neodev").setup(opts)

    local navic = require("nvim-navic")

    require("lspconfig").lua_ls.setup({
      inlay_hints = {
        enabled = true,
      },
      on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
      end
    })
  end,
  ft = "lua",
}

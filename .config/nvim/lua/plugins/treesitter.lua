local M = {}

M.setup = function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true
    },
    context_commentstring = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        scope_incremental = "grc",
        -- node_incremental = "grn",
        -- node_decremental = "grm",
        node_incremental = "v",
        node_decremental = "V",
      },
    },
    indent = {
      enable = true
    }
  }
end

return M

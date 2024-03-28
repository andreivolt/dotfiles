local M = {}

M.setup = function()
  require 'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
      enable = true,
    },
    context_commentstring = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        scope_incremental = 'grc',
        -- node_incremental = 'grn',
        -- node_decremental = 'grm',
        node_incremental = 'v',
        node_decremental = 'V',
      },
    },
    indent = {
      enable = true
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner'
        }
      },
      swap = {
        enable = true,
        swap_next = {
          ['g>>'] = '@parameter.inner',
          ['g>f'] = '@function.outer'
        },
        swap_previous = {
          ['g<<'] = '@parameter.inner',
          ['g<f'] = '@function.outer'}
        }
      }
    }
  end

  return M

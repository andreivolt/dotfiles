return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  build = ":TSUpdate",
  opts = {
    auto_install = true,
    ensure_installed = "all", -- TODO
    ignore_install = { "norg" },
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
    },
    disable = function(lang, buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  }
}

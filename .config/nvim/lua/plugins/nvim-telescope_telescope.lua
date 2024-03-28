local M = {}

M.setup = function()
  local actions = require('telescope.actions')

  require('telescope').setup { defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-k>"] = require('telescope.actions').move_selection_previous,
          ["<C-j>"] = require('telescope.actions').move_selection_next,
        },
        n = {
          ["<C-k>"] = require('telescope.actions').move_selection_previous,
          ["<C-j>"] = require('telescope.actions').move_selection_next,
          ["q"] = require('telescope.actions').close,
        },
      },
    },
  }

  require('telescope').load_extension('fzf')
end

return M

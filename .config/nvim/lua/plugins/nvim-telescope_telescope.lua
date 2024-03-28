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
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  }

  require('telescope').load_extension('fzf')
end

return M

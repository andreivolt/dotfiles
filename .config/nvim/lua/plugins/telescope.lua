return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function() return vim.fn.executable 'make' == 1 end
    },
  },
  keys = {
    {"<leader>fb", "<cmd>Telescope buffers<cr>"},
    {"<leader>ff", "<cmd>Telescope find_files<cr>"},
    {"<leader>fg", "<cmd>Telescope live_grep<cr>"},
  },
  cmd = { "Telescope" },
  config = function()
    require('telescope').setup {
      defaults = {
        results_title = "",
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
  end,
  lazy = true
}

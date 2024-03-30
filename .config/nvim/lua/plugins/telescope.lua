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
  cmd = { "Telescope" },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
          n = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["q"] = actions.close,
          },
        },
      },
    }

    require('telescope').load_extension('fzf')
  end,
  init = function()
    local telescope_builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers)
    vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
    vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep)
  end,
}

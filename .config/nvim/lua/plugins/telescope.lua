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
    require('telescope').setup {
      defaults = {
        results_title = "",
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    border = true,
    border_attr = { fg = 'red' },
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
  init = function()
    vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
  end,
  event = "VeryLazy",
}

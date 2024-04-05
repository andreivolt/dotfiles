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
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
  },
  opts = function()
    return {
      defaults = {
        results_title = "",
        mappings = {
          i = {
            ["<esc>"] = require('telescope.actions').close, -- close on first esc instead of going to normal mode

            ["<C-u>"] = false,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
            ["<C-j>"] = require('telescope.actions').move_selection_next,
          },
          -- n = {
          --   ["<C-k>"] = require('telescope.actions').move_selection_previous,
          --   ["<C-j>"] = require('telescope.actions').move_selection_next,
          --   ["q"] = require('telescope.actions').close,
          -- }
        },
        -- set_env = { ["COLORTERM"] = "truecolor" },
      },
      pickers = {
        buffers = { theme = "dropdown" },
        find_files = { theme = "dropdown" },
        live_grep = { theme = "dropdown" },
      }
    }
  end,
  config = function(_, opts)
    require('telescope').setup(opts)

    pcall(require('telescope').load_extension('fzf'))
  end,
  cmd = "Telescope",
}

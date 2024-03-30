return {
  "isak102/telescope-git-file-history.nvim",
  dependencies = {
    'nvim-telescope/telescope.nvim',
    "tpope/vim-fugitive"
  },
  -- lazy = true,
  keys = {
    {
      "<Leader>fh", "<cmd>Telescope git_file_history<CR>", desc = "git file history"
    }
  },
  init = function()
    require('telescope').load_extension('git_file_history')
  end
}

return {
  'alexghergh/nvim-tmux-navigation',
  event = "VeryLazy",
  opts = { disable_when_zoomed = true },
  config = function()
    vim.keymap.set('n', "<c-h>", require('nvim-tmux-navigation').NvimTmuxNavigateLeft)
    vim.keymap.set('n', "<c-j>", require('nvim-tmux-navigation').NvimTmuxNavigateDown)
    vim.keymap.set('n', "<c-k>", require('nvim-tmux-navigation').NvimTmuxNavigateUp)
    vim.keymap.set('n', "<c-l>", require('nvim-tmux-navigation').NvimTmuxNavigateRight)
    vim.keymap.set('n', "<c-\\>", require('nvim-tmux-navigation').NvimTmuxNavigateLastActive)
    vim.keymap.set('n', "<c-space>", require('nvim-tmux-navigation').NvimTmuxNavigateNext)
  end,
}

-- return {
--   "christoomey/vim-tmux-navigator",
--   enabled = vim.env.TMUX,
--   cmd = {
--     "TmuxNavigateLeft",
--     "TmuxNavigateDown",
--     "TmuxNavigateUp",
--     "TmuxNavigateRight",
--     "TmuxNavigatePrevious",
--   },
--   keys = {
--     { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
--     { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
--     { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
--     { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
--     { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
--   },
-- }

return {
  'alexghergh/nvim-tmux-navigation',
  enabled = vim.env.TMUX,
  keys = {
    {"<c-h>", "<cmd>NvimTmuxNavigateLeft<cr>"},
    {"<c-j>", "<cmd>NvimTmuxNavigateDown<cr>"},
    {"<c-k>", "<cmd>NvimTmuxNavigateUp<cr>"},
    {"<c-l>", "<cmd>NvimTmuxNavigateRight<cr>"},
    {"<c-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>"},
    {"<c-space>", "<cmd>NvimTmuxNavigateNext<cr>"},
  },
  opts = { disable_when_zoomed = true },
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

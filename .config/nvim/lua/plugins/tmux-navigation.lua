return {
    'alexghergh/nvim-tmux-navigation',
    event = "VeryLazy",
    opts = { disable_when_zoomed = true },
    config = function()
        local nvim_tmux_nav = require('nvim-tmux-navigation')

        vim.keymap.set('n', "<c-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<c-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<c-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<c-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('n', "<c-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        vim.keymap.set('n', "<c-space>", nvim_tmux_nav.NvimTmuxNavigateNext)
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

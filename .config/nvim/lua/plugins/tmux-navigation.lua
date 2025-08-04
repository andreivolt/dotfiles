return {
  'alexghergh/nvim-tmux-navigation',
  enabled = vim.env.TMUX,
  keys = {
    { "<c-h>",     "<cmd>NvimTmuxNavigateLeft<cr>" },
    { "<c-j>",     "<cmd>NvimTmuxNavigateDown<cr>" },
    { "<c-k>",     "<cmd>NvimTmuxNavigateUp<cr>" },
    { "<c-l>",     "<cmd>NvimTmuxNavigateRight<cr>" },
    { "<c-\\>",    "<cmd>NvimTmuxNavigateLastActive<cr>" },
    { "<c-space>", "<cmd>NvimTmuxNavigateNext<cr>" },
  },
  opts = {
    disable_when_zoomed = true,
  },
}

return {
  "f-person/git-blame.nvim",
  dependencies = "neovim/nvim-lspconfig",
  cmd = {
    "GitBlameOpenCommitURL",
    "GitBlameToggle",
    "GitBlameEnable",
    "GitBlameDisable",
    "GitBlameCopySHA",
    "GitBlameCopyCommitURL",
    "GitBlameOpenFileURL",
    "GitBlameCopyFileURL",
    "GitBlameCopyFileURL",
  },
  init = function()
    vim.g.gitblame_highlight_group = "Question"
    vim.g.gitblame_enabled = 0
  end,
}

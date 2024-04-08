return {
  "andymass/vim-matchup",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup({
      matchup = {
        enable = true,
        enable_quotes = true,
      }
    })
  end,
  event = "BufReadPost",
}

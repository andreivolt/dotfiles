return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { "<leader>m", "<cmd>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
  },
  cmd = {
    "TSJJoin",
    "TSJSplit",
    "TSJToggle",
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = math.huge
  },
}

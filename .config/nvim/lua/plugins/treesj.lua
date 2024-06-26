return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { "<leader>m", "<cmd>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = math.huge
  },
  cmd = {
    "TSJJoin",
    "TSJSplit",
    "TSJToggle",
  },
}

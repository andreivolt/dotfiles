return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = { "<leader>n" },
  opts = {
    git = {
      enable = false,
    },
    disable_netrw = true,
    renderer = {
      indent_markers = { enable = true },
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_label = false,
    },
    view = {
      cursorline = false,
      width = 35,
    }
  },
  init = function()
    vim.keymap.set("n", "<leader>n", require("nvim-tree.api").tree.toggle)
  end,
}

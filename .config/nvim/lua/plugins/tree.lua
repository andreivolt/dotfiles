return {
  'kyazdani42/nvim-tree.lua',
  dependencies =  'nvim-tree/nvim-web-devicons',
  keys = {
    {"<leader>n", "<cmd>NvimTreeFindFileToggle<cr>"},
  },
  opts = {
    git = {
      enable = false,
    },
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    renderer = {
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_label = false,
    },
    view = {
      cursorline = false,
      width = 30,
    }
  },
}

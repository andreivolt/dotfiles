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
    filesystem_watchers = {
      ignore_dirs = {
        "node_modules",
        ".git",
        "/Users/andrei/Library",
        "/System",
        "/Applications",
        "/usr",
        "/opt",
      },
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_label = false,
      icons = {
        show = {
          file = false,
          folder = false,
          git = false,
        }
      }
    },
    view = {
      cursorline = false,
      width = 30,
    },
    on_attach = require("user.nvim-tree-git-mv").on_attach,
  },
}

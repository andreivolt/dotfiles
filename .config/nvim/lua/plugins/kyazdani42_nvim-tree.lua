local M = {}

M.setup = function()
  require("nvim-tree").setup({
    renderer = {
      indent_markers = { enable = true },
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_label = "",
    },
    view = {
      width = 35,
    }
  })
end

return M


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

  vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#333333" }) -- TODO autocmd
end

return M

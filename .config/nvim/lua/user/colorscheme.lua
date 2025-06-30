-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.api.nvim_set_hl(0, "Comment", { fg = "#777777", italic = true })
--     vim.api.nvim_set_hl(0, "Folded", { fg = "#aaaaaa" })
--     vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
--     vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#333333" })
--     vim.api.nvim_set_hl(0, "Pmenu", { bg = "#111111" })
--     vim.api.nvim_set_hl(0, "Question", { fg = "#444444" })
--     vim.api.nvim_set_hl(0, "SpellBad", { bg = "NONE", fg = "NONE", sp = "red", undercurl = true })
--     vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#333333" })
--     vim.api.nvim_set_hl(0, "WinSeparator", { bg = "black", fg = "#333333" })
--     vim.api.nvim_set_hl(0, "ZenBg", { bg = "black" })
--
--     -- vim.api.nvim_set_hl(0, "CmpPmenuBorder", { bg = "#333333" })
--   end,
-- })

vim.api.nvim_exec([[syn match URL /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/ containedin=ALL]], false)
vim.api.nvim_set_hl(0, "URL", { underline = true, fg = "skyblue" })

vim.cmd("colorscheme aurora")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Make Normal background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    
    -- Handle EndOfBuffer coloring
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    if normal_hl.bg then
      local bg_color = string.format("#%06x", normal_hl.bg)
      local MiniColors = require('mini.colors')
      
      -- Use modify_channel to darken the lightness
      local darkened_bg = MiniColors.modify_channel(bg_color, 'lightness', function(l) return l * 0.5 end)
      
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = darkened_bg, bg = darkened_bg })
    end
  end,
})

-- Apply transparent background to current colorscheme
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

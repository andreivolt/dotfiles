vim.opt.fillchars.append = { fold = " ", foldclose = "▸", foldopen = "▾" }
-- vim.opt.foldcolumn = "1"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.wo.foldtext = 'getline(vim.v.foldstart).."..."..string.match(getline(vim.v.foldend), "^%s*(.-)%s*$")' -- TODO

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if not vim.bo.buftype == "" then return end

    vim.opt_local.statuscolumn = [[%{(foldlevel(v:lnum) && foldlevel(v:lnum) > foldlevel(v:lnum - 1)) ? (foldclosed(v:lnum) == -1 ? '⌄' : '›') : ' '}]] .. ' ' .. '%=%{v:virtnum < 1 ? (v:lnum) : " "}' .. '%s'
  end,
})

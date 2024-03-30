vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.directory = "/tmp"
vim.opt.fillchars = { diff = "⣿", eob = " ", fold = " ", foldclose = "▸", foldopen = "▾", foldsep = "│", vert = "│" }
vim.opt.foldcolumn = "0"
vim.opt.foldenable = false
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.wo.foldtext = 'getline(vim.v.foldstart).."..."..string.match(getline(vim.v.foldend), "^%s*(.-)%s*$")'
vim.opt.guifont = "Iosevka Nerd Font Mono:h24:w-3:#h-none"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.iskeyword:append("-")
vim.opt.laststatus = 0
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.path:append({ "**" })
vim.opt.pumblend = 25
vim.opt.pumheight = 10
vim.opt.ruler = false
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shortmess:append({ I = true })
vim.opt.showbreak = "↳ "
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.tags:prepend({ "./tags;" })
vim.opt.tags:remove({ "./tags", "./tags;" })
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wildignorecase = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = true

if vim.env.TMUX then require("user.tmux") end
if vim.g.neovide then require("user.neovide") end

require("user.syntax")

local utils = require("user.util")

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" } }, {
  install = { colorscheme = { "aurora" } },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})

vim.keymap.set("n", "<esc>", vim.cmd.nohlsearch, { desc = "clear search" })
vim.keymap.set("n", "<leader><leader>", function() if vim.fn.expand("#") == "" then return end vim.cmd("edit #") end, { desc = "alternate file" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "next buffer" })
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "delete buffer" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprev, { desc = "previous buffer" })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "close buffer" })
vim.keymap.set("n", "<leader>qa", vim.cmd.qall, { desc = "quit" })
vim.keymap.set("n", "<leader>gd", function() vim.cmd("Delete!") end, { desc = "delete file" })
vim.keymap.set("n", "gp", "[v]", { desc = "reselect pasted" })
vim.keymap.set("v", "<tab>", ">gv", { desc = "indent" })
vim.keymap.set("v", "<s-tab>", "<gv", { desc = "unindent" })
vim.keymap.set("n", "<c-w>m", vim.cmd["MaximizerToggle"])
vim.keymap.set("n", "<leader>tn", function() vim.cmd("set number!") end, { desc = "line numbers" })
vim.keymap.set("n", "<leader>u", utils.open_url)
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "gf", function() vim.cmd("edit <cfile>") end)
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "y", function() return 'my"' .. vim.v.register .. "y`y" end, { expr = true, desc = "yank and keep selection" })
-- vim.keymap.set("v", "y", "ygv<Esc>", { desc = "yank and keep selection" })

vim.api.nvim_create_user_command("CopyFullName", function() utils.clip(vim.fn.expand("%")) end, {})
vim.api.nvim_create_user_command("CopyPath", function() utils.clip(vim.fn.expand("%:h")) end, {})
vim.api.nvim_create_user_command("CopyFileName", function() utils.clip(vim.fn.expand("%:t")) end, {})
vim.api.nvim_create_user_command("CopyPathAndLineNumber", function() utils.clip(string.format("%s:%d", vim.fn.bufname(), vim.fn.line("."))) end, {})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    for g, attrs in pairs({
      Comment = { fg = "#777777", italic = true },
      FoldColumn = { fg = "#333333" },
      Folded = { bg = "black" },
      Normal = { bg = "black" },
      NvimTreeIndentMarker = { fg = "#333333" },
      Question = { fg = "#444444" },
      SpellBad = { bg = "NONE", fg = "NONE", sp = "red", undercurl = true },
      WinSeparator = { bg = "black", fg = "#444444" },
      ZenBg = { bg = "black" },
    }) do vim.api.nvim_set_hl(0, g, attrs) end

    vim.api.nvim_exec([[syn match URL /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/ containedin=ALL]], false)
    vim.api.nvim_set_hl(0, "URL", { underline = true, fg = "skyblue" })
  end,
})

vim.cmd("colorscheme aurora")

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ on_visual = true })
  end,
})

-- vim.api.nvim_create_autocmd({"VimEnter", "BufWinEnter"}, {
--   callback = function() if vim.bo.buftype == "" then vim.wo.winbar = "%f" end end,
-- })

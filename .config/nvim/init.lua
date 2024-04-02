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
vim.opt.directory = vim.fn.getenv("TMPDIR")
vim.opt.fillchars = { diff = "⣿", eob = " ", fold = " ", foldclose = "▸", foldopen = "▾", foldsep = "│", vert = "│" }
vim.opt.foldcolumn = "1"
vim.opt.foldenable = false
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.wo.foldtext = 'getline(vim.v.foldstart).."..."..string.match(getline(vim.v.foldend), "^%s*(.-)%s*$")'
vim.opt.guifont = "Iosevka Nerd Font Mono:h21:w-3:#h-none"
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
vim.opt.shiftwidth = 2
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

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
})

require("user.lazy")

require("user.syntax")
require("user.colorscheme")
require("user.commands")
require("user.keymaps")
if vim.env.TMUX then require("user.tmux") end
if vim.g.neovide then require("user.neovide") end

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

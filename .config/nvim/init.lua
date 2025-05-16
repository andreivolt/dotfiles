vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.loader.enable()
-- vim.g.loaded_gzip = 1
-- vim.g.loaded_tar = 1
-- vim.g.loaded_tarPlugin = 1
-- vim.g.loaded_zip = 1
-- vim.g.loaded_zipPlugin = 1
-- vim.g.loaded_getscript = 1
-- vim.g.loaded_getscriptPlugin = 1
-- vim.g.loaded_vimball = 1
-- vim.g.loaded_vimballPlugin = 1
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
-- vim.g.loaded_2html_plugin = 1
-- vim.g.loaded_logiPat = 1
-- vim.g.loaded_rrhelper = 1

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- vim.opt.belloff = ""
-- vim.opt.errorbells = true
-- vim.opt.winblend = 25
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdwinheight = 10
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true
vim.opt.fillchars = { eob = " " }
vim.opt.guifont = "Iosevka Nerd Font Mono:h24:w-3:#h-none"
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.laststatus = 0
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { nbsp = '␣', tab = '» ', trail = '·' }
vim.opt.mouse = "a"
vim.opt.path:append({ "**" })
vim.opt.pumblend = 25
vim.opt.pumheight = 10
vim.opt.ruler = false
vim.opt.scrolloff = 10
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true })
vim.opt.showbreak = "↳ "
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelloptions = 'camel'
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.tags:prepend({ "./tags;" })
vim.opt.tags:remove({ "./tags", "./tags;" })
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

require("user.globals")
require("user.plugins")

require("user.colorscheme")
require("user.fold")
require("user.debug_highlight")

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    if vim.env.TMUX then require("user.tmux") end
    if vim.g.neovide then require("user.neovide") end
    require("user.commands")
    require("user.cursorline")
    require("user.keymaps")
    require("user.spell")
    require("user.text")
  end,
})

vim.keymap.set('c', '<Tab>', function()
    if vim.fn.getcmdtype() == '/' or vim.fn.getcmdtype() == '?' then
        return '<CR>/<C-r>/'
    else
        return '<C-z>'
    end
end, { expr = true })

vim.keymap.set('c', '<S-Tab>', function()
    if vim.fn.getcmdtype() == '/' or vim.fn.getcmdtype() == '?' then
        return '<CR>?<C-r>/'
    else
        return '<S-Tab>'
    end
end, { expr = true })

-- " command mode movement
-- cnoremap <C-a> <Home>
-- cnoremap <C-e> <End>
-- cnoremap <C-p> <Up>
-- cnoremap <C-n> <Down>
-- cnoremap <C-b> <Left>
-- cnoremap <C-f> <Right>
-- cnoremap <M-b> <S-Left>
-- cnoremap <M-f> <S-Right>
--
-- " lisp case movement
-- set iskeyword+=-
--
-- set fillchars=stl:\ ,stlnc:\ ,vert:│
--
-- " hide messages after 1.5s
-- set updatetime=1500 | autocmd CursorHold * :echo
--
-- " windows
-- nmap <silent> <C-h> :wincmd h<CR> | nmap <silent> <C-j> :wincmd j<CR> | nmap <silent> <C-k> :wincmd k<CR> | nmap <silent> <C-l> :wincmd l<CR>
-- " arglist
-- nnoremap <leader>an :next<cr> | nnoremap <leader>ap :prev<cr>
-- " quickfix
-- nnoremap <leader>cn :cnext<cr> | nnoremap <leader>cp :cprev<cr>
-- " select last inserted text
-- nnoremap gV '[V']
-- " toggle line numbers
-- map <silent> <leader>tn :set number!<CR>
-- " fuzzy find
-- nnoremap <silent> <leader>b :FuzzyBuffer<CR>
-- nnoremap <silent> <leader>f :FuzzyOpen<CR>
vim.o.updatetime = 500

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.defer_fn(function()
      vim.cmd('echo ""') -- Clear the message
    end, 1000) -- Delay in milliseconds (2 seconds)
  end,
})

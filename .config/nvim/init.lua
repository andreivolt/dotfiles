function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.infercase = true
vim.opt.hidden = true
vim.opt.showbreak = "↳ "
vim.opt.title = true
vim.opt.ruler = false

vim.opt.fillchars = {
  vert = "│", -- vertical window separators
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}

-- reload config
vim.api.nvim_create_user_command("ConfReload", "so $MYVIMRC", {nargs = 0})

-- performance
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.signcolumn = "yes"

-- filename in window titlebars
vim.opt.winbar = "%f"

vim.opt.laststatus = 0

-- GUI
vim.opt.guifont = "Iosevka Nerd Font Mono:h20:w-2:#h-none"

-- clipboard
-- vim.opt.clipboard = 'unnamed'
vim.opt.clipboard = "unnamedplus"

-- performance ? TODO
vim.opt.lazyredraw = true

-- popup menu transparency
vim.opt.pumblend = 25

-- invert new split locations
vim.opt.splitbelow = true
vim.opt.splitright = true

-- command-line completion mode
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true

vim.opt.showmode = false

-- word wrap
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true -- indent line breaks

-- mouse everwhere
vim.opt.mouse = "a"

-- ignore case unless search has case
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.completeopt = "menu,menuone,noselect" -- completion
vim.opt.shortmess:append({I = true}) -- hide startup message
vim.opt.iskeyword:append("-") -- include dashes in keywords (lisp case)
vim.opt.path:append({"**"})
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.directory = "/tmp" -- don't save swap files in file dir
vim.opt.list = true -- show hidden chars
vim.opt.termguicolors = true -- 24-bit colors
vim.opt.scrolloff = 4 -- pad scroll

vim.g.vimsyn_embed = "lPr" -- vim embedded syntax highlighting

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true
})

require("lazy").setup({
  -- {"akinsho/bufferline.nvim", tag = "*", dependencies = "nvim-tree/nvim-web-devicons", config = function() require("bufferline").setup() end, lazy = true},
  -- {"ggandor/lightspeed.nvim"}, -- move hints
  -- {"gkz/vim-ls", lazy = true},
  -- {"hrsh7th/cmp-buffer", lazy = true},
  -- {"hrsh7th/cmp-cmdline", lazy = true},
  -- {"hrsh7th/cmp-nvim-lsp", lazy = true},
  -- {"hrsh7th/cmp-path", lazy = true},
  -- {"hrsh7th/nvim-cmp", lazy = true},
  -- {"junegunn/fzf", build = vim.fn["fzf#install"], dependencies = "junegunn/fzf.vim", lazy = true},
  -- {"kchmck/vim-coffee-script", lazy = true},
  -- {"matze/vim-move"}, -- lines move
  -- {"nvim-treesitter/nvim-treesitter-context", dependencies = "nvim-treesitter/nvim-treesitter", lazy = true},
  -- {"SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig", config = function() require('plugins.SmiteshP_nvim-navic').setup() end},
  -- {'airblade/vim-rooter"}, -- chdir to root
  -- {'numToStr/Comment.nvim', lazy = false}, -- TODO
  {"alvan/vim-closetag"},
  {"AndrewRadev/splitjoin.vim"},
  {"andymass/vim-matchup", dependencies = "nvim-treesitter/nvim-treesitter", config = function() require("nvim-treesitter.configs").setup({matchup = {enable = true}}) end},
  {"christoomey/vim-tmux-navigator", enabled = vim.env.TMUX}, -- seamless vim/tmux pane navigation
  {"clojure-vim/vim-jack-in", dependencies = {"vim-dispatch", "vim-dispatch-neovim"}, ft = "clojure"},
  {"eraserhd/parinfer-rust", build = "cargo build --release"},
  {"f-person/git-blame.nvim", config = function() require("plugins.f-person_git-blame").setup() end}, -- git blame virtual text
  {"farmergreg/vim-lastplace"}, -- jump to last edit position on reopen
  {"fladson/vim-kitty"},
  {"folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = function() require("todo-comments").setup() end},
  {"folke/which-key.nvim", config = function() require("which-key").setup() end},
  {"folke/zen-mode.nvim", config = function() require("plugins.folke_zen-mode").setup() end},
  {"jessarcher/vim-heritage"}, -- automatically create parent directories when writing file
  {"jose-elias-alvarez/null-ls.nvim"},
  {"jose-elias-alvarez/nvim-lsp-ts-utils"},
  {"jose-elias-alvarez/typescript.nvim", config = function() require("typescript").setup({}) end},
  {"jremmen/vim-ripgrep"},
  {"kosayoda/nvim-lightbulb", config = function() require("plugins.kosayoda_nvim-lightbulb").setup() end, lazy = true},
  {"lewis6991/gitsigns.nvim", dependencies = {"nvim-lua/plenary.nvim"}, config = function() require("gitsigns").setup() end, lazy = true}, -- Git
  {"LnL7/vim-nix", ft = {"nix"}},
  {"lukas-reineke/indent-blankline.nvim", config = function() require("plugins.lukas-reineke_indent-blankline").setup() end},
  {"mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },
  {"mhinz/vim-sayonara"}, -- smart quit buffer
  {"michaeljsmith/vim-indent-object"},
  {"ms-jpq/coq.artifacts", branch = "artifacts"}, -- TODO
  {"ms-jpq/coq.thirdparty", branch = "3p"}, -- TODO
  {"ms-jpq/coq_nvim", branch = "coq"}, -- TODO
  {"ntpeters/vim-better-whitespace"},
  {"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}}, config = function() require("plugins.nvim-telescope_telescope").setup() end}, -- TODO
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("plugins.nvim-treesitter_nvim-treesitter").setup() end},
  {"nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" }}, -- TODO
  {"Olical/conjure", ft = {"clojure", "fennel", "janet"}, dependencies = { 'tpope/vim-dispatch', 'clojure-vim/vim-jack-in', 'folke/which-key.nvim', }},
  {"pangloss/vim-javascript", ft = "javascript"},
  {"pbrisbin/vim-colors-off"},
  {"pierreglaser/folding-nvim"}, -- TODO
  {"prettier/vim-prettier", build = "yarn install --frozen-lockfile --production"},
  {"radenling/vim-dispatch-neovim", dependencies = {"tpope/vim-dispatch"}},
  {"rafalbromirski/vim-aurora"},
  {"rhysd/committia.vim", lazy = true}, -- Git commit
  {"romgrk/barbar.nvim", dependencies = {"lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons"}, init = function() vim.g.barbar_auto_setup = false end, opts = require('plugins.romgrk_barbar')},
  {"RRethy/nvim-treesitter-endwise", dependencies = "nvim-treesitter/nvim-treesitter", config = function() require("plugins.RRethy_nvim-treesitter-endwise").setup() end},
  {"ruanyl/vim-gh-line", event = "VeryLazy"}, -- browser open line
  {"sickill/vim-pasta"}, -- auto pasting indentation
  {"simrat39/symbols-outline.nvim"},
  {"sQVe/sort.nvim", cmd = 'Sort'},
  {"szw/vim-maximizer", config = function() vim.g.maximizer_set_default_mapping = false end, cmd = {"MaximizerToggle"}, lazy = true},
  {"thiagoalessio/rainbow_levels.vim"},
  {"tommcdo/vim-fugitive-blame-ext"}, -- statusbar commit message
  {"tpope/vim-bundler", ft = "ruby"},
  {"tpope/vim-commentary"},
  {"tpope/vim-dispatch", lazy = true},
  {"tpope/vim-eunuch", cmd = { "Cfind", "Chmod", "Clocate", "Delete", "Lfind", "Llocate", "Mkdir", "Move", "Remove", "Rename", "SudoEdit", "SudoWrite", "Wall", }, },
  {"tpope/vim-fugitive"}, -- Git
  {"tpope/vim-rails", ft = "ruby"},
  {"tpope/vim-repeat"}, -- dot repeat non-native commands
  {"tpope/vim-sleuth"}, -- indent autodetection
  {"tpope/vim-surround"},
  {"tpope/vim-unimpaired"},
  {"Tyilo/applescript.vim", ft = "applescript"},
  {"vim-test/vim-test"},
  {"windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup({}) end},
  {'kyazdani42/nvim-tree.lua', dependencies = {'kyazdani42/nvim-web-devicons'}, config = function() require("plugins.kyazdani42_nvim-tree").setup({}) end},
  {'neovim/nvim-lspconfig', config = function() require('user.lua')() end, },
}, {
    install = {
      colorscheme = { "aurora" },
    },
  })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "init.lua",
  callback = function()
    vim.keymap.set("n", "gh", function()
      local word_under_cursor = vim.fn.expand("<cWORD>")
      local repo = word_under_cursor:match("[\"']([^\"',]+)[\"']")
      if repo then
        os.execute("open https://github.com/" .. repo)
      end
    end)
  end
})

require("user.direnv")
require("user.docker")
require("user.filetype")
require("user.lua")
require("user.move_lines")
require("user.neovide")
require("user.open_url")
require("user.ruby")
require("user.text")
if vim.env.TMUX then require("user.tmux") end

-- window resize splits equal widths
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

-- nvim instance data share
vim.api.nvim_create_autocmd(
  {'CursorHold', 'TextYankPost', 'FocusGained', 'FocusLost',},
  {
    pattern = '*',
    command = "if exists(':rshada') | rshada | wshada | endif",
  }
)


vim.keymap.set("n", "<leader>n", function() vim.cmd("NvimTreeFindFileToggle") end)

vim.keymap.set("n", "<ESC>", function() vim.cmd("nohlsearch"); vim.cmd("echo") end)

vim.keymap.set("n", "<C-L>", function()
  vim.cmd("nohlsearch")
  if vim.fn.has("diff") == 1 then vim.cmd("diffupdate") end
  vim.cmd("<C-L>")
end)

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("edit #") end)

-- buffer next/prev
vim.keymap.set("n", "<leader>bn", function() vim.cmd("bnext") end)
vim.keymap.set("n", "<leader>bp", function() vim.cmd("bprev") end)

-- tmux style window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)

vim.keymap.set("n", "<leader>n", function() vim.cmd("NvimTreeFindFileToggle") end)

vim.keymap.set("n", "gp", "`[v`]")

-- visual indent
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<C-Right>", ">gv")
vim.keymap.set("v", "<C-Left>", "<gv")

vim.keymap.set("n", "<C-W>m", function() vim.cmd("MaximizerToggle!") end)
vim.keymap.set("n", "<leader>gm", function() vim.cmd("MaximizerToggle!") end)

vim.keymap.set('n', '<leader>gn', function() vim.cmd("set number!") end)

-- keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>u", OpenURL)

-- allow gf to open non-existent files
vim.keymap.set("n", "gf", function() vim.cmd("edit <cfile>") end)

vim.keymap.set("n", "<leader>q", function() vim.cmd("Sayonara!") end)

vim.keymap.set("n", "<leader>z", require("zen-mode").toggle)

vim.keymap.set("n", "<leader>gj", function() vim.cmd("SplitjoinJoin") end, {desc = "Join in a single line"})
vim.keymap.set("n", "<leader>gs", function() vim.cmd("SplitjoinSplit") end, {desc = "Split in a single line"})



-- yank restore cursor position
-- vim.keymap.set("v", "y", "ygv<Esc>")
vim.keymap.set("v", "y", function()
  return "my\"" .. vim.v.register .. "y`y"
end, { expr = true })

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local buf_map = function(bufnr, mode, lhs, rhs, opts) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {silent = true}) end
local on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {focusable = false, close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"}, border = "rounded", source = "always", prefix = " ", scope = "cursor"}
      vim.diagnostic.open_float(nil, opts)
    end
  })

  -- mapn('<Leader>e', function() vim.diagnostic.open_float() end) TODO
  -- vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts) # TODO

  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  buf_map(bufnr, "n", "gr", ":LspRename<CR>")
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
  buf_map(bufnr, "n", "K", ":LspHover<CR>")
  buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
  buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
  buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

  -- -- format on save
  -- if client.resolved_capabilities.document_formatting then
  --     vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  -- end
end

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    require("folding").on_attach()

    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)

    -- rename
    vim.api.nvim_set_keymap("n", "<leader>rn", "", {noremap = true, callback = vim.lsp.buf.rename})

    buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

    on_attach(client, bufnr)
  end
})

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint, -- null_ls.builtins.code_actions.eslint,
    null_ls.builtins.code_actions.eslint_d, -- faster
    -- null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.prettier_d_slim, -- faster
    null_ls.builtins.code_actions.gitsigns
  },
  on_attach = on_attach
})

local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = {
    noremap = true,
    silent = true,
  }

  buf_set_keymap("n", "gD", "lua vim.lsp.buf.declaration()", opts)
  buf_set_keymap("n", "gd", "lua vim.lsp.buf.definition()", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "lua vim.lsp.diagnostic.set_loclist()", opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and map buffer local keybindings when the language server attaches
local servers = {"solargraph"}
for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup({on_attach = on_attach, flags = {debounce_text_changes = 150}}) end

-- folding
vim.opt.foldenable = false
-- vim.opt.foldlevel = 99
-- set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))o
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars.fold = " "

-- -- use interactive shell
-- set shellcmdflag='-ic'

-- decreased for lsp code actions
vim.opt.updatetime = 100

-- -- highlight URLs
vim.api.nvim_exec([[syn match matchURL /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/ containedin=ALL]], false)
vim.api.nvim_set_hl(0, 'matchURL', {underline = true, fg = 'skyblue'})

-- use ripgrep for grep
if vim.fn.executable('rg') > 0 then
  vim.opt.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
  vim.opt.grepformat = vim.opt.grepformat ^ {'%f:%l:%c:%m'}
end

-- ctags
-- TODO setglobal tags-=./tags tags-=./tags; tags^=./tags; # https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L65

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'BufferLineFill', {bg = '#222222'})
    vim.api.nvim_set_hl(0, 'Comment', {italic = true, fg = '#777777'})
    vim.api.nvim_set_hl(0, 'EndOfBuffer', {bg = 'black', fg = 'black'})
    vim.api.nvim_set_hl(0, 'FoldColumn', {ctermbg = 'NONE', bg = 'black'})
    vim.api.nvim_set_hl(0, 'Folded', {bg = '#181818'})
    vim.api.nvim_set_hl(0, 'NonText', {fg = '#222222'})
    vim.api.nvim_set_hl(0, 'Normal', {ctermbg = 'NONE', bg = 'black'})
    vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', {bg = '#111111'})
    vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', {fg = '#333333'})
    vim.api.nvim_set_hl(0, 'NvimTreeNormal', {bg = '#111111'})
    vim.api.nvim_set_hl(0, 'NvimTreeStatusLine', {bg = 'black', fg = 'black'})
    vim.api.nvim_set_hl(0, 'NvimTreeStatusLineNC', {bg = 'black', fg = 'black'})
    vim.api.nvim_set_hl(0, 'Question', {ctermfg = 'gray', fg = '#444444'})
    vim.api.nvim_set_hl(0, 'SignColumn', {ctermbg = 'NONE', bg = 'black'})
    vim.api.nvim_set_hl(0, 'WinBar', {bg = 'black', fg = '#999999', bold = false, italic = true, underline = false, undercurl = false, strikethrough = false})
    vim.api.nvim_set_hl(0, 'ZenBg', {bg = 'black'})
    vim.api.nvim_set_hl(0, 'WinSeparator', {bg = 'black', fg = '#222222'})
  end
})
vim.cmd('colorscheme aurora')

-- fold with treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.api.nvim_create_user_command("PrettyPrintJSON", "%!jq", {})
vim.api.nvim_create_user_command("PrettyPrintXML", "!tidy -mi -xml -wrap 0 %", {})
vim.api.nvim_create_user_command("PrettyPrintHTML", "!tidy -mi -xml -wrap 0 %", {})

vim.api.nvim_create_user_command("CopyFullName", "let @+=expand('%')", {})
vim.api.nvim_create_user_command("CopyPath", "let @+=expand('%:h')", {})
vim.api.nvim_create_user_command("CopyFileName", "let @+=expand('%:t')", {})

function CopyPathAndLineNumber()
  local path = vim.fn.bufname()
  local line = vim.fn.line(".")
  local text = string.format("%s:%d", path, line)
  vim.fn.setreg("+", text)
end
vim.api.nvim_create_user_command("CopyPathAndLineNumber", "lua CopyPathAndLineNumber()", {nargs = 0})

-- window splits sizing stabilize text
vim.o.splitkeep = "screen"
-- vim.o.splitkeep = "topline"

vim.api.nvim_create_autocmd(
  { 'ModeChanged', 'InsertLeave'},
  {
    desc = "change cursor color on mode change",
    group = group,
    callback = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "i" then
        vim.api.nvim_set_hl(0, "CursorLineNr", {fg="#000000", bg="#ac3131", bold=true})
      elseif mode == "v" or mode == "V" or mode == "" then
        vim.api.nvim_set_hl(0, "CursorLineNr", {fg="#000000", bg="#d1d1d1", bold=true})
      else
        vim.api.nvim_set_hl(0, "CursorLineNr", {fg=init_color_fg, bg=init_color_bg, bold=true})
      end
    end,
  }
)

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {pattern = "*", callback = function() vim.highlight.on_yank({on_visual = true}) end})

vim.api.nvim_create_autocmd("BufEnter", {pattern = "*.ex", command = 'syn match Error "IO.puts\\|IO.inspect"'})
vim.api.nvim_create_autocmd("BufEnter", {pattern = "*.rb", command = 'syn match Error "binding.pry\\|debugger"'})
vim.api.nvim_create_autocmd("BufEnter", {pattern = {"*.js", "*.ts", "*.tsx"}, command = 'syn match Error "colsole.log"'})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  callback = function()
    vim.cmd("LspRestart")
  end,
})

--	-- Setup nvim-cmp.
--	local cmp = require'cmp'

--	cmp.setup({
--		snippet = {
--	-- REQUIRED - you must specify a snippet engine
--	expand = function(args)
--		-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--	end,
--		},
--		mapping = {
--	['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--	['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--	['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--	['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--	['<C-e>'] = cmp.mapping({
--		i = cmp.mapping.abort(),
--		c = cmp.mapping.close(),
--	}),
--	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--		},
--		sources = cmp.config.sources({
--	{ name = 'nvim_lsp' },
--	{ name = 'buffer' },
--		})
--	})

--	-- Set configuration for specific filetype.
--	cmp.setup.filetype('gitcommit', {
--		sources = cmp.config.sources({
--	{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--		}, {
--	{ name = 'buffer' },
--		})
--	})

--	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--	cmp.setup.cmdline('/', {
--		sources = {
--	{ name = 'buffer' }
--		}
--	})

--	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--	cmp.setup.cmdline(':', {
--		sources = cmp.config.sources({
--	{ name = 'path' }
--		}, {
--	{ name = 'cmdline' }
--		})
--	})

--	-- Setup lspconfig.
--	local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--	require('lspconfig')['solargraph'].setup {
--		capabilities = capabilities
--	}
--

-- cmp.setup {
--     -- As currently, i am not using any snippet manager, thus disabled it.
--     -- snippet = {
--     --   expand = function(args)
--     --     require("luasnip").lsp_expand(args.body)
--     --   end,
--     -- },

--     mapping = {
--         ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-e>"] = cmp.mapping.close(),
--         ["<c-y>"] = cmp.mapping.confirm {
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true
--         }
--     },
--     formatting = {
--         format = lspkind.cmp_format {
--             with_text = true,
--             menu = {buffer = "[buf]", nvim_lsp = "[LSP]", path = "[path]"}
--         }
--     },

--     sources = {
--         {name = "nvim_lsp"}, {name = "path"},
--         {name = "buffer", keyword_length = 5}
--     },
--     experimental = {ghost_text = true}
-- }
--
-- -- Unfold all folds when opening a file TODO
-- {
--   event = { 'BufReadPost', 'FileReadPost' },
--   pattern = { '*' },
--   command = 'normal zR',
-- },

-- print debugging
function _G.put(...) local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
end

vim.opt.autoindent = true
vim.opt.smartindent = true -- TODO

local indent = 2
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.expandtab = true
vim.opt.shiftround = true -- round indent for < and >

vim.opt.infercase = true

vim.opt.hidden = true

vim.opt.showbreak = "↳ "

vim.opt.title = true

vim.opt.ruler = false

-- install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd('packadd packer.nvim')
end

-- shorter key mappings
local function map(mode, shortcut, command, opts)
    vim.api.nvim_set_keymap(mode, shortcut, command, opts or { noremap = true, silent = true })
end

-- local function nmap(shortcut, command)
--   map('n', shortcut, command)
-- end

-- local function imap(shortcut, command)
--   map('i', shortcut, command)
-- end

-- reload config
map('n', '<leader>sc', ':source $MYVIMRC<CR>')

-- reopen previous buffer
map('n', '<leader><leader>', ':edit #<CR>')

-- -- alternative escapes
-- map('i', 'jk', '<ESC>', { noremap = true, silent = true })
-- map('i', 'kj', '<ESC>', { noremap = true, silent = true })
-- map('i', 'jj', '<ESC>', { noremap = true, silent = true })
-- map('i', 'kk', '<ESC>', { noremap = true, silent = true })

-- TODO <cmd>->:
-- visual indent with <Tab>
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

-- remove any search highlighting.
map('n', '<ESC>', ':nohlsearch<Bar>echo<CR>')
-- -- redraw the screen and removes any search highlighting.
-- nnoremap <silent> <C-L> :nohlsearch<CR> =has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
map('n', '<C-l>', ':nohlsearch<Cr><C-l>')

-- buffer next/prev
map('v', '<leader>bn', ':bnext')
map('v', '<leader>bp', ':bprev')

-- reload config
vim.api.nvim_create_user_command('ConfReload', 'so $MYVIMRC', { nargs = 0 })

-- " command mode movement
-- cnoremap <C-a> <Home>
-- cnoremap <C-e> <End>
-- cnoremap <C-p> <Up>
-- cnoremap <C-n> <Down>
-- cnoremap <C-b> <Left>
-- cnoremap <C-f> <Right>
-- cnoremap <M-b> <S-Left>
-- cnoremap <M-f> <S-Right>

-- performance
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- resize splits to equal widths on window resize
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd.wincmd("=")
  end,
})

-- filename in window titlebars
vim.cmd('set winbar=%f | set laststatus=3 | hi WinBar guibg=#444444')

-- reselect pasted text
vim.cmd("nnoremap gp `[v`]")

-- use visual lines with word wrap
--map('n', 'k', "v:count == 0 ? 'gk' : 'k'")
--map('n', 'j', "v:count == 0 ? 'gj' : 'j'")

-- GUI
vim.opt.guifont = 'JetBrainsMono Nerd Font Mono:h13'
-- vim.opt.guifont = 'Hack Nerd Font:h13'

-- clipboard
-- vim.opt.clipboard = 'unnamed'
vim.opt.clipboard = 'unnamedplus'

-- performance ? TODO
vim.opt.lazyredraw = true

-- popup menu transparency
vim.opt.pumblend = 25

-- invert new split locations
vim.opt.splitbelow = true
vim.opt.splitright = true

-- window navigation
map("n", "<c-h>", "<c-w>h") -- tmux style navigation
map("n", "<c-j>", "<c-w>j") -- tmux style navigation
map("n", "<c-k>", "<c-w>k") -- tmux style navigation
map("n", "<c-l>", "<c-w>l") -- tmux style navigation

-- command-line completion mode
vim.opt.wildmode = 'list:longest'
-- vim.opt.wildmode = 'longest:full,full' TODO

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

-- completion
vim.opt.completeopt = 'menu,menuone,noselect'

-- hide startup message
vim.opt.shortmess:append { I = true }

-- include dashes in keywords (lisp case)
vim.opt.iskeyword:append "-"

-- extend path to look into all sub-folders
vim.opt.path:append { '**' }

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.directory = "/tmp" -- don't save swap files in file dir

vim.opt.list = true -- show hidden chars

-- 24-bit colors
vim.opt.termguicolors = true

-- keep the cursor in place while joining lines
map('n', 'J', 'mzJ`z')

vim.opt.scrolloff = 4 -- pad scroll

-- Neovide
vim.g.neovide_transparency = 0.9
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_cursor_vfx_mode = "ripple"

-- have packer use a popup window
require 'packer'.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

require 'packer'.startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- REPL
        use 'jpalardy/vim-slime'

        -- Clojure
        use {
            'Olical/conjure',
            tag = 'v4.3.1',
            config = function()
                -- let g:conjure#log#hud#enabled = 0
            end
        }

        -- -- show whenever a code action is available
        -- use {
        --     'kosayoda/nvim-lightbulb',
        --     config = function()
        --         require('nvim-lightbulb').setup({autocmd = {enabled = true}})
        --     end
        -- }

        -- TODO
        -- LSP-powered folding
        use 'pierreglaser/folding-nvim'

        use 'neovim/nvim-lspconfig'

        use 'jose-elias-alvarez/null-ls.nvim'

        -- -- faster startup time
        -- use {
        --     'nathom/filetype.nvim',
        --     config = function()
        --         require("filetype").setup({
        --             overrides = {
        --                 complex = {
        --                     ["*.json.jbuilder"] = "ruby",
        --                 },
        --             }
        --         })
        --     end
        -- }

        -- -- TypeScript LSP
        -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

        -- better git commit
        use 'rhysd/committia.vim'

        -- -- TypeScript TODO
        -- use {
        --     'jose-elias-alvarez/typescript.nvim',
        --     config = function()
        --         require("typescript").setup()
        --     end
        -- }

        -- mappings
        use 'tpope/vim-unimpaired'

        -- indent level colors
        use 'thiagoalessio/rainbow_levels.vim'

        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                -- let g:indentLine_color_term = 239
                require("ibl").setup {
                    exclude = {
                        filetypes = { 'help', 'packer' },
                        buftypes = { 'terminal', 'nofile' }
                    },
                    indent = {
                      char = "▎"
                      -- char = '┊'
                    }
                }
            end
        }

        -- scope in statusline
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter"
        }

        -- move lines up/down
        use 'matze/vim-move'

        -- performance
        use 'antoinemadec/FixCursorHold.nvim'

        -- display commit message in statusbar in fugitiveblame buffer
        use 'tommcdo/vim-fugitive-blame-ext'

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require 'nvim-treesitter.configs'.setup {
                    ensure_installed = "all",
                    highlight = {
                        enable = true
                    },
                    context_commentstring = { enable = true },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "gnn",
                            node_incremental = "grn",
                            scope_incremental = "grc",
                            node_decremental = "grm",
                        },
                    },
                    indent = {
                        enable = true
                    }
                }

                -- fold with treesitter
                vim.opt.foldmethod = 'expr'
                vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            end
        }

        -- delete, mkdir, etc.
        use 'tpope/vim-eunuch'

        -- Nix
        use 'LnL7/vim-nix'

        use {
            "folke/which-key.nvim",
            config = function() require("which-key").setup {} end
        }

        -- main one
        use { 'ms-jpq/coq_nvim', branch = 'coq' }
        -- 9000+ Snippets
        use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
        use { 'ms-jpq/coq.thirdparty', branch = '3p' }
        -- - shell repl
        -- - nvim lua api
        -- - scientific calculator
        -- - comment banner
        -- - etc

        -- automatically create parent directories when writing file
        use 'jessarcher/vim-heritage'

        -- smart quit buffer
        use 'mhinz/vim-sayonara'

        -- dot repeat for non-native commands
        use 'tpope/vim-repeat'

        -- adjust indentation when pasting
        use 'sickill/vim-pasta'

        -- indent autodetection
        use {
            'tpope/vim-sleuth',
            setup = function()
                vim.g.sleuth_default_width = 2
            end
        }

        -- seamless vim/tmux pane navigation
        use 'christoomey/vim-tmux-navigator'

        -- jump to last edit position on reopen
        use 'farmergreg/vim-lastplace'

        -- chdir to root
        use 'airblade/vim-rooter'

        -- treesitter spell checking
        use {
            'lewis6991/spellsitter.nvim',
            config = function()
                require('spellsitter').setup()
            end
        }

        use 'vim-test/vim-test'

        -- Git change markers
        use {
            'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                vim.opt.signcolumn = 'yes'

                require('gitsigns').setup()
            end
        }

        use 'simrat39/symbols-outline.nvim'

        -- git blame in virtual text
        use {
            'f-person/git-blame.nvim',
            setup = function()
                vim.g.gitblame_highlight_group = "Question"
            end
        }

        -- window splits sizing
        use {
            'luukvbaal/stabilize.nvim',
            config = function() require("stabilize").setup() end
        }

        -- gS to convert between single/multi-line
        use 'AndrewRadev/splitjoin.vim'

        -- buffers as tabs
        use {
            'akinsho/bufferline.nvim',
            tag = '*',
            config = function()
                require('bufferline').setup({
                    options = {
                        always_show_bufferline = false,
                        enforce_regular_tabs = true
                    }
                })
            end
        }

        -- close HTML tags
        use 'alvan/vim-closetag'

        -- use {
        --   'romgrk/barbar.nvim',
        --   requires = {'kyazdani42/nvim-web-devicons'}
        -- }

        -- allow embedded syntax highlighting for lua, python, ruby
        -- vim.g.vimsyn_embed = 'lPr'

        -- dark
        use 'rafalbromirski/vim-aurora'
        use { 'challenger-deep-theme/vim', as = 'challenger-deep' }
        -- use 'tek256/simple-dark'
        -- use 'ackyshake/spacegray.vim'
        -- use 'bluz71/vim-nightfly-guicolors'
        -- use 'DavidBachmann/vim-punk-colorscheme'
        -- use { 'kyoz/purify', rtp = 'vim' }
        -- use 'shaunsingh/moonlight.nvim'
        -- -- monochrome
        -- use 'pgdouyon/vim-yin-yang'
        -- use 'felipevolpone/mono-theme'
        -- use 'pbrisbin/vim-colors-off'

        use 'othree/javascript-libraries-syntax.vim'
        use 'pangloss/vim-javascript'

        -- LiveScript
        use 'gkz/vim-ls'

        -- maximize windows
        use 'szw/vim-maximizer'

        -- Ripgrep
        use 'jremmen/vim-ripgrep'

        -- file explorer
        use {
            "kyazdani42/nvim-tree.lua",
            -- requires = 'ryanoasis/vim-devicons',
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
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
        }

        use {
            'andymass/vim-matchup',
            requires = 'nvim-treesitter/nvim-treesitter',
            config = function()
                require('nvim-treesitter.configs').setup {
                    matchup = { enable = true }
                }
            end
        }

        use {
            'nvim-telescope/telescope.nvim',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

        -- motions for block endings
        use {
            'RRethy/nvim-treesitter-endwise',
            requires = 'nvim-treesitter/nvim-treesitter',
            config = function()
                require('nvim-treesitter.configs').setup {
                    endwise = { enable = true }
                }
            end
        }

        use {
            'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup {}
            end
        }

        -- Rails
        use { 'tpope/vim-rails', ft = 'ruby' }

        -- Ruby
        use 'tpope/vim-bundler'

        -- async background commands
        use 'tpope/vim-dispatch'

        use 'nvim-treesitter/nvim-treesitter-textobjects'

        -- -- TODO
        -- use {
        --     "folke/todo-comments.nvim",
        --     requires = "nvim-lua/plenary.nvim",
        --     config = function()
        --         require("todo-comments").setup()
        --     end
        -- }

        -- indent markers
        -- Plug 'Yggdroot/indentLine'

        -- minimal UI
        use {
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup {
                    backdrop = 1,
                    plugins = {
                      tmux = { enabled = true }
                    }
                }
            end
        }

        -- indent text objects
        use 'michaeljsmith/vim-indent-object'

        -- CoffeeScript
        use 'kchmck/vim-coffee-script'

        -- whitespace
        use 'ntpeters/vim-better-whitespace'

        -- move with hints
        use 'ggandor/lightspeed.nvim'

        -- comment toggle
        use 'tpope/vim-commentary'

        -- Git
        use 'tpope/vim-fugitive'

        -- surround
        use 'tpope/vim-surround'

        -- formatting
        use {
            'prettier/vim-prettier',
            branch = 'release/0.x',
            run = 'yarn install --frozen-lockfile --production'
        }

        -- Git change markers
        -- Plug 'airblade/vim-gitgutter'

        -- fuzzy search
        use 'cloudhead/neovim-fuzzy'

        -- fuzzy search
        use {
            'junegunn/fzf',
            run = vim.fn['fzf#install'],
            requires = "junegunn/fzf.vim"
        }

        -- Plug 'hrsh7th/cmp-nvim-lsp'
        -- Plug 'hrsh7th/cmp-buffer'
        -- Plug 'hrsh7th/cmp-path'
        -- Plug 'hrsh7th/cmp-cmdline'
        -- Plug 'hrsh7th/nvim-cmp'

        -- " completion
        -- Plug 'neoclide/coc.nvim', {'branch': 'release'}
        -- " coc.nvim
        -- " pip install pynvim
        -- let g:coc_global_extensions = ['coc-css', 'coc-json', 'coc-yaml', 'coc-tabnine', 'coc-html']

        -- open current line in web source browser
        -- blob: <leader>gh
        -- blame: <leader>gb
        use 'ruanyl/vim-gh-line'

        use {
            'nvim-lualine/lualine.nvim',
            -- requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                require('lualine').setup({ options = { icons_enabled = false } })
                -- options = { theme = 'challenger_deep' }
            end
        }

        -- scope in statusline
        local gps = require("nvim-gps")
        require("lualine").setup({
            sections = {
                lualine_c = {
                    { gps.get_location, cond = gps.is_available },
                }
            }
        })

        -- -- Automatically set up your configuration after cloning packer.nvim
        -- -- Put this at the end after all plugins
        -- if packer_bootstrap then
        --	require('packer').sync()
        -- end

        local lspconfig = require("lspconfig")
        local null_ls = require("null-ls")
        local buf_map = function(bufnr, mode, lhs, rhs, opts)
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs,
                opts or { silent = true })
        end
        local on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("CursorHold", {
              buffer = bufnr,
              callback = function()
                local opts = {
                  focusable = false,
                  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                  border = 'rounded',
                  source = 'always',
                  prefix = ' ',
                  scope = 'cursor',
                }
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
            buf_map(bufnr, "n", "gd", ":LspDef<CR>")
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
                require('folding').on_attach()

                client.resolved_capabilities.document_formatting = false
                client.resolved_capabilities.document_range_formatting = false

                local ts_utils = require("nvim-lsp-ts-utils")
                ts_utils.setup({})
                ts_utils.setup_client(client)

                -- rename
                vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })

                buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
                buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
                buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

                on_attach(client, bufnr)
            end
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.eslint,

                -- null_ls.builtins.code_actions.eslint,
                null_ls.builtins.code_actions.eslint_d, -- faster

                -- null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.prettier_d_slim, -- faster

                null_ls.builtins.code_actions.gitsigns
            },
            on_attach = on_attach
        })

        local nvim_lsp = require('lspconfig')

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            local function buf_set_option(...)
                vim.api.nvim_buf_set_option(bufnr, ...)
            end

            -- Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap = true, silent = true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', 'lua vim.lsp.buf.declaration()', opts)
            buf_set_keymap('n', 'gd', 'lua vim.lsp.buf.definition()', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', 'lua vim.lsp.diagnostic.set_loclist()', opts)
            buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = { "solargraph" }
        for _, lsp in ipairs(servers) do
            nvim_lsp[lsp].setup {
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 }
            }
        end

        -- Nix LSP
        require 'lspconfig'.rnix.setup {}

        -- Ruby LSP
        require 'lspconfig'.solargraph.setup {}

        -- -- Lua LSP
        -- require 'lspconfig'.sumneko_lua.setup {
        --     settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
        -- }

        -- -- TODO fzf fuzzy find
        -- nnoremap <silent> <leader>p :FzfGFiles<CR>
        -- nnoremap <silent> <leader>b :FzfBuffers<CR>

        -- disable folding
        vim.opt.foldenable = false

        -- vim.opt.foldlevel = 99
        -- set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))o
        vim.opt.foldtext =
        [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
        vim.opt.fillchars = { fold = " " }

        -- allow gf to open non-existent files
        map('n', 'gf', ':edit <cfile><CR>')

        -- text files
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'txt',
            callback = function()
                vim.opt.foldcolumn = '1'

                vim.bo.expandtab = false
                vim.bo.tabstop = 4;
                vim.bo.shiftwidth = 4

                vim.o.foldminlines = 0
                vim.o.foldmethod = 'indent'

                vim.cmd('RainbowLevelsOn')
            end
        })

        require 'nvim-treesitter.configs'.setup {
            textobjects = {
                -- select inside/outside functions/classes
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner"
                    }
                },
                -- swap the order of parameters
                swap = {
                    enable = true,
                    swap_next = {
                        ["g>>"] = "@parameter.inner",
                        ["g>f"] = "@function.outer"
                    },
                    swap_previous = {
                        ["g<<"] = "@parameter.inner",
                        ["g<f"] = "@function.outer"
                    }
                }
            }
        }

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

        -- function! FZF() abort
        --		 let l:tempname = tempname()
        --		 " fzf | awk '{ print $1":1:0" }' > file
        --		 execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
        --		 try
        --		 execute 'cfile ' . l:tempname
        --		 redraw!
        --		 finally
        --		 call delete(l:tempname)
        --		 endtry
        -- endfunction

        -- " :Files
        -- command! -nargs=* Files call FZF()

        -- function! Foo(args) abort
        --		 let l:tempname = tempname()
        --		 let l:pattern = '.'
        --		 if len(a:args) > 0
        --		 let l:pattern = a:args
        --		 endif
        --		 " rg --vimgrep <pattern> | fzf -m > file
        --		 execute 'silent !rg --vimgrep ''' . l:pattern . ''' | fzf -m > ' . fnameescape(l:tempname)
        --		 try
        --		 execute 'cfile ' . l:tempname
        --		 redraw!
        --		 finally
        --		 call delete(l:tempname)
        --		 endtry
        -- endfunction

        -- " :Rg [pattern]
        -- command! -nargs=* Foo call Foo(<q-args>)

        -- " \fs
        -- nnoremap <leader>fs :Rg<cr>

        -- allow gf to open non-existent files
        -- map gf :edit <cfile><cr>

        -- nnoremap <leader>q <cmd>Sayonara!<cr>

        require('telescope').load_extension('fzf')

        require('telescope').setup { pickers = { find_files = { theme = "ivy" } } }

        -- highlight on yank
        vim.api.nvim_create_autocmd('TextYankPost', {
          pattern = '*',
          callback = function()
            vim.highlight.on_yank({ on_visual = true })
            -- vim.highlight.on_yank({timeout = 200, higroup = 'Visual'})
          end
        })

        -- open file with cursor on last position
        vim.api.nvim_create_autocmd('BufReadPost', {
          callback = function ()
            local mark = vim.api.nvim_buf_get_mark(0, [["]])
            if 0 < mark[1] and mark[1] <= vim.api.nvim_buf_line_count(0) then
              vim.api.nvim_win_set_cursor(0, mark)
            end
          end
        })

        -- -- use interactive shell
        -- set shellcmdflag='-ic'

        -- let g:fzf_command_prefix = 'Fzf'

        map("n", "<leader>n", ":NvimTreeFindFileToggle<CR>")
        -- -- let NERDTreeShowHidden=1
        -- -- let g:NERDTreeIgnore = ['^node_modules$']
        -- -- nmap <leader>n :NERDTreeToggle<CR>
        -- -- nmap <leader>j :NERDTreeFind<CR>
        -- -- autocmd FileType nerdtree setlocal signcolumn=no " git gutter

        -- decreased for lsp code actions
        vim.opt.updatetime = 100

        -- -- highlight URLs
        -- vim.cmd('syn match matchURL /http[s]\?:\/\/[[:alnum:]%\/_#.-]*/')
        -- vim.cmd('hi matchURL ctermfg=14 guifg=blue')

        map('n', '<leader>ff', ':Telescope find_files<CR>')
        map('n', '<leader>fg', ':Telescope live_grep<CR>')
        map('n', '<leader>fb', ':Telescope buffers<CR>')
        map('n', '<leader>fh', ':Telescope help_tags<CR>')

        -- vim.cmd([[
        --	 augroup packer_user_config
        --	 autocmd!
        --	 autocmd BufWritePost $MYVIMRC source $MYVIMRC | PackerCompile
        --	 augroup end
        -- ]])

    end,

    config = {
      max_jobs = 10, -- fix updates hanging with too many plugins
      autoremove = true
    }
})

-- if $TERM_PROGRAM
vim.cmd('hi Normal ctermbg=NONE guibg=NONE')
vim.cmd('hi LineNr ctermbg=NONE guibg=NONE')
vim.cmd('hi SignColumn ctermbg=NONE guibg=NONE')

-- use ripgrep for grep
if vim.fn.executable("rg") > 0 then
    vim.opt.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
    vim.opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
end

-- ctags
-- TODO setglobal tags-=./tags tags-=./tags; tags^=./tags; # https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L65

-- -- Make visual yanks place the cursor back where started
-- -- map("v", "y", "ygv<Esc>")
-- -- https://ddrscott.github.io/blog/2016/yank-without-jank/
-- vim.cmd('*vnoremap <expr>y "my\"" . v:register . "y`y"')

-- -- force reload modules, bypass module caching
-- require("plenary.reload").reload_module("<module>", true)
--  package.loaded['package-name-here'] = nil then require again and it'll load the new version
--

function globalstatus()
    vim.opt.laststatus = 3
    vim.cmd('highlight WinSeparator ctermbg=NONE guibg=NONE')
    vim.cmd('highlight WinSeparator ctermfg=gray guifg=#444444')
end

globalstatus()

-- global statusline
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        globalstatus()

        -- local set_hl = {
        --     BufferLineFill = { bg = '#222222' }, -- bufferline
        --     Comment = { italic = true, fg = '#69697c' },
        --     CursorLine = { bg = '#ff0000' },
        --     EndOfBuffer = { ctermbg = 'NONE', bg = 'NONE' },
        --     FoldColumn = { ctermbg = 'NONE', bg = 'NONE' },
        --     Folded = { bg = '#181818', fg = 'NONE' },
        --     LineNr = { ctermbg = 'NONE', bg = 'NONE' },
        --     NonText = { ctermfg = 'red'},
        --     Normal = { ctermbg = 'NONE', bg = 'NONE' },
        --     Question = { ctermfg = 'gray', fg = '#444444' },
        --     SignColumn = { ctermbg = 'NONE', bg = 'NONE' },
        --     WinBar = { bg = '#222222', fg = '#aaaaaa' },
        -- }
        -- for k, v in pairs(set_hl) do
        --     vim.api.nvim_set_hl(0, k, v)
        -- end

        vim.cmd('hi Question ctermfg=gray guifg=#444444')

        vim.cmd('hi Folded guibg=#181818 guifg=NONE')

        vim.cmd('hi NonText ctermfg=red')

        vim.cmd('hi Normal ctermbg=NONE guibg=NONE')

        vim.cmd('hi LineNr ctermbg=NONE guibg=NONE')
        vim.cmd('hi SignColumn ctermbg=NONE guibg=NONE')
        vim.cmd('hi FoldColumn ctermbg=NONE guibg=NONE')

        vim.cmd('hi EndOfBuffer ctermbg=NONE guibg=NONE')

        -- bufferline
        vim.cmd('hi BufferLineFill guibg=#222222')

        vim.cmd('hi Comment cterm=italic gui=italic')
    end
})
vim.cmd('colorscheme aurora')

require 'avo-ruby'
require 'avo-docker'
-- require 'avo-tmux'

vim.opt.fillchars = {
  vert = "│", -- vertical window separators
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}

-- go to the github repo of plugins
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'init.lua',
    callback = function ()
        vim.keymap.set('n', 'gh', function()
            -- strip ' and , from WORD under cursor
            local repo = vim.fn.substitute(vim.fn.expand('<cWORD>'), "[',]", '', 'g')
            os.execute('open https://github.com/' .. repo)
        end)
    end
})

-- scratchpad
vim.api.nvim_create_user_command('Scratch', function()
    vim.cmd('execute "new "')
    vim.opt_local.buftype = 'nofile'
    vim.opt_local.bufhidden = 'hide'
    vim.opt_local.swapfile = false
    vim.cmd('file scratch')
    vim.cmd('startinsert')
end, {})

-- compile packer after changing file
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = vim.fn.stdpath('config') .. '/**/*.lua',
    command = 'source <afile>'
})

-- maintain aligment after folding TODO
-- local indent_level = fn.indent(vim.v.foldstart)
-- local indent = fn['repeat'](' ', indent_level)
vim.cmd([[
    function! MyFoldText()
        let indent = indent(v:foldstart) - &sw
        return repeat(' ', indent) . "+" . repeat('-', &sw-2) . ' ' . trim(getline(v:foldstart))
    endfunction

    set foldtext=MyFoldText()
]])

vim.cmd([[
    function! GetAndSource(url)
      execute '!curl ' . a:url . ' -o tmp.vim'
      source tmp.vim
      execute '!rm tmp.vim'
    endfunction

    command! -nargs=1 GS call GetAndSource(<f-args>)
]])

-- literal search
vim.cmd([[
    command! -nargs=1 Search :let @/='\V' . escape(<q-args>, '\\') | normal! n
]])

vim.diagnostic.config {
  virtual_text = false, -- disable diagnostics virtual text
  signs = true,
  severity_sort = true,
}

vim.filetype.add {
    filename = {
        ['.envrc'] = 'bash',
    },
}

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '.envrc',
    callback = function()
        vim.bo.filetype = "bash"
    end
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '.envrc',
    callback = function()
        if vim.fn.executable 'direnv' then
            vim.cmd [[ silent !direnv allow %]]
        end
    end,
})

-- when editing a file, always jump to the last known cursor position.
-- don't do it for git commit messages
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
        local ft = vim.bo.filetype
        local line = vim.fn.line

        local not_in_event_handler = line '\'"' > 0 and line '\'"' <= line '$'

        -- not vim.regex([[commit\|rebase]]):match_str(vim.bo.filetype) TODO

        if not (ft == 'gitcommit') and not_in_event_handler then
            vim.fn.execute 'normal g`"'
        end
    end,
})

-- -- Unfold all folds when opening a file TODO
-- {
--   event = { 'BufReadPost', 'FileReadPost' },
--   pattern = { '*' },
--   command = 'normal zR',
-- },

-- -- share data between nvim instances (registers etc) TODO
-- augroup('Shada', {
--   {
--     event = { 'CursorHold', 'TextYankPost', 'FocusGained', 'FocusLost' },
--     pattern = { '*' },
--     command = "if exists(':rshada') | rshada | wshada | endif",
--   },
-- })

-- TODO firenvim
-- -- augroup('Firenvim', {
--   {
--     event = { 'BufEnter' },
--     pattern = { 'github.com_*.txt' },
--     command = 'set filetype=markdown',
--   },
-- })

-- TODO spelling
-- -- automatic spell check for some file types
-- augroup('SetSpell', {
--   {
--     event = { 'BufRead', 'BufNewFile' },
--     pattern = { '*.txt', '*.md', '*.tex' },
--     command = 'setlocal spell',
--   },
--   {
--     event = { 'FileType' },
--     pattern = { 'gitcommit' },
--     command = 'setlocal spell',
--   },
-- })

vim.api.nvim_create_user_command('PrettyPrintJSON', '%!jq', {})
vim.api.nvim_create_user_command('PrettyPrintXML', '!tidy -mi -xml -wrap 0 %', {})
vim.api.nvim_create_user_command('PrettyPrintHTML', '!tidy -mi -xml -wrap 0 %', {})
vim.api.nvim_create_user_command('CopyFullName', "let @+=expand('%')", {})
vim.api.nvim_create_user_command('CopyPath', "let @+=expand('%:h')", {})
vim.api.nvim_create_user_command('CopyFileName', "let @+=expand('%:t')", {})

local keymaps = {
  ["n"] = {
    ["<c-j>"] = ":m .+1<CR>==",
    ["<c-k>"] = ":m .-2<CR>==",
  },
  ["i"] = {
    ["<c-j>"] = "<Esc>:m .+1<CR>==gi",
    ["<c-k>"] = "<Esc>:m .-2<CR>==gi",
  },
  ["v"] = {
    ["<c-j>"] = ":m '>+1<CR>gv=gv",
    ["<c-k>"] = ":m '<-2<CR>gv=gv",
  }
}

for mode, bindings in pairs(keymaps) do
  for key, cmd in pairs(bindings) do
    vim.api.nvim_set_keymap(mode, key, cmd, {silent = true})
  end
end

-- window splits sizing stabilize text
vim.o.splitkeep = "screen"

function CopyPathAndLineNumber()
  local path = vim.fn.bufname()
  local line = vim.fn.line(".")
  local text = string.format("%s:%d", path, line)
  vim.fn.setreg("+", text)
end
vim.api.nvim_create_user_command('CopyPathAndLineNumber', 'lua CopyPathAndLineNumber()', { nargs = 0 })

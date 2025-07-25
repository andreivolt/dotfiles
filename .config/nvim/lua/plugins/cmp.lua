return {
  'hrsh7th/nvim-cmp',
  event = {
    "CmdlineEnter",
    "InsertEnter",
  },
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'uga-rosa/cmp-dictionary',
    -- 'hrsh7th/cmp-emoji',
    'saadparwaiz1/cmp_luasnip',
    'petertriho/cmp-git',
    -- 'andersevenrud/cmp-tmux',
    -- 'onsails/lspkind.nvim',
  },
  init = function()
    local cmp = require('cmp')

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
      callback = function()
        local file_size_limit = 100 * 1024
        local file_size = vim.fn.getfsize(vim.fn.expand('%:p'))
        cmp.setup.buffer({
          enabled = (file_size <= file_size_limit) and true or false,
        })
      end,
    })
  end,
  config = function()
    local cmp = require('cmp')
    local luasnip = require("luasnip")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      -- TODO
      -- completion = {
      --   autocomplete = false,
      -- },

      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
          -- vim.snippet.expand(args.body) -- TODO
        end,
      },

      window = {
        completion = {
          border = globals.border_chars,
          winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
        },
        documentation = {
          border = globals.border_chars,
          winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
        }
      },

      mapping = cmp.mapping.preset.insert({
        -- ["<CR>"] = cmp.mapping({
        --   i = function(fallback)
        --     if cmp.visible() and cmp.get_active_entry() then
        --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        --     else
        --       fallback()
        --     end
        --   end,
        --   s = cmp.mapping.confirm({ select = true }),
        --   c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        -- }),

        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end),
        ["<C-k>"] = cmp.mapping(function(callback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = "buffer",  keyword_length = 5 },
        -- { name = 'tmux', option = { all_panes = true } } -- TODO
      }),
      experimental = {
        ghost_text = true,
      }
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        {
          name = "path",
          option = {
            get_cwd = function()
              local line = vim.fn.getcmdline()
              if line:match('^%s*!') then
                return nil -- Disable for shell commands
              end
              return vim.fn.getcwd()
            end
          }
        }
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { '!*' }
          }
        }
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
      enabled = function()
        local line = vim.fn.getcmdline()
        return not line:match('^%s*!')
      end
    })

    -- cmp.setup.cmdline("/", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = "buffer" }
    --   }
    -- })

    cmp.setup.cmdline('/', {
      mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "c", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "c", "s" }),
      },
      sources = {
        { name = 'buffer' }
      }
    })

    -- cmp.setup.filetype('gitcommit', {
    --   sources = cmp.config.sources({
    --     { name = 'cmp_git' },
    --     { name = 'buffer' }
    --   })
    -- })

    -- cmp.setup.filetype({'markdown', 'text',}, {
    --   sources = {
    --     { name = "dictionary", keyword_length = 2 },
    --     { name = 'buffer' }
    --   }
    -- })

    -- require("cmp_dictionary").setup({
    --   paths = { "/usr/share/dict/words" },
    --   exact_length = 2,
    --   first_case_insensitive = true,
    --   document = {
    --     enable = true,
    --     command = { "wn", "${label}", "-over" },
    --   },
    -- })
  end,
}

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig')['solargraph'].setup {
--   capabilities = capabilities
-- }

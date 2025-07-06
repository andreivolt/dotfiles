return {
  "neovim/nvim-lspconfig",
  dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- { 'j-hui/fidget.nvim', opts = {} },
      -- { 'folke/neodev.nvim', opts = {} },
    },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- TODO: conflicts with tmux navigation
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    require("mason").setup()
    require("mason-lspconfig").setup()

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- require('mason-lspconfig').setup {
    --   handlers = {
    --     function(server_name)
    --       local server = servers[server_name] or {}
    --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
    --       require('lspconfig')[server_name].setup(server)
    --     end,
    --   },
    -- }

    -- Check if running on Termux
    local is_termux = vim.fn.isdirectory('/data/data/com.termux') == 1

    local config = {
      handlers = {
        -- Default handler for all servers
        function(server_name)
          require('lspconfig')[server_name].setup({ capabilities = capabilities })
        end,
      }
    }

    -- Only auto-install servers if not on Termux
    if not is_termux then
      config.ensure_installed = {
        'bashls',
        'clojure_lsp',
        'lua_ls',
        -- 'nil_ls',
        'pyright',
        'rust_analyzer',
        'ruby_lsp',
        'ts_ls',
        -- 'gopls',
      }
    end

    require('mason-lspconfig').setup(config)
  end,
  event = "VeryLazy"
}

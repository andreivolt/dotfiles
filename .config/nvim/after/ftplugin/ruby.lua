-- Ruby LSP setup for .rb files
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Only setup if not already running
if not lspconfig.ruby_lsp.manager then
  lspconfig.ruby_lsp.setup({
    capabilities = capabilities,
    cmd = { "ruby-lsp" },
    root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
    init_options = {
      formatter = "auto",
    },
  })
end

-- Start the LSP for this buffer
vim.cmd("LspStart ruby_lsp")
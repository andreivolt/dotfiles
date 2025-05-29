return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local buf_map = function(bufnr, mode, lhs, rhs, opts) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {silent = true}) end
    local on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })

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

    null_ls.setup({
      sources = {
        -- Only include eslint sources if eslint is installed and found in the path
        -- This prevents the startup error when eslint is not available
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.gitsigns
      },
      on_attach = on_attach
    })
  end,
  lazy = false,
  event = "VeryLazy"
}

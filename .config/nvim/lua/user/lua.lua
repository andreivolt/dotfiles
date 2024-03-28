require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'hs', 'spoon' },
          },
          runtime = {
            version = 'LuaJIT',
            -- TODO
            -- path = vim.split(package.path, ';')
          },
          telemetry = { enable = false },
          workspace = {
            -- stop "Do you need to configure your work environment as `luassert`?" spam
            checkThirdParty = false,

            -- the following does not show nvim api completion
            library = vim.env.VIMRUNTIME,

            -- make the server aware of Neovim runtime files, pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true),
          }
        }
      })
    end
    return true
  end
}

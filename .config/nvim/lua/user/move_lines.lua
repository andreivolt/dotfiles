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
    ["<c-k>"] = ":m '<-2<CR>gv=gv",
    ["<c-j>"] = ":m '>+1<CR>gv=gv",
  }
}

for mode, bindings in pairs(keymaps) do
  for key, cmd in pairs(bindings) do
    vim.api.nvim_set_keymap(mode, key, cmd, { silent = true })
  end
end

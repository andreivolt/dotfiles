vim.opt.guicursor = {
  'n-v-c-sm:block-Cursor',
  'i-ci-ve:ver25-Cursor',
  'r-cr-o:hor20-Cursor'
}

local cursor_colors = {
  n = '#ffffff',  -- Normal mode
  i = '#00ff00',  -- Insert mode
  v = '#0000ff',  -- Visual mode
  V = '#0000ff',  -- Visual line mode
  ['\22'] = '#ff0000',  -- Visual block mode
  c = '#ff0000',  -- Command mode
  r = '#ff0000',  -- Replace mode
  R = '#ff0000',  -- Replace mode (virtual)
  ['!'] = '#ff0000',  -- Shell command mode
  t = '#ff0000'   -- Terminal mode
}

local function set_cursor_color()
  local mode = vim.fn.mode()
  local color = cursor_colors[mode]
  if color then
    vim.api.nvim_set_hl(0, 'Cursor', { bg = color })
  end
end

vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  callback = set_cursor_color
})

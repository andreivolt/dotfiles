vim.opt.guicursor = {
  'n-v-c-sm:block-Cursor',
  'i-ci-ve:ver25-Cursor',
  'r-cr-o:hor20-Cursor'
}

local cursor_colors = {
  n = '#ff0000',  -- Normal mode
  i = '#00ff00',  -- Insert mode
  v = '#0000ff',  -- Visual mode
  V = '#0000ff',  -- Visual line mode
  ['\22'] = '#0000ff',  -- Visual block mode
  c = '#ffff00',  -- Command mode
  r = '#ff00ff',  -- Replace mode
  R = '#ff00ff',  -- Replace mode (virtual)
  ['!'] = '#ff00ff',  -- Shell command mode
  t = '#00ffff'   -- Terminal mode
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

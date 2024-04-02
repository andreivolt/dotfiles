vim.opt.guicursor = {
  'n-v-c-sm:block-Cursor',
  'i-ci-ve:ver25-Cursor',
  'r-cr-o:hor20-Cursor'
}

vim.api.nvim_create_autocmd('ModeChanged', {
  callback = function()
    local mode = vim.fn.mode()
    local color = ({
      n = '#ffffff', -- normal mode
      i = '#00ff00', -- insert mode
      v = '#0000ff', -- visual mode
      V = '#0000ff', -- visual line mode
      ['\22'] = '#ff0000', -- visual block mode
      c = '#ff0000', -- command mode
      r = '#ff0000', -- replace mode
      R = '#ff0000', -- replace mode (virtual)
      ['!'] = '#ff0000', -- shell command mode
      t = '#ff0000' -- terminal mode
    })[mode]

    if not color then return end

    vim.api.nvim_set_hl(0, 'Cursor', { bg = color })
  end
})

return {
  'RRethy/vim-illuminate',
  enabled = false,
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    delay = 2000,
    filetypes_denylist = {
      'fugitive',
    },
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}

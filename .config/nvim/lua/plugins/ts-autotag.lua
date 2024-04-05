local filetypes = {
  'astro',
  'glimmer',
  'handlebars',
  'hbs',
  'html',
  'javascript',
  'javascriptreact',
  'jsx',
  'markdown',
  'rescript',
  'svelte',
  'tsx',
  'typescript',
  'typescriptreact',
  'vue',
  'xml',
}

return {
  'windwp/nvim-ts-autotag',
  dependencies = 'nvim-treesitter',
  opts = {
    autotag = {
      enable = true,
      filetypes = filetypes
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
  event = 'InsertEnter',
  ft = filetypes,
}

return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  init = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
  end,
  opts = {
    -- open opening the buffer, close these fold kinds
    close_fold_kinds_for_ft = {
      default = { "imports", "comment" },
      json = { "array" },
    },
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end
  },
  keys = {
    { 'zR',        function() require('ufo').openAllFolds() end,               desc = 'Open all folds' },
    { 'zM',        function() require('ufo').closeAllFolds() end,              desc = 'Close all folds' },
    { '<leader>v', function() require('ufo').peekFoldedLinesUnderCursor() end, desc = 'Peek folded lines' },
  },
  event = "VeryLazy",
}

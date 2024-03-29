vim.filetype.add({
  pattern = {
    ['.*'] = {
      priority = -math.huge,
      function(path, bufnr)
        local shebang_mappings = {
          ["bb"] = "clojure",
          ["boot"] = "clojure",
          ["bun"] = "javascript",
          ["gorun"] = "go",
          ["osascript"] = "applescript",
          ["pip%-run"] = "python",
          ["pipx%s+run"] = "python",
          ["racket"] = "racket",
          ["rust%-script"] = "rust",
        }

        local firstLine = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""

        local shebang = firstLine:match("^#!.*%s+(%S+)")
        print(shebang)
        if shebang then
          for pattern, filetype in pairs(shebang_mappings) do
            if vim.filetype.matchregex(shebang, pattern) then
              return filetype
            end
          end
        end
      end,
    },
  },
  filename = {
    [".envrc"] = "bash",
  },
})

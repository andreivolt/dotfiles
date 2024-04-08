vim.filetype.add({
  pattern = {
    ['.*'] = {
      priority = -math.huge,
      function(_, bufnr)
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

        local interpreter_to_filetype = {
          ["bash"] = "bash",
          ["sh"] = "sh",
          ["zsh"] = "zsh",
          ["python"] = "python",
          ["ruby"] = "ruby",
          ["perl"] = "perl",
        }

        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 2, false)
        local secondLine = lines[2] or ""

        local nix_interp = secondLine:match("^#!.*nix%-shell%s+%-i%s+(%S+)")
        if nix_interp then
          return interpreter_to_filetype[nix_interp] or nix_interp
        end

        if secondLine:match("^#!.*nix%-shell") then
          return "bash"
        end

        local shebang = lines[1]:match("^#!(.*)")
        if shebang then
          for pattern, filetype in pairs(shebang_mappings) do
            if string.find(shebang, pattern) then
              return filetype
            end
          end
        end
      end,
    },
  },
})

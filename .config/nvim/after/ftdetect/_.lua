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
          ["uv%s+run"] = "python",
        }
        local interpreter_to_filetype = {
          ["bash"] = "bash",
          ["sh"] = "sh",
          ["zsh"] = "zsh",
          ["python"] = "python",
          ["ruby"] = "ruby",
          ["perl"] = "perl",
          ["bb"] = "clojure",
        }
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
        local first_line = lines[1] or ""
        if first_line:match("cached%-nix%-shell") or first_line:match("^#!/.*nix%-shell") then
          for _, line in ipairs(lines) do
            local nix_interp = line:match("^#!%s*.*nix%-shell.*%-i%s+(%S+)")
            if nix_interp then
              return interpreter_to_filetype[nix_interp] or nix_interp
            end
          end
          for _, line in ipairs(lines) do
            if line:match("^#!%s*.*nix%-shell") then
              return "bash"
            end
          end
        end
        local shebang = lines[1]:match("^#!(.*)")
        if shebang then
          if shebang:match("env%s+%-S%s+deno%s+run") then
            local ext = shebang:match("%-%-ext%s+(%w+)")
            if ext then
              if ext == "ts" or ext == "tsx" then
                return "typescript"
              elseif ext == "js" or ext == "jsx" then
                return "javascript"
              end
            end

            return "javascript"
          end

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

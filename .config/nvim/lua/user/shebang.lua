vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    local shebang_mappings = {
      ["^#!.*bb$"] = "clojure",
      ["^#!.*bun$"] = "javascript",
      ["^#!.*gorun$"] = "go",
      ["^#!.*boot$"] = "clojure",
      ["^#!.*osascript"] = "applescript",
      ["^#!.*pip%-run"] = "python",
      ["^#!.*pipx run"] = "python",
      ["^#!.*racket$"] = "racket",
      ["^#!.*rust%-script"] = "rust",
    }

    local firstLine = vim.fn.getline(1)
    local found = false
    for pattern, filetype in pairs(shebang_mappings) do
      if firstLine:match(pattern) then
        vim.cmd("setfiletype " .. filetype)
        found = true
        break
      end
    end

    if not found and firstLine:match("^#!.*scriptisto") then
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      for _, line in ipairs(lines) do
        local script_src_match = line:match("^// script_src: (.*)$")
        if script_src_match then
          local matched_filetype = vim.filetype.match({filename = script_src_match})
          if matched_filetype then
            vim.cmd("setfiletype " .. matched_filetype)
          end
          break
        end
      end
    end
  end,
})

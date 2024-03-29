-- open a URL in the default browser, if multiple URLs are present on the current line, open the URL under the cursor
function OpenURL()
    local line = vim.api.nvim_get_current_line()
    local cursor_col = vim.fn.col(".")
    local urls = {}

    for url in string.gmatch(line, "https?://[%w-_./?%%=~&:+%%*]+") do table.insert(urls, url) end

    if #urls == 0 then
        return
    elseif #urls == 1 then
        vim.fn.system('open "' .. urls[1] .. '"')
    else
        local found_url = false
        for _, url in ipairs(urls) do
            local s, e = string.find(line, url, 1, true)
            if cursor_col >= s and cursor_col <= e then
                vim.fn.system('open "' .. url .. '"')
                found_url = true
                break
            end
        end
        if not found_url then for _, url in ipairs(urls) do vim.fn.system('open "' .. url .. '"') end end
    end
end

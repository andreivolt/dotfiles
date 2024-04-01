function claude_command(type)
  -- Get the selected text
  local selected_text = get_selected_text(type)

  -- Pass the selected text to the claude command and capture the output
  local output = vim.fn.system('claude --model claude-3-sonnet-20240229', selected_text)

  -- Split the output into lines
  local output_lines = vim.split(output, "\n")

  -- Append the output below the selection
  local last_line = vim.fn.line("'>")
  vim.fn.append(last_line, output_lines)
end

function get_selected_text(type)
  if type == 'v' then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
    if #lines == 0 then
      return ''
    end
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3] - (vim.o.selection == 'inclusive' and 1 or 2))
    lines[1] = string.sub(lines[1], start_pos[3], -1)
    return table.concat(lines, "\n")
  elseif type == 'char' then
    local start_pos = vim.fn.getpos("'[")
    local end_pos = vim.fn.getpos("']")
    return string.sub(vim.fn.getline('.'), start_pos[3], end_pos[3] - 1)
  else
    return ''
  end
end

vim.api.nvim_create_user_command('ClaudeCommand', function(opts)
  claude_command(opts.range > 0 and 'v' or 'char')
end, { range = true })

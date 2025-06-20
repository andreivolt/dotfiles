local M = {}

local function git_mv_rename()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()
  if not node then return end
  
  local old_name = node.absolute_path
  local default = node.name
  
  vim.ui.input({ prompt = "Rename to: ", default = default }, function(new_name)
    if not new_name or new_name == "" then return end
    
    local new_path
    if node.parent then
      new_path = node.parent.absolute_path .. "/" .. new_name
    else
      new_path = "/" .. new_name
    end
    
    -- Check if file is tracked by git
    local is_git_tracked = vim.fn.system("git ls-files --error-unmatch " .. vim.fn.shellescape(old_name) .. " 2>/dev/null")
    
    if vim.v.shell_error == 0 then
      -- File is tracked by git, use git mv
      local result = vim.fn.system("git mv " .. vim.fn.shellescape(old_name) .. " " .. vim.fn.shellescape(new_path))
      if vim.v.shell_error ~= 0 then
        vim.notify("Git mv failed: " .. result, vim.log.levels.ERROR)
      else
        api.tree.reload()
      end
    else
      -- File is not tracked, use regular rename
      api.fs.rename()
    end
  end)
end

function M.on_attach(bufnr)
  local api = require("nvim-tree.api")
  
  -- Default mappings
  api.config.mappings.default_on_attach(bufnr)
  
  -- Override rename with git mv
  vim.keymap.set("n", "r", git_mv_rename, { buffer = bufnr, noremap = true, silent = true, nowait = true })
end

return M
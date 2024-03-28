
-- lua/trypkg.lua

-- Usage:
--  :lua require'trypkg'.try'user/repo'
--  :lua require'trypkg'.del'repo'

local M = {}

M.site = 'https://github.com/'

function M.try(s, site)
  local site
  if s:match'^[%w-]+/[^/%s]+$' then
    site = site or M.site
    if not site:match'/$' then
      site = site..'/'
    end
    site = site..s
  else
    site = s
  end
  local pkg = site:gsub('.*/(.*)', '%1'):gsub('%.git$', '')
  local clonepath = vim.fn.stdpath'config'..'/pack/trypkg/opt/'..pkg
  vim.fn.mkdir(vim.fn.fnamemodify(clonepath, ':h'), 'p')
  os.execute(string.format('git clone --depth 1 "%s" "%s"', site:gsub('["\\]', '\\%0'), clonepath:gsub('["\\]', '\\%0')))
  vim.cmd('packadd '..pkg)
end

function M.del(s, site)
  local site
  if s:match'^[%w-]+/[^/%s]+$' then
    site = site or M.site
    if not site:match'/$' then
      site = site..'/'
    end
    site = site..s
  else
    site = s
  end
  local pkg = site:gsub('.*/(.*)', '%1'):gsub('%.git$', '')
  local clonepath = vim.fn.stdpath'config'..'/pack/trypkg/opt/'..pkg
  vim.fn.delete(clonepath, 'rf')
end

return M



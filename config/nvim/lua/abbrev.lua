local M = {}
local fn = vim.fn

local function cabbrev(input, replace)
  cmd = 'cnoreabbrev <expr> %s v:lua.abbrev.command("%s", "%s")'

  vim.cmd(cmd:format(input, input, replace))
end

function M.command(cmd, match)
  if fn.getcmdtype() == ':' and fn.getcmdline():match('^' .. cmd) then
    return match
  else
    return cmd
  end
end

cabbrev('t', 'Telescope')

return M

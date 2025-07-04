local ghostty = require("ghostty")

local function handleGhosttyResize()
  local ghosttyApp = hs.application.get("ghostty")
  if not ghosttyApp then return end

  local mainWindow = ghosttyApp:mainWindow()
  if not mainWindow then return end

  if #hs.screen.allScreens() > 1 then
    ghostty.toggleMonitor()
  else
    mainWindow:maximize()
  end
end

local function start()
  hs.screen.watcher.new(function()
    hs.timer.doAfter(0.5, handleGhosttyResize)
  end):start()
end

return {
  start = start
}

require("hs.ipc")

local toggleApp = require("toggle_app")

require("hotkeys")

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:updateAllRepos()

spoon.SpoonInstall:andUse("ReloadConfiguration", {
  repo = "default",
  watch_paths = { hs.configdir },
})
spoon.ReloadConfiguration:start()

spoon.SpoonInstall:andUse("WinWin", {
  repo = "default",
})

local function handleGhosttyResize()
  local ghostty = hs.application.get("ghostty")
  if not ghostty then return end

  local mainWindow = ghostty:mainWindow()
  if not mainWindow then return end

  if #hs.screen.allScreens() > 1 then
    toggleApp.toggleAppMonitor()
  else
    mainWindow:maximize()
  end
end

hs.screen.watcher.new(function()
  hs.timer.doAfter(0.5, handleGhosttyResize)
end):start()

hs.spaces.watcher.new(function()
  hs.timer.doAfter(0.5, handleGhosttyResize)
end):start()

hs.ipc.cliInstall()

if hs.ipc then
  hs.ipc.handler = function(str)
    if str == "toggle-terminal" then
      toggleApp.toggleAppVisibility()
      return "Toggled terminal visibility"
    elseif str == "toggle-monitor" then
      toggleApp.toggleAppMonitor()
      return "Moved terminal to other monitor"
    else
      return "Unknown command: " .. str
    end
  end
end

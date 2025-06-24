require("hs.ipc")

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:updateAllRepos()

local screen = require("hs.screen")
local application = require("hs.application")

local toggleApp = require("toggle_app")
require("hotkeys")

spoon.SpoonInstall:andUse("ReloadConfiguration", {
  repo = "default", -- Repository where the spoon is located
  watch_paths = {
    hs.configdir, -- Default Hammerspoon config directory
  },
})

spoon.ReloadConfiguration:start()

spoon.SpoonInstall:andUse("WinWin", {
  repo = "default", -- Repository where WinWin is located
})

local redshift = require("redshift")
redshift.init()

-- Function to handle Ghostty resizing
local function handleGhosttyResize()
  local ghostty = hs.application.get("ghostty")
  
  if ghostty then
    local mainWindow = ghostty:mainWindow()
    
    if mainWindow then
      local currentScreen = mainWindow:screen()
      
      if #hs.screen.allScreens() > 1 then
        toggleApp.toggleAppMonitor()
      else
        mainWindow:maximize()
      end
    end
  end
end

-- Auto-move Ghostty to external monitor when connected
hs.screen.watcher.new(function()
  hs.timer.doAfter(0.5, handleGhosttyResize)
end):start()

-- Also watch for resolution changes specifically
hs.spaces.watcher.new(function()
  hs.timer.doAfter(0.5, handleGhosttyResize)
end):start()

-- CLI setup
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

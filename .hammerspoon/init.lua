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

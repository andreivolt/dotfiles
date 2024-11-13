require("hs.ipc")

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:updateAllRepos()

local screen = require("hs.screen")
local application = require("hs.application")

require('hotkeys')

spoon.SpoonInstall:andUse("ReloadConfiguration", {
  repo = "default", -- Repository where the spoon is located
  watch_paths = {
    hs.configdir, -- Default Hammerspoon config directory
  }
})

spoon.ReloadConfiguration:start()

spoon.SpoonInstall:andUse("WinWin", {
  repo = "default" -- Repository where WinWin is located
})

local redshift = require('redshift')
redshift.init()

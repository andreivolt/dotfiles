require("hs.ipc")

local ghostty = require("ghostty")
local darkmode = require("darkmode")
local ghosttyResize = require("ghostty-resize")

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:updateAllRepos()

spoon.SpoonInstall:andUse("ReloadConfiguration", {
  repo = "default",
  watch_paths = { hs.configdir },
})
spoon.ReloadConfiguration:start()


hs.hotkey.bind({}, "²", ghostty.toggleVisibility)
hs.hotkey.bind({ "alt" }, "²", ghostty.toggleMonitor)
hs.hotkey.bind({ "ctrl", "cmd" }, "v", function()
  hs.execute("/Users/andrei/bin/vision -c", true)
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "d", darkmode.toggleDarkMode)

ghosttyResize.start()

hs.ipc.cliInstall()

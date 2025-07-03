require("hs.ipc")

local ghostty = require("ghostty")

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:updateAllRepos()

spoon.SpoonInstall:andUse("ReloadConfiguration", {
  repo = "default",
  watch_paths = { hs.configdir },
})
spoon.ReloadConfiguration:start()

local function toggleDarkMode()
	hs.osascript.applescript([[
        tell application "System Events"
            tell appearance preferences
                set dark mode to not dark mode
            end tell
        end tell
    ]])
end

hs.hotkey.bind({}, "²", function()
	ghostty.toggleVisibility()
end)

hs.hotkey.bind({ "alt" }, "²", function()
	ghostty.toggleMonitor()
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "v", function()
	hs.execute("/Users/andrei/bin/vision -c", true)
end)

hs.hotkey.bind({ "ctrl", "cmd" }, "d", function()
	toggleDarkMode()
end)

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

hs.screen.watcher.new(function()
  hs.timer.doAfter(0.5, handleGhosttyResize)
end):start()

hs.ipc.cliInstall()

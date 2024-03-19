local ipc = require("hs.ipc")
if not ipc.cliStatus("/usr/local") then
  ipc.cliInstall()
end

local screen = require("hs.screen")
local application = require("hs.application")

local function resizeKittyWindow()
    local kittyApp = hs.application.get("kitty")
    hs.console.printStyledtext("hey")
    if kittyApp then
        local kittyPID = kittyApp:pid()
        local kittyPath = "/Applications/kitty.app/Contents/MacOS/kitty"
        local sockPath = string.format("/tmp/kitty-%d", kittyPID)

        local cmd = string.format("%s @ --to=unix:%s resize-os-window --match all --action toggle-fullscreen", kittyPath, sockPath)

        hs.console.printStyledtext(cmd)
        hs.execute(cmd)
        hs.execute(cmd)
    end
end

screen.watcher.newWithActiveScreen(resizeKittyWindow):start()
hs.console.printStyledtext("Screen watcher started")

hs.hotkey.bind({}, "²", function()
  local app = hs.application.get("kitty")
  if app then
    if not app:mainWindow() then
      app:selectMenuItem({"kitty", "New OS window"})
    elseif app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.launchOrFocus("kitty")
    app = hs.application.get("kitty")
  end
  hs.console.printStyledtext("Kitty hotkey triggered")
end)

hs.hotkey.bind({"ctrl", "alt"}, "R", function()
  hs.execute("/Users/andrei/drive/bin/randomtab", true)
end)


function activateApp(appName)
  hs.application.launchOrFocus(appName)
end

hs.hotkey.bind({"ctrl", "cmd"}, "1", function() activateApp("Google Chrome") end)
hs.hotkey.bind({"ctrl", "cmd"}, "2", function() activateApp("Kitty") end)
hs.hotkey.bind({"ctrl", "cmd"}, "3", function() activateApp("Spotify") end)
hs.hotkey.bind({"ctrl", "cmd"}, "4", function() activateApp("Mimestream") end)

hs.hotkey.bind({"ctrl", "cmd"}, "d", function()
  hs.osascript.applescript([[
    tell application "System Events"
      tell appearance preferences
        set dark mode to not dark mode
      end tell
    end tell
  ]])
end)

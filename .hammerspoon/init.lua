hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:updateAllRepos()

local screen = require("hs.screen")
local application = require("hs.application")

local toggleApp = "kitty"

local function setToggleApp()
    local currentWindow = hs.window.focusedWindow()
    if currentWindow then
        local currentApp = currentWindow:application()
        toggleApp = currentApp:name()
        hs.console.printStyledtext("Switched toggle app to " .. toggleApp)
    else
        hs.console.printStyledtext("No focused window found")
    end
end

hs.hotkey.bind({}, "²", function()
    if toggleApp then
        local app = hs.application.get(toggleApp)
        if app then
            if not app:mainWindow() then
                hs.application.launchOrFocus(toggleApp)
            elseif app:isFrontmost() then
                app:hide()
            else
                app:activate()
            end
        else
            hs.application.launchOrFocus(toggleApp)
        end
  else
        hs.console.printStyledtext("No toggle app set")
    end
end)

hs.hotkey.bind({"ctrl", "cmd"}, "r", function()
  hs.execute("/Users/andrei/bin/randomtab", true)
end)

hs.hotkey.bind({"ctrl", "cmd"}, "v", function()
  hs.execute("/Users/andrei/bin/vision -c", true)
end)

local function activateApp(appName)
  hs.application.launchOrFocus(appName)
end

-- hs.hotkey.bind({"ctrl", "cmd"}, "1", function() activateApp("Google Chrome") end)
-- hs.hotkey.bind({"ctrl", "cmd"}, "2", function() activateApp("Kitty") end)
-- hs.hotkey.bind({"ctrl", "cmd"}, "3", function() activateApp("Spotify") end)
-- hs.hotkey.bind({"ctrl", "cmd"}, "4", function() activateApp("Sublime Text") end)

hs.hotkey.bind({"ctrl", "cmd"}, "d", function()
  hs.osascript.applescript([[
    tell application "System Events"
        tell appearance preferences
            set dark mode to not dark mode
        end tell
    end tell
  ]])
end)

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

-- require("finder")
require("terminal")

local function isWhatsAppOrTelegram(window)
  local app = window:application()
  return app:name() == "WhatsApp" or app:name() == "Telegram"
end

local function resizeAndCenterWindow(window)
  local screen = window:screen()
  local screenFrame = screen:frame()
  local windowFrame = {
    x = screenFrame.x + (screenFrame.w * 0.125),
    y = screenFrame.y + (screenFrame.h * 0.125),
    w = screenFrame.w * 0.75,
    h = screenFrame.h * 0.75
  }
end

local windowFilter = hs.window.filter.new(true)
  :subscribe(hs.window.filter.windowCreated, function(window)
  if isWhatsAppOrTelegram(window) then
    resizeAndCenterWindow(window)
  end
end)

-- spoon.SpoonInstall:andUse("AppLauncher", {
--   hotkeys = {
--     c = "Calendar",
--     b = "Calendar",
--     d = "Discord",
--     f = "Firefox",
--     t = "Kitty",
--     z = "Zoom.us",
--   }
-- })

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "T", setToggleApp)

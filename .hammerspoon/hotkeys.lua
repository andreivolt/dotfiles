local toggleApp = require("toggle_app")
local darkMode = require("dark_mode")

hs.hotkey.bind({}, "²", function()
		toggleApp.toggleAppVisibility()
end)

-- Alt+² to toggle app between monitors
hs.hotkey.bind({"alt"}, "²", function()
		toggleApp.toggleAppMonitor()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "t", function()
		toggleApp.setCurrentToggleApp()
end)


hs.hotkey.bind({"ctrl", "cmd"}, "r", function()
	hs.execute("/Users/andrei/bin/randomtab", true)
end)

hs.hotkey.bind({"ctrl", "cmd"}, "v", function()
	hs.execute("/Users/andrei/bin/vision -c", true)
end)


hs.hotkey.bind({"ctrl", "cmd"}, "d", function()
		darkMode.toggleDarkMode()
end)

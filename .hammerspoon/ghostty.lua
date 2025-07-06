local function toggleGhosttyVisibility()
	local ghostty = hs.application.get("ghostty")
	if ghostty then
		if not ghostty:mainWindow() then
			hs.application.launchOrFocus("ghostty")
		elseif ghostty:isFrontmost() then
			ghostty:hide()
		else
			ghostty:activate()
		end
	else
		hs.application.launchOrFocus("ghostty")
		hs.timer.doAfter(0.5, function()
			local newGhostty = hs.application.get("ghostty")
			if newGhostty and newGhostty:mainWindow() then
				newGhostty:mainWindow():maximize()
			end
		end)
	end
end

local function toggleGhosttyMonitor()
	local ghostty = hs.application.get("ghostty")
	if ghostty and ghostty:mainWindow() then
		local win = ghostty:mainWindow()
		local screens = hs.screen.allScreens()

		if #screens > 1 then
			local currentScreen = win:screen()
			local nextScreen

			for i, screen in ipairs(screens) do
				if screen ~= currentScreen then
					nextScreen = screen
					break
				end
			end

			if nextScreen then
				win:moveToScreen(nextScreen)
				win:maximize()
				ghostty:activate()
			end
		else
			win:maximize()
			ghostty:activate()
		end
	else
		hs.application.launchOrFocus("ghostty")
	end
end

return {
	toggleVisibility = toggleGhosttyVisibility,
	toggleMonitor = toggleGhosttyMonitor,
}
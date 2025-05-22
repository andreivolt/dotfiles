local currentToggleApp = "ghostty"

-- set the current toggle application based on the focused window
local function updateCurrentToggleApp()
		local focusedWindow = hs.window.focusedWindow()
		if focusedWindow then
				local focusedApp = focusedWindow:application()
				currentToggleApp = focusedApp:name()
				hs.console.printStyledtext("Toggle application set to: " .. currentToggleApp)
		else
				hs.console.printStyledtext("No focused window detected. Toggle application remains: " .. currentToggleApp)
		end
end

-- toggle the visibility of the current toggle application
local function toggleAppVisibility()
		if currentToggleApp then
				local appInstance = hs.application.get(currentToggleApp)
				if appInstance then
						if not appInstance:mainWindow() then
								hs.application.launchOrFocus(currentToggleApp)
						elseif appInstance:isFrontmost() then
								appInstance:hide()
						else
								appInstance:activate()
						end
				else
						hs.application.launchOrFocus(currentToggleApp)
				end
		else
				hs.console.printStyledtext("No toggle application has been set.")
		end
end

-- toggle app between monitors
local function toggleAppMonitor()
		if currentToggleApp then
				local appInstance = hs.application.get(currentToggleApp)
				if appInstance and appInstance:mainWindow() then
						local win = appInstance:mainWindow()
						local screens = hs.screen.allScreens()
						
						-- If we have more than one screen
						if #screens > 1 then
								local currentScreen = win:screen()
								local nextScreen
								
								-- Find the external monitor (assume it's not the first screen)
								for i, screen in ipairs(screens) do
										if screen ~= currentScreen then
												nextScreen = screen
												break
										end
								end
								
								-- If we found another screen, move the window there
								if nextScreen then
										win:moveToScreen(nextScreen)
										-- Maximize the window on the new screen
										win:maximize()
										appInstance:activate()
								end
						else
								-- Only one screen, maximize it
								win:maximize()
								appInstance:activate()
						end
				else
						-- App not running, launch it
						hs.application.launchOrFocus(currentToggleApp)
				end
		else
				hs.console.printStyledtext("No toggle application has been set.")
		end
end

return {
		setCurrentToggleApp = updateCurrentToggleApp,
		toggleAppVisibility = toggleAppVisibility,
		toggleAppMonitor = toggleAppMonitor
}

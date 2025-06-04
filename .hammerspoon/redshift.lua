require("hs.ipc")

local redshift = {}

function redshift.init()
	local alertID = nil
	local function changeTemp(delta)
		local output = hs.execute("/Users/andrei/bin/colortemp " .. delta, true)
		local temp = output:match("Temperature set to (%d+)K")
		local message
		if temp then
			message = "Screen temperature: " .. temp .. "K"
		else
			message = "Failed to change temperature"
		end

		if alertID then
			hs.alert.closeSpecific(alertID)
		end
		alertID = hs.alert.show(message, { textSize = 16 }, 2)
	end
	hs.hotkey.bind({ "alt", "shift" }, "up", function()
		changeTemp("+100")
	end)
	hs.hotkey.bind({ "alt", "shift" }, "down", function()
		changeTemp("-100")
	end)
end

return redshift

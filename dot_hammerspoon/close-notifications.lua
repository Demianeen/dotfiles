local function close_notifications()
	local scriptPath = "~/scripts/closeNotifications.js"
	local command = string.format("/usr/bin/osascript -l JavaScript %s", scriptPath)
	hs.execute(command, true)
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "N", function()
	close_notifications()
end)

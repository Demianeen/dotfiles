hs.loadSpoon("EmmyLua")
hs.loadSpoon("AClock")

require("kitty")
require("close-notifications")
-- require("vim-motion")

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
	hs.reload()
end)

hs.alert.show("Config loaded")

hs.notify
	.new({
		title = "Test Notification",
		informativeText = "This is a mock notification created with Hammerspoon!",
		soundName = hs.notify.defaultNotificationSound,
	})
	:send()

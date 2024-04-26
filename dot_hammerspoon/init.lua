hs.loadSpoon("EmmyLua")
hs.loadSpoon("AClock")

-- require("kitty")
-- require("close-notifications")
require("brew")
-- require("vim-motion")

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
	hs.reload()
end)

hs.alert.show("Config loaded")

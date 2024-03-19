local sbar = require("sketchybar")
local colors = require("colors")

-- Equivalent to the --bar domain
local bar = sbar.bar({
	border_color = colors.bar.border,
	color = colors.bar.bg,
	height = 40,
	padding_left = 8,
	padding_right = 8,
	position = "bottom",
	shadow = false,
	sticky = true,
	topmost = false,
})

return bar

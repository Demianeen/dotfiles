local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	background = {
		height = 26,
		corner_radius = 9,
		border_width = 1,
	},

	padding_left = settings.paddings,
	padding_right = settings.paddings,

	icon = {
		font = {
			family = settings.font,
			size = 14,
			style = "Bold",
		},
		color = colors.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},

	label = {
		font = {
			family = settings.font,
			style = "Semibold",
			size = 13,
		},
		color = colors.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
})

local sbar = require("sketchybar")
local colors = require("colors")

local app_icons = require("items.left.spaces.icon_map")

local spaces = {}

for i = 1, 9, 1 do
	local space = sbar.add("item", {
		padding_left = 0,
		padding_right = 1,
		background = { color = colors.bg1 },

		icon = {
			string = i,
			padding_left = 6,
			padding_right = 6,
			color = colors.white,
			highlight_color = colors.white,
		},

		label = {
			padding_left = 0,
			padding_right = 10,
			color = colors.grey,
			highlight_color = colors.grey,
			font = "sketchybar-app-font:Regular:16",
			y_offset = -1,
		},
	})

	spaces[i] = space

	space:subscribe("space_change", function(ENV)
		local bg_color = ENV.SELECTED == "true" and colors.bg2 or colors.bg1
		local text_color = ENV.SELECTED == "true" and colors.white or colors.grey

		sbar.animate("sin", 10, function()
			space:set({
				icon = { highlight = ENV.SELECTED, color = text_color },
				label = { highlight = ENV.SELECTED, highlight_color = text_color },
				background = { color = bg_color },
			})
		end)
	end)
end

local space_creator = sbar.add("item", {
	label = { drawing = false },
	display = "active",
	icon = {
		string = "􀆊",
		font = { style = "Heavy", size = 12 },
		color = colors.grey,
	},
})

space_creator:subscribe("mouse.clicked", function(_)
	sbar.exec("yabai -m space --create")
end)

space_creator:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true

	for app in pairs(env.INFO.apps) do
		print(env.INFO.space, "app", app)
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end

	if no_app then
		icon_line = "􀍠"
	end

	icon_line = icon_line:gsub("%s+$", "")

	sbar.animate("sin", 10, function()
		if spaces[env.INFO.space] == nil then
			return
		end
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)

return {
	spaces = spaces,
	space_creator = space_creator,
}

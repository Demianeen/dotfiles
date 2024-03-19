local sbar = require("sketchybar")
local colors = require("colors")

local brew = sbar.add("item", {
	icon = { string = "􀐛" },

	label = {
		align = "center",
		color = colors.grey,
		string = "􀍠",
		width = 18,
	},

	position = "right",
	update_freq = 60 * 60,
	-- not to show icon while getting updates count
	drawing = false,
})

local function action()
	sbar.exec([[wezterm start -- zsh -c "brew upgrade"]])
end

local function update()
	sbar.exec([[ brew outdated | wc -l | tr -d ' ' ]], function(updates_count)
		local count = tonumber(updates_count)
		local icon = { color = colors.white }
		local label = { string = updates_count, color = colors.white }
		local drawing = true

		if count < 10 then
			drawing = false
		elseif count < 30 then
			icon.color = colors.white
		else
			icon.color = colors.orange
		end

		sbar.animate("sin", 10, function()
			brew:set({ label = label, icon = icon, drawing = drawing })
		end)
	end)
end

brew:subscribe({ "forced", "routine", "brew_update", "update" }, update)
brew:subscribe("mouse.clicked", action)

return brew

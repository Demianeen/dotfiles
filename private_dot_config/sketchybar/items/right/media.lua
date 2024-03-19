local colors = require("colors")

local whitelist = {
	["Spotify"] = true,
	["Music"] = true,
}

local media = sbar.add("item", {
	icon = { width = 20 },
	position = "right",
})

local label_text
local icon
media:subscribe("media_change", function(env)
	local is_playing = env.INFO.state == "playing"
	local color = is_playing and colors.white or colors.grey

	local drawing = whitelist[env.INFO.app] == true

	if env.INFO.artist ~= "" then
		label_text = env.INFO.artist .. " / " .. env.INFO.title
	else
		label_text = env.INFO.title
	end

	local label = {
		string = label_text,
		color = color,
	}

	icon = {
		string = is_playing and "􀊄" or "􀊆",
		color = color,
	}

	-- -- you can add animations like this
	-- sbar.animate("sin", 10, function()
	media:set({ drawing = drawing, icon = icon, label = label })
	-- end)
end)

return media

local sbar = require("sketchybar")

local clock = sbar.add("item", {
	position = "right",
	update_freq = 15,
})

local function update()
	local time = os.date("%a %d %b %H:%M")

	clock:set({ label = time })
end

clock:subscribe({ "routine", "forced" }, update)

return clock

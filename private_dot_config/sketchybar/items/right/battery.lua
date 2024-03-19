local icons = require("icons")
local colors = require("colors")
local battery = sbar.add("item", {
	position = "right",
	update_freq = 15,
})

local function update()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = { string = icons.error, color = colors.white }
		local found, _, charge = batt_info:find("(%d+)%%")
		local is_charging = string.find(batt_info, "AC Power")
		local drawing = true

		if found then
			local parsed_charge = tonumber(charge)

			if is_charging then
				icon.string = icons.battery.charging
			elseif parsed_charge > 80 then
				icon.string = icons.battery._100
			elseif parsed_charge > 60 then
				icon.string = icons.battery._75
			elseif parsed_charge > 40 then
				icon.string = icons.battery._50
				icon.color = colors.yellow
			elseif parsed_charge > 20 then
				icon.string = icons.battery._25
				icon.color = colors.orange
			else
				icon.string = icons.battery._0
				icon.color = colors.red
			end

			if is_charging and parsed_charge > 90 then
				drawing = false
			else
				drawing = true
			end
		end

		battery:set({ icon = icon, label = charge .. "%", drawing = drawing })
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, update)

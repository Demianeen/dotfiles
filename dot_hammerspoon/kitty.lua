local commandKeyWatcher = hs
	.eventtap
	---@param event hs.eventtap.event
	.new({ hs.eventtap.event.types.keyDown }, function(event)
		local flags = event:getFlags()
		local keyCode = event:getKeyCode()

		local ignoreList = {
			[hs.keycodes.map["v"]] = true,
			-- vim motions
			[hs.keycodes.map["h"]] = true,
			[hs.keycodes.map["j"]] = true,
			[hs.keycodes.map["k"]] = true,
			[hs.keycodes.map["l"]] = true,
		}

		if not flags then
			return
		end

		-- don't do anything if we have command and ctrl
		if flags.cmd and flags.ctrl then
			return
		end

		if ignoreList[keyCode] == true then
			return
		end

		local newFlags = {
			alt = flags.alt,
			shift = flags.shift,
			fn = flags.fn,
		}

		-- switch between ctrl and cmd
		if flags.cmd then
			newFlags.ctrl = true
			event:setFlags(newFlags)
		elseif flags.ctrl then
			newFlags.cmd = true
			event:setFlags(newFlags)
		end
	end)

---@param win hs.window
local kittyWindowFilter = hs.window.filter.new(function(win)
	if win == nil then
		return false
	end
	return win:application():name() == "kitty"
end)

kittyWindowFilter:subscribe(hs.window.filter.windowFocused, function()
	commandKeyWatcher:start()
end)

kittyWindowFilter:subscribe(hs.window.filter.windowUnfocused, function()
	commandKeyWatcher:stop()
end)

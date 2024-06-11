local function runCommand(command)
	local handle = io.popen(command)
	if handle == nil then
		return ""
	end
	local output = handle:read("a")
	handle:close()
	return output
end

local function updateBrew()
	local output = runCommand("brew upgrade")
	local wasYabaiUpdated = output:find("yabai")
	if wasYabaiUpdated then
		hs.notify.new({ title = "Hammerspoon", informativeText = "Yabai was updated" }):send()
	else
		hs.notify.new({ title = "Hammerspoon", informativeText = "Brew packages were updated" }):send()
	end
end

updateBrew()
hs.timer.doEvery(604800, updateBrew)

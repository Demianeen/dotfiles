-- These constants are used in the code below to allow hotkeys to be
-- assigned using side-specific modifier keys.
ORDERED_KEY_CODES = { 58, 61, 55, 54, 59, 62, 56, 60 }
KEY_CODE_TO_KEY_STR = {
	[58] = "leftAlt",
	[61] = "rightAlt",
	[55] = "leftCmd",
	[54] = "rightCmd",
	[59] = "leftCtrl",
	[62] = "rightCtrl",
	[56] = "leftShift",
	[60] = "rightShift",
}
KEY_CODE_TO_MOD_TYPE = {
	[58] = "alt",
	[61] = "alt",
	[55] = "cmd",
	[54] = "cmd",
	[59] = "ctrl",
	[62] = "ctrl",
	[56] = "shift",
	[60] = "shift",
}
KEY_CODE_TO_SIBLING_KEY_CODE = {
	[58] = 61,
	[61] = 58,
	[55] = 54,
	[54] = 55,
	[59] = 62,
	[62] = 59,
	[56] = 60,
	[60] = 56,
}

KEYMAP = {
	{ "leftCmd", "u", "alt", "left" },
	{ "leftCmd+leftShift", "u", "alt+shift", "left" },
	{ "leftCmd", "i", "alt", "right" },
	{ "leftCmd+leftShift", "i", "cmd+shift", "up" },
	{ "leftCmd+rightShift", "i", "shift", "up" },
	{ "leftCmd+leftShift+rightShift", "i", "shift", "up" },
	{ "leftCmd+leftShift", "o", "alt+shift", "right" },
	{ "leftCmd", "h", nil, "left" },
	{ "leftCmd+leftShift", "h", "cmd+shift", "left" },
	{ "leftCmd", "j", nil, "down" },
	{ "leftCmd+leftShift", "j", "shift", "left" },
	{ "leftCmd+rightShift", "j", "shift", "left" },
	{ "leftCmd", "k", nil, "up" },
	{ "leftAlt", "k", "cmd", "down" },
	{ "leftCmd+leftShift", "k", "cmd+shift", "down" },
	{ "leftCmd+rightShift", "k", "shift", "down" },
	{ "leftCmd+leftShift+rightShift", "k", "shift", "down" },
	{ "leftCmd", "l", nil, "right" },
	{ "leftCmd+leftShift", "l", "shift", "right" },
	{ "leftCmd+rightShift", "l", "shift", "right" },
	{ "leftCmd", ";", "cmd", "right" },
	{ "leftCmd+leftShift", ";", "cmd+shift", "right" },
	{ "leftCmd", "'", "cmd", "right" },
	{ "leftCmd+leftShift", "'", "cmd+shift", "right" },
}

local hotkeyGroups = {}
for _, hotkeyVals in pairs(KEYMAP) do
	local fromMods, fromKey, toMods, toKey = table.unpack(hotkeyVals)
	local toKeystroke = function()
		hs.eventtap.keyStroke(toMods, toKey, 0)
	end
	local hotkey = hs.hotkey.new(fromMods, fromKey, toKeystroke, nil, toKeystroke)
	if hotkeyGroups[fromMods] == nil then
		hotkeyGroups[fromMods] = {}
	end
	table.insert(hotkeyGroups[fromMods], hotkey)
end

for _, group in pairs(hotkeyGroups) do
	for _, hotkey in ipairs(group) do
		hotkey:enable()
	end
end

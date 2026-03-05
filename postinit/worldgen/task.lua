local _G   = GLOBAL
local KEYS = _G.KEYS

AddTaskPreInit("Oasis", function(data)
	if data.keys_given ~= nil then
		table.insert(data.keys_given, KEYS.MESA)
	end
end)
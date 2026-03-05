local _G = GLOBAL

AddTaskPreInit("Oasis", function(data)
	if data.keys_given ~= nil then
		table.insert(data.keys_given, _G.KEYS.MESA)
	end

	if data.locks ~= nil then
		table.insert(data.locks, _G.LOCKS.MESA)
	end
end)
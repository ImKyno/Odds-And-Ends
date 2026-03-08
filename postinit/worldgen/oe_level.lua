AddLevelPreInitAny(function(level)
	if level.location ~= "forest" then
		return
	end

	if level.tasks ~= nil then
		table.insert(level.tasks, "Mesa")
	end
end)
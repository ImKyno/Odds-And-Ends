AddTaskSetPreInit("default", function(data)
	if data.tasks ~= nil then
		table.insert(data.tasks, "Mesa")
	end
end)
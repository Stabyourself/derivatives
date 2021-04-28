function UPDATEGROUP(group, dt)
	for i = #group, 1, -1 do
		if (group[i].update and group[i]:update(dt)) or group[i].removeMe then
            if group[i].remove then group[i]:remove() end
			table.remove(group, i)
		end
	end
end

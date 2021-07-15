function UPDATEGROUP(group, dt)
	for i = #group, 1, -1 do
		if (group[i].update and group[i]:update(dt)) or group[i].removeMe then
            if group[i].remove then group[i]:remove() end
			table.remove(group, i)
		end
	end
end

function DRAWTIMER(time, x, y)
	love.graphics.setFont(FONTS.timer)

	-- local hours = math.floor(time/3600)
	local minutes = math.floor(time/60)
	local seconds = math.floor(time%60)
	local milliseconds = math.floor(time%1*1000)

	love.graphics.print(string.format("%02d:%02d.%03d", minutes, seconds, milliseconds), x, y)
end

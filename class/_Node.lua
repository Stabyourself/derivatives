local _Node = class("_Node")

local lineWidth = 1
local circleRadius = 5

_Node.name = ""

function _Node:draw(active, x, y, w, h)
    local mx, my = self:getPosition()

    -- background
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.rectangle("fill", x, y, w, h)

    love.graphics.setColor(1, 1, 1)
    -- outline
    love.graphics.rectangle("line", x, y, w, h)
    -- crosshair
    love.graphics.rectangle("fill", x, y+h/2-lineWidth/2, w, lineWidth)
    love.graphics.rectangle("fill", x+w/2-lineWidth/2, y, lineWidth, h)

    -- name
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(self.name, x, y-15, w, "center")

    -- value marker
    if active then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(0.333, 0.333, 0.333)
    end

    love.graphics.circle("fill", x+w/2 + mx*w/2, y+h/2 + my*h/2, circleRadius)
end

return _Node

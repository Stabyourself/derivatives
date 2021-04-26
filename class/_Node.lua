local _Node = class("_Node")

local lineWidth = 1
local circleRadius = 5

_Node.name = ""

function _Node:draw(active, x, y, w, h)
    local mx, my = self:getPosition()

    -- background
    love.graphics.setColor(COLORS.derivativeBackground)
    love.graphics.rectangle("fill", x, y, w, h)

    -- circle
    love.graphics.setColor(COLORS.derivativeCenter)
    love.graphics.circle("fill", x+w/2, y+h/2, w/2)

    -- outline
    love.graphics.setColor(COLORS.derivativeBorder)
    love.graphics.rectangle("line", x, y, w, h)

    -- crosshair
    love.graphics.setColor(COLORS.derivativeCrosshair)
    love.graphics.rectangle("fill", x, y+h/2-lineWidth/2, w, lineWidth)
    love.graphics.rectangle("fill", x+w/2-lineWidth/2, y, lineWidth, h)

    -- name
    love.graphics.setColor(COLORS.text)
    love.graphics.printf(self.name, x, y-17, w, "center")

    -- value marker
    if active then
        love.graphics.setColor(COLORS.derivativeActive)
    else
        love.graphics.setColor(COLORS.derivativeInActive)
    end

    love.graphics.circle("fill", x+w/2 + mx*w/2, y+h/2 + my*h/2, circleRadius)
end

return _Node

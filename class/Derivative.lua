local _Node = require "class._Node"

local Derivative = class("Derivative", _Node)

function Derivative:initialize(input)
    self.x = 0
    self.y = 0

    self.input = input
end

function Derivative:update(dt)
    local ix, iy = self.input:getPosition()

    self.x = self.x + ix*dt
    self.y = self.y + iy*dt

    self.x = math.max(-1, math.min(1, self.x))
    self.y = math.max(-1, math.min(1, self.y))
end

function Derivative:getPosition()
    return self.x, self.y
end

return Derivative

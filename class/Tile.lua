local Tile = class("Tile")

function Tile:initialize(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
end

function Tile:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Tile

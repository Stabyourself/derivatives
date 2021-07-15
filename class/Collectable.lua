local Collectable = CLASS("Collectable")

Collectable.w = TILESIZE
Collectable.h = TILESIZE

function Collectable:initialize(game, x, y)
    self.game = game

    self.x = x
    self.y = y

    self.game.world:add(self, self.x, self.y, self.w, self.h)
end

function Collectable:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Collectable

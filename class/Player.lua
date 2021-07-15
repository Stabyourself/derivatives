local Player = CLASS("Player")
local Collectable = require "class.Collectable"

Player.w = TILESIZE
Player.h = TILESIZE

Player.speed = 250

function Player:filter(other)
    if other:isInstanceOf(Collectable) then
        return "cross"
    end

    return "slide"
end

function Player:initialize(game, input, x, y)
    self.game = game
    self.input = input

    self.x = x
    self.y = y

    self.game.world:add(self, self.x, self.y, self.w, self.h)
end

function Player:update(dt)
    local goalX, goalY
    if self.input then
        local x, y = self.input:getPosition()

        goalX = self.x + x*dt*self.speed
        goalY = self.y + y*dt*self.speed
    else
        local x, y = CONTROLS:get("movement")

        goalX = x*(TILESIZE*16-self.w)*.5 + TILESIZE*9-self.w*.5
        goalY = y*(TILESIZE*16-self.h)*.5 + TILESIZE*9-self.h*.5
    end

    local actualX, actualY, cols = self.game.world:move(self, goalX, goalY, self.filter)

    for _, col in ipairs(cols) do
        if col.other:isInstanceOf(Collectable) then
            self.game:collectThing(col.other)
        end
    end

    self.x = actualX
    self.y = actualY
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player

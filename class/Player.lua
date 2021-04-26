local Player = class("Player")

Player.w = TILESIZE
Player.h = TILESIZE

Player.speed = 250

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
        local x, y = controls:get("movement")

        goalX = x*(TILESIZE*16-self.w)*.5 + TILESIZE*9-self.w*.5
        goalY = y*(TILESIZE*16-self.h)*.5 + TILESIZE*9-self.h*.5
    end

    local actualX, actualY, cols, len = self.game.world:move(self, goalX, goalY)

    self.x = actualX
    self.y = actualY
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player

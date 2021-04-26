local Player = class("Player")

Player.w = TILESIZE
Player.h = TILESIZE

Player.speed = 250

function Player:initialize(level, input, x, y)
    self.level = level
    self.input = input

    self.x = x
    self.y = y

    self.level.world:add(self, self.x, self.y, self.w, self.h)
end

function Player:update(dt)
    local goalX, goalY
    if self.input then
        local x, y = self.input:getPosition()

        goalX = self.x + x*dt*self.speed
        goalY = self.y + y*dt*self.speed
    else
        local x, y = controls:get("movement")

        goalX = x*TILESIZE*8-self.w + TILESIZE*8
        goalY = y*TILESIZE*8-self.h + TILESIZE*8
    end

    local actualX, actualY, cols, len = self.level.world:move(self, goalX, goalY)

    self.x = actualX
    self.y = actualY
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player

local Player = class("Player")

Player.w = 50
Player.h = 50

Player.speed = 300

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

        goalX = x*375-self.w/2 + 400
        goalY = y*375-self.h/2 + 400
    end

    local actualX, actualY, cols, len = self.level.world:move(self, goalX, goalY)

    self.x = actualX
    self.y = actualY
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player

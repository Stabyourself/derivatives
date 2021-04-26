local Input = require "class.Input"
local Derivative = require "class.Derivative"
local Level = require "class.Level"
local game = gamestate.new()

local derivativeCount = 3

function game:enter()
    self.nodes = {}

    for i = 1, derivativeCount do
        if i == 1 then
            table.insert(self.nodes, 1, Input:new(controls))
        else
            table.insert(self.nodes, 1, Derivative:new(self.nodes[1]))
        end

        self.nodes[1].name = TERMS[derivativeCount-i+1]
    end

    self.level = Level:new(self, MAP)
end

function game:update(dt)
    for _, node in ipairs(self.nodes) do
        node:update(dt)
    end

    self.level:update(dt)
end

function game:draw()
    self.level:draw()

    love.graphics.push()
    local totalWidth = (#self.nodes)*110-10
    love.graphics.translate((800-totalWidth)/2, 15)

    for i = 1, #self.nodes do
        self.nodes[i]:draw(i == #self.nodes, (i-1)*110, 0, 100, 100)
    end

    love.graphics.pop()
end

return game

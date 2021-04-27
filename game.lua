local Player = require "class.Player"
local bump = require "lib.bump"
local Input = require "class.Input"
local Derivative = require "class.Derivative"
local Level = require "class.Level"
local game = {}

function game:enter(current, level, map)
    self.nodes = {}

    for i = 1, level.derivatives do
        if i == 1 then
            table.insert(self.nodes, 1, Input:new(CONTROLS))
        else
            table.insert(self.nodes, 1, Derivative:new(self.nodes[1]))
        end

        self.nodes[1].name = TERMS[level.derivatives-i+1]
    end

    self.world = bump.newWorld(TILESIZE*2)

    self.level = Level:new(self, map)

    self.player = Player:new(self, self.nodes[1], #self.level.map[1]/2*TILESIZE-TILESIZE*.5, #self.level.map/2*TILESIZE-TILESIZE*.5)
end

function game:update(dt)
    for _, node in ipairs(self.nodes) do
        node:update(dt)
    end

    self.player:update(dt)
end

function game:draw()
    -- Derivates
    love.graphics.push()
    local totalWidth = (#self.nodes)*110-10
    love.graphics.translate(50, 20)

    love.graphics.setFont(FONTS.derivatives)
    for i = 1, #self.nodes do
        self.nodes[i]:draw(i == #self.nodes, 0, (i-1)*118, DERIVATIVESIZE, DERIVATIVESIZE)
    end

    love.graphics.pop()

    -- Level
    love.graphics.push()
    love.graphics.translate(200, 20)

    love.graphics.setColor(COLORS.tiles)
    self.level:draw()

    love.graphics.setColor(COLORS.player)
    self.player:draw()

    love.graphics.setColor(COLORS.text)
    love.graphics.setFont(FONTS.figure)
    love.graphics.printf("Fig. 1: Position", 0, 18*TILESIZE, 18*TILESIZE, "left")

    love.graphics.pop()
end

return game

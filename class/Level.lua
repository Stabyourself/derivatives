local Player = require "class.Player"
local Level = class("Level")
local bump = require "lib.bump"
local Tile = require "class.Tile"

function Level:initialize(game, mapStrings)
    self.game = game
    self.mapStrings = mapStrings
    self.world = bump.newWorld(100)
    self.map = {}

    for x = 1, #self.mapStrings[1] do
        self.map[x] = {}
    end

    for y, row in ipairs(self.mapStrings) do
        for x = 1, #row do
            local char = string.sub(row, x, x)

            self.map[x][y] = false

            if char == "#" then
                local cox = (x-2)*50
                local coy = (y-2)*50

                self.map[x][y] = Tile:new(cox, coy, 50, 50)
                self.world:add(self.map[x][y], cox, coy, 50, 50)
            end
        end
    end

    self.player = Player:new(self, self.game.nodes[1], 375, 375)
end

function Level:update(dt)
    self.player:update(dt)
end

function Level:draw()
    for x = 1, #self.map do
        for y = 1, #self.map[x] do
            if self.map[x][y] then
                self.map[x][y]:draw()
            end
        end
    end

    self.player:draw()
end

return Level

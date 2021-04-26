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
                local cox = (x-1)*TILESIZE
                local coy = (y-1)*TILESIZE

                self.map[x][y] = Tile:new(cox, coy, TILESIZE, TILESIZE)
                self.world:add(self.map[x][y], cox, coy, TILESIZE, TILESIZE)
            end
        end
    end

    self.player = Player:new(self, self.game.nodes[1], #self.map[1]/2*TILESIZE-TILESIZE*.5, #self.map/2*TILESIZE-TILESIZE*.5)
end

function Level:update(dt)
    self.player:update(dt)
end

function Level:draw()
    love.graphics.setColor(COLORS.tiles)
    for x = 1, #self.map do
        for y = 1, #self.map[x] do
            if self.map[x][y] then
                self.map[x][y]:draw()
            end
        end
    end

    love.graphics.setColor(COLORS.player)
    self.player:draw()
end

return Level

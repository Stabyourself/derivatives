local Level = CLASS("Level")
local Tile = require "class.Tile"

function Level:initialize(game, mapStrings)
    self.game = game
    self.mapStrings = mapStrings
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
                self.game.world:add(self.map[x][y], cox, coy, TILESIZE, TILESIZE)
            end
        end
    end
end

function Level:draw()
    for x = 1, #self.map do
        for y = 1, #self.map[x] do
            if self.map[x][y] then
                self.map[x][y]:draw()
            end
        end
    end
end

return Level

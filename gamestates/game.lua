local Player = require "class.Player"
local Collectable = require "class.Collectable"
local bump = require "lib.bump"
local Input = require "class.Input"
local Definition = require "class.Definition"
local Derivative = require "class.Derivative"
local gamestateController = require "gamestateController"
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

    local cx = #self.level.map[1]/2*TILESIZE-TILESIZE*.5
    local cy = #self.level.map/2*TILESIZE-TILESIZE*.5

    self.player = Player:new(self, self.nodes[1], cx, cy)

    -- make some things to collect that look nothing like the player
    self.collectables = {
        Collectable:new(self, cx, TILESIZE),
        Collectable:new(self, TILESIZE, cy),
        Collectable:new(self, (#self.level.map[1]-2)*TILESIZE, cy),
        Collectable:new(self, cx, (#self.level.map-2)*TILESIZE),
    }

    self.definition = Definition:new(level.title, level.excerpt, FONTS.smol, 2)

    self.finalBossSpawned = false
    self.time = 0
    self.moved = false
end

function game:update(dt)
    for _, node in ipairs(self.nodes) do
        node:update(dt)
    end

    self.definition:update(dt)
    self.player:update(dt)
    UPDATEGROUP(self.collectables, dt)

    if #self.collectables > 0 then
        self.time = self.time + dt
    end
end

function game:draw()
    -- left side
    love.graphics.push()
    love.graphics.translate(40, 20)

    -- Derivates
    love.graphics.setFont(FONTS.derivatives)
    for i = 1, #self.nodes do
        self.nodes[i]:draw(i == #self.nodes, 0, (i-1)*118, DERIVATIVESIZE, DERIVATIVESIZE)
    end

    love.graphics.pop()



    -- center
    love.graphics.push()
    love.graphics.translate(40*2 + DERIVATIVESIZE, 20)

    -- Level
    love.graphics.setColor(COLORS.tiles)
    self.level:draw()

    -- Collectables
    love.graphics.setColor(COLORS.collectables)
    for _, collectable in ipairs(self.collectables) do
        collectable:draw()
    end

    -- Player
    love.graphics.setColor(COLORS.player)
    self.player:draw()

    -- Heading
    love.graphics.setColor(COLORS.text)
    love.graphics.setFont(FONTS.figure)
    love.graphics.printf("Fig. 1: Position", 0, 18*TILESIZE, 18*TILESIZE, "left")

    love.graphics.pop()


    -- right side
    love.graphics.push()
    local x = 40*2 + DERIVATIVESIZE + 18*TILESIZE+30
    love.graphics.translate(x, 0)

    -- timer
    love.graphics.setFont(FONTS.timerTitle)
    love.graphics.print("Current:", 0, 14)
    DRAWTIMER(self.time, 0, 34)

    love.graphics.setFont(FONTS.timerTitle)
    love.graphics.print("Total:", 0, 110)
    DRAWTIMER(gamestateController.totalTime, 0, 130)

    -- Definition
    self.definition:draw(0, 220, 1280-x-30)

    love.graphics.pop()
end

function game:collectThing(collectable)
    self.world:remove(collectable)
    collectable.removeMe = true

    if #self.collectables == 1 then -- all collected
        if not self.finalBossSpawned then
            local cx = #self.level.map[1]/2*TILESIZE-TILESIZE*.5
            local cy = #self.level.map/2*TILESIZE-TILESIZE*.5

            table.insert(self.collectables, Collectable:new(self, cx, cy))

            self.finalBossSpawned = true
        else
            gamestateController:addTime(self.time)
            gamestateController:nextLevel()
        end
    end
end

return game

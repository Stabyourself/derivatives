require "run"
CLASS = require "lib.middleclass"
if love.filesystem.getInfo("environment.lua") then
    require "environment"
end
require "variables"
require "levels"

local baton = require "lib.baton"
CONTROLS = baton.new(require "controls")
local timer = require "lib.timer"

GAMESTATE = require "lib.gamestate"
local game = require "game"
local menu = require "menu"

local background = love.graphics.newImage("img/background.png")
background:setWrap("repeat")
local backgroundQuad = love.graphics.newQuad(0, 0, 1280, 720, 200, 200)

function love.load()
    GAMESTATE.registerEvents()
    GAMESTATE.switch(menu)
    -- GAMESTATE.switch(game, LEVELS[3], MAPS[1])

    love.graphics.setBackgroundColor(COLORS.background)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(background, backgroundQuad)
end

function love.update(dt)
    CONTROLS:update()
    timer.update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
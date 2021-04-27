CLASS = require "lib.middleclass"
GAMESTATE = require "lib.gamestate"
require "variables"
require "levels"

local baton = require "lib.baton"
CONTROLS = baton.new(require "controls")

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
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
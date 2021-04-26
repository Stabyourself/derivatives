class = require "lib.middleclass"
gamestate = require "lib.gamestate"
require "variables"

local baton = require "lib.baton"
controls = baton.new(require "controls")

local game = require "game"

local background = love.graphics.newImage("img/background.png")
background:setWrap("repeat")
local backgroundQuad = love.graphics.newQuad(0, 0, 1280, 720, 200, 200)

function love.load()
    gamestate.registerEvents()
    gamestate.switch(game)

    love.graphics.setBackgroundColor(COLORS.background)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(background, backgroundQuad)
end

function love.update(dt)
    controls:update()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
require "run"
CLASS = require "lib.middleclass"
local gamestateController = require "gamestateController"
if love.filesystem.getInfo("environment.lua") then
    require "environment"
end
require "variables"
require "levels"

local baton = require "lib.baton"
CONTROLS = baton.new(require "controls")
local timer = require "lib.timer"

GAMESTATE = require "lib.gamestate"
local game = require "gamestates.game"
local menu = require "gamestates.menu"
INSPECT = function(v, o) print(require "lib.inspect"(v, o)) end -- good code

local background = love.graphics.newImage("img/background.png")
background:setWrap("repeat")
local backgroundQuad = love.graphics.newQuad(0, 0, 1280, 720, 200, 200)

FADING = {
    a = 0
}
FLOWCONTROLLERS = {}

function love.load()
    GAMESTATE.registerEvents()
    GAMESTATE.switch(menu)
    gamestateController:nextLevel()

    love.graphics.setBackgroundColor(COLORS.background)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(background, backgroundQuad)
end

function love.postDraw()
    love.graphics.setColor(1, 1, 1, FADING.a)
    love.graphics.draw(background, backgroundQuad)
end

function love.update(dt)
    CONTROLS:update()
    timer.update(dt)
    UPDATEGROUP(FLOWCONTROLLERS, dt)

    love.window.setTitle("Derivatives " .. love.timer.getFPS())
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

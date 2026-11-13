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

-- tiled by hand: "repeat" wrapping needs power-of-two textures on the web (WebGL 1)
local function drawBackground()
    local w, h = background:getDimensions()
    for x = 0, 1280-1, w do
        for y = 0, 720-1, h do
            love.graphics.draw(background, x, y)
        end
    end
end

FADING = {
    a = 0
}
GAMEFADING = {
    a = 0
}
FLOWCONTROLLERS = {}

ISWEB = love.system.getOS() == "Web"

if ISWEB then
    -- draw at the browser's real resolution, with sharper fonts
    local sharpFonts = {}
    local setFont = love.graphics.setFont
    love.graphics.setFont = function(font)
        setFont(sharpFonts[font] or font)
    end

    function fitWindow(w, h)
        WEBSCALE = math.min(w/1280, h/720)
        local pixels = WEBSCALE*love.graphics.getDPIScale()
        love.graphics.setLineWidth(math.max(1, math.floor(pixels+.5))/pixels)
        for font, spec in pairs(FONTSPECS) do
            if sharpFonts[font] then
                sharpFonts[font]:release()
            end
            sharpFonts[font] = love.graphics.newFont(spec[1], spec[2], "normal", pixels)
        end
    end

    function love.resize(w, h)
        fitWindow(w, h)
    end
end

function love.load()
    if ISWEB then
        fitWindow(love.graphics.getDimensions())
    end
    GAMESTATE.registerEvents()
    GAMESTATE.switch(menu)
    -- gamestateController:nextLevel()

    love.graphics.setBackgroundColor(COLORS.background)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    drawBackground()
end

function love.postDraw()
    love.graphics.setColor(1, 1, 1, FADING.a)
    drawBackground()
end

function love.update(dt)
    CONTROLS:update()
    timer.update(dt)
    UPDATEGROUP(FLOWCONTROLLERS, dt)
end

function love.keypressed(key)
    -- if key == "escape" then
    --     love.event.quit()
    -- end

    -- if key == "p" then
    --     game:endLevel()
    -- end
end

class = require "lib.middleclass"
gamestate = require "lib.gamestate"
require "variables"

local baton = require "lib.baton"
controls = baton.new(require "controls")

local game = require "game"

function love.load()
    gamestate.registerEvents()
    gamestate.switch(game)
end

function love.update(dt)
    controls:update(dt)
end
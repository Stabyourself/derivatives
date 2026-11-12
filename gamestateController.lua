local FlowController3 = require "lib.FlowController3"
local timer = require "lib.timer"
local gamestateController = {}

gamestateController.level = 0
gamestateController.map = 1
gamestateController.totalTime = 0

function gamestateController:nextLevel()
    local game = require "gamestates.game"
    local win = require "gamestates.win"


    if (self.level < #LEVELS) then
        self.level = self.level + 1

        timer.tween(1, FADING, {a = 0}, 'linear')
        timer.tween(1, GAMEFADING, {a = 0}, 'linear')

        GAMESTATE.switch(game, LEVELS[self.level], MAPS[self.map])
    else
        GAMESTATE.switch(win, LEVELS[self.level], MAPS[self.map])
    end
end

function gamestateController:nextMap()
    local game = require "gamestates.game"

    self.map = self.map + 1
    self.level = 1

    local flowController = FlowController3:new()
    table.insert(FLOWCONTROLLERS, flowController)


    timer.tween(1, FADING, {a = 0}, 'linear')
    timer.tween(1, GAMEFADING, {a = 0}, 'linear')

    GAMESTATE.switch(game, LEVELS[self.level], MAPS[self.map])
end



function gamestateController:addTime(timeAdd)
    self.totalTime = self.totalTime + timeAdd
end

return gamestateController

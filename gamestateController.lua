local FlowController3 = require "lib.FlowController3"
local timer = require "lib.timer"
local gamestateController = {}

gamestateController.level = 0

function gamestateController:nextLevel()
    local game = require "gamestates.game"

    self.level = self.level + 1
    local level = LEVELS[self.level]

    local flowController = FlowController3:new()
    table.insert(FLOWCONTROLLERS, flowController)

    flowController:addWait(1)
    flowController:addCall(function()
        timer.tween(0.5, FADING, {a = 0}, 'linear')
        GAMESTATE.switch(game, level, MAPS[1])
    end)
end

return gamestateController

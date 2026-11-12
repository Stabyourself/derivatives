local gamestateController = require "gamestateController"
local FlowController3 = require "lib.FlowController3"
local timer = require "lib.timer"
local win = {}

function win:enter(current)

end

function win:update(dt)

end

function win:draw()
    love.graphics.setFont(FONTS.big.title)
    love.graphics.setColor(COLORS.text)
    love.graphics.printf("You win!", 0, 100, 1280, "center")

    if (gamestateController.map == 2) then
        love.graphics.setFont(FONTS.big.regular)
        love.graphics.printf("(again)", 0, 170, 1280, "center")
    end

    love.graphics.setFont(FONTS.big.regular)
    love.graphics.setColor(COLORS.timerTitle)
    love.graphics.printf("Final time:", 0, 310, 1280, "center")


    love.graphics.setColor(COLORS.text)
    love.graphics.setFont(FONTS.big.title)
    local time = gamestateController.totalTime
	local minutes = math.floor(time/60)
	local seconds = math.floor(time%60)
	local milliseconds = math.floor(time%1*1000)

    love.graphics.printf(string.format("%02d:%02d.%03d", minutes, seconds, milliseconds), 0, 330, 1280, "center")

    love.graphics.setFont(FONTS.big.regular)
    love.graphics.setColor(COLORS.timerTitle)
    local s = "Press Enter for new quest"

    if (gamestateController.map == #MAPS) then
        s = "That's all."
    end

    love.graphics.printf(s, 0, 550, 1280, "center")
end

function win:keypressed(key)
    if key == "return" then
        if (gamestateController.map < #MAPS) then
            GAMEFADING.a = 0;

            local flowController = FlowController3:new()
            table.insert(FLOWCONTROLLERS, flowController)

            timer.tween(1, FADING, {a = 1}, 'linear')
            flowController:addWait(1.5)

            flowController:addCall(function()
                gamestateController:nextMap()
            end)
        end
    end
end

return win

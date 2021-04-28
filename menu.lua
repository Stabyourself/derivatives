local Definition = require "class.Definition"
local FlowController3 = require "lib.FlowController3"
local timer = require "lib.timer"

local menu = {}

local excerpt = "In mathematics, the **derivative** of a function of a real variable measures the sensitivity to change of the function value (output value) with respect to a change in its argument (input value). \n Derivatives are a fundamental tool of calculus."

local music = love.audio.newSource("sound/menu.ogg", "stream")

function menu:init()
end

function menu:enter(current)
    self.promptA = 0
    self.promptFlashTimer = 0
    self.promptFlashA = 0

    self.flowController = FlowController3()

    self.flowController:addWait(0.5)
    self.flowController:addCall(function()
        music:play()
        self.definition = Definition:new("Derivative", excerpt)
    end)
    self.flowController:addWait(18.4)
    self.flowController:addCall(function()
        timer.tween(0.5, self, {promptA = 1}, 'linear')
    end)
end

function menu:update(dt)
    self.flowController:update(dt)
    if self.definition then
        self.definition:update(dt)
    end

    self.promptFlashTimer = self.promptFlashTimer + dt

    self.promptFlashA = 1-(math.sin(self.promptFlashTimer*5)+1)*.5*0.6
end

function menu:draw()
    if self.definition then
        self.definition:draw((1280-950)/2, 120, 950)
    end

    love.graphics.setFont(FONTS.excerpt)
    local r, g, b = unpack(COLORS.prompt)
    love.graphics.setColor(r, g, b, self.promptA*self.promptFlashA)

    love.graphics.printf("Press anything to begin", 0, 540, 1280, "center")
end

return menu

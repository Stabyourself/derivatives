-- the shittiest rich text parser ever written
local FlowController3 = require "lib.FlowController3"
local timer = require "lib.timer"

local Token = CLASS("Token")

function Token:initialize(s, fonts)
    self.s = s

    self.chars = 0

    -- find the right font
    if string.find(self.s, "[*][*]") then
        self.font = fonts.bold
    elseif string.find(self.s, "[*]") then
        self.font = fonts.italic
    else
        self.font = fonts.regular
    end

    self.s = self.s:gsub('[*]', '')

    self.w = self.font:getWidth(self.s)
end

function Token:setChars(i)
    self.chars = i

    return string.sub(self.s, i, i)
end

function Token:print(x, y)
    love.graphics.setFont(self.font)

    love.graphics.print(string.sub(self.s, 1, self.chars), x, y)
end



local Definition = CLASS("Definition")

Definition.from = "From Wikipedia, the free encyclopedia"

local charTime = 1/21.9

function Definition:initialize(title, excerpt, fonts, speedMul)
    self.title = title
    self.excerpt = excerpt
    self.fonts = fonts
    self.speedMul = speedMul or 1

    self.titleFontHeight = self.fonts.title:getHeight()
    self.excerptFontHeight = self.fonts.regular:getHeight()

    self.charTimer = 0
    self.word = 1

    self.excerptGoing = false
    self.titleA = 0
    self.fromWikipediaA = 0
    self.lineWidth = 0

    self.spaceWidth = self.fonts.regular:getWidth(" ")

    self:tokenize()

    self.flowController = FlowController3()

    self.flowController:addCall(function()
        timer.tween(1/self.speedMul, self, {titleA = 1}, 'linear')
    end)

    self.flowController:addWait(2.8)
    self.flowController:addCall(function()
        timer.tween(2.9/self.speedMul, self, {lineWidth = 1}, 'out-quad')
        timer.tween(1/self.speedMul, self, {fromWikipediaA = 1}, 'linear')
    end)

    self.flowController:addWait(3.3)
    self.flowController:addCall(function()
        self.excerptGoing = true
    end)
end

function Definition:tokenize()
    self.tokens = {}

    for token in string.gmatch(self.excerpt, "[^ ]+") do
        table.insert(self.tokens, Token:new(token, self.fonts))
    end
end

function Definition:update(dt)
    dt = dt * self.speedMul

    self.flowController:update(dt)

    if self.excerptGoing and self.word <= #self.tokens then
        self.charTimer = self.charTimer + dt

        while self.charTimer >= charTime and self.word <= #self.tokens do
            local token = self.tokens[self.word]

            if token.chars < #token.s then
                local char = token:setChars(token.chars + 1)

                if char == "," or char == ";" then
                    self.charTimer = self.charTimer - 0.3 -- wait on commas
                elseif char == "." then
                    self.charTimer = self.charTimer - 0.5 -- wait more on periods
                elseif char == " " then
                    self.charTimer = self.charTimer + charTime -- no wait on spaces
                end
            else
                self.word = self.word + 1
            end

            self.charTimer = self.charTimer - charTime
        end
    end
end

function Definition:draw(x, y, limit)
    love.graphics.push()
    love.graphics.translate(x, y)

    -- underline
    love.graphics.setColor(COLORS.headlineLine)
    love.graphics.rectangle("fill", 0, self.titleFontHeight*0.95, limit*self.lineWidth, 2)

    -- title
    love.graphics.setFont(self.fonts.title)
    local r, g, b = unpack(COLORS.text)
    love.graphics.setColor(r, g, b, self.titleA)
    love.graphics.print(self.title, 0, 0)

    love.graphics.translate(0, self.titleFontHeight*0.97)

    local r, g, b = unpack(COLORS.fromWikipedia)
    love.graphics.setColor(r, g, b, self.fromWikipediaA)
    love.graphics.setFont(self.fonts.fromWikipedia)
    love.graphics.print(self.from, 0, 0)

    love.graphics.translate(0, self.titleFontHeight*.6)
    love.graphics.setColor(COLORS.text)

    local cursorX = 0
    local cursorY = 0

    for _, token in ipairs(self.tokens) do
        if string.find(token.s, "\n") then
            cursorX = 0
            cursorY = cursorY + self.excerptFontHeight*1.7
        else
            if cursorX + token.w > limit then
                cursorX = 0
                cursorY = cursorY + self.excerptFontHeight*1.2
            end

            token:print(cursorX, cursorY)
            cursorX = cursorX + token.w + self.spaceWidth
        end
    end

    love.graphics.pop()
end

return Definition

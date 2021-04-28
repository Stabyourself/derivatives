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

    -- append space unless it's a \n
    if not string.find(self.s, "\n") then
        self.s = self.s .. " "
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

Definition.fonts = {
    title = FONTS.title,
    fromWikipedia = FONTS.fromWikipedia,
    regular = FONTS.excerpt,
    bold = FONTS.excerptBold,
    italic = FONTS.excerptItalic,
}

local titleFontHeight = Definition.fonts.title:getHeight()
local excerptFontHeight = Definition.fonts.regular:getHeight()

local charTime = 1/21.9

function Definition:initialize(title, excerpt)
    self.title = title
    self.excerpt = excerpt

    self.charTimer = 0
    self.word = 1

    self.excerptGoing = false
    self.titleA = 0
    self.fromWikipediaA = 0
    self.lineWidth = 0

    self:tokenize()

    self.flowController = FlowController3()

    self.flowController:addCall(function()
        timer.tween(1, self, {titleA = 1}, 'linear')
    end)

    self.flowController:addWait(2.8)
    self.flowController:addCall(function()
        timer.tween(2.9, self, {lineWidth = 1}, 'out-quad')
        timer.tween(1, self, {fromWikipediaA = 1}, 'linear')
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
    self.flowController:update(dt)

    if self.excerptGoing and self.word <= #self.tokens then
        self.charTimer = self.charTimer + dt

        while self.charTimer >= charTime do
            local token = self.tokens[self.word]

            if token.chars < #token.s then
                local char = token:setChars(token.chars + 1)

                if char == "," then
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

    love.graphics.setFont(self.fonts.title)
    local r, g, b = unpack(COLORS.text)
    love.graphics.setColor(r, g, b, self.titleA)

    love.graphics.print(self.title, 0, 0)

    love.graphics.setColor(COLORS.headlineLine)
    love.graphics.rectangle("fill", 0, titleFontHeight*0.95, limit*self.lineWidth, 1)

    love.graphics.translate(0, titleFontHeight*0.97)

    local r, g, b = unpack(COLORS.fromWikipedia)
    love.graphics.setColor(r, g, b, self.fromWikipediaA)
    love.graphics.setFont(self.fonts.fromWikipedia)
    love.graphics.print(self.from, 0, 0)

    love.graphics.translate(0, titleFontHeight*.6)
    love.graphics.setColor(COLORS.text)

    local cursorX = 0
    local cursorY = 0

    for _, token in ipairs(self.tokens) do
        if string.find(token.s, "\n") then
            cursorX = 0
            cursorY = cursorY + excerptFontHeight*1.7
        else
            if cursorX + token.w > limit then
                cursorX = 0
                cursorY = cursorY + excerptFontHeight*1.2
            end

            token:print(cursorX, cursorY)
            cursorX = cursorX + token.w
        end
    end

    love.graphics.pop()
end

return Definition

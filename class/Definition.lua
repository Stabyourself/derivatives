-- the shittiest rich text parser ever written

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

    local len = math.min(#self.s)
    love.graphics.print(string.sub(self.s, 1, self.chars), x, y)
end



local Definition = CLASS("Definition")

Definition.from = "From Wikipedia, the free encyclopedia"

Definition.fonts = {
    title = FONTS.title,
    regular = FONTS.excerpt,
    bold = FONTS.excerptBold,
    italic = FONTS.excerptItalic,
}

local charTime = 1/25

function Definition:initialize(title, excerpt)
    self.title = title
    self.excerpt = excerpt

    self.charTimer = 0
    self.word = 1

    self:tokenize()
end

function Definition:tokenize()
    self.tokens = {}

    for token in string.gmatch(self.excerpt, "[^%s]+") do
        table.insert(self.tokens, Token:new(token .. " ", self.fonts))
    end
end

function Definition:update(dt)
    if self.word <= #self.tokens then
        self.charTimer = self.charTimer + dt

        while self.charTimer >= charTime do
            local token = self.tokens[self.word]

            if token.chars < #token.s then
                local char = token:setChars(token.chars + 1)

                if char == "," then
                    self.charTimer = self.charTimer - 0.3
                elseif char == "." then
                    self.charTimer = self.charTimer - 0.5
                elseif char == " " then
                    self.charTimer = self.charTimer + charTime
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
    love.graphics.setColor(COLORS.text)

    love.graphics.print(self.title, 0, 0)

    love.graphics.setColor(COLORS.headlineLine)
    love.graphics.rectangle("fill", 0, 54, limit, 1)

    love.graphics.translate(0, 56)

    love.graphics.setColor(COLORS.fromWikipedia)
    love.graphics.setFont(FONTS.fromWikipedia)
    love.graphics.print(self.from, 0, 0)

    love.graphics.translate(0, 30)
    love.graphics.setColor(COLORS.text)

    local cursorX = 0
    local cursorY = 0

    for _, token in ipairs(self.tokens) do
        if cursorX + token.w > limit then
            cursorX = 0
            cursorY = cursorY + 30
        end

        token:print(cursorX, cursorY)

        cursorX = cursorX + token.w
    end

    love.graphics.pop()
end

return Definition

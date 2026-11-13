TERMS = {
    "Velocity",
    "Acceleration",
    "Jerk",
    "Snap",
    "Crackle",
    "Pop",
}

DERIVATIVESIZE = 90
TILESIZE = 36

FONTSPECS = {} -- for the sharp web fonts
local function newFont(file, size)
    local font = love.graphics.newFont(file, size)
    FONTSPECS[font] = {file, size}
    return font
end

FONTS = {
    derivatives = newFont("font/LinLibertine_RB.ttf", 14),
    figure = newFont("font/LinLibertine_RBI.ttf", 32),
    timerTitle = newFont("font/LinLibertine_DR.ttf", 32),
    timer = newFont("font/LinLibertine_aDRS.ttf", 70),

    big = {
        title = newFont("font/LinLibertine_aDRS.ttf", 70),
        regular = newFont("font/LinLibertine_DR.ttf", 32),
        bold = newFont("font/LinLibertine_RB.ttf", 32),
        italic = newFont("font/LinLibertine_RZI.ttf", 32),
        fromWikipedia = newFont("font/LinLibertine_R.ttf", 16),
    },

    smol = {
        title = newFont("font/LinLibertine_aDRS.ttf", 35),
        regular = newFont("font/LinLibertine_DR.ttf", 20),
        bold = newFont("font/LinLibertine_RB.ttf", 20),
        italic = newFont("font/LinLibertine_RZI.ttf", 20),
        fromWikipedia = newFont("font/LinLibertine_R.ttf", 14),
    }
}

local red = {0.70000, 0.20000, 0.20000, 1}
local green = {0.20000, 0.70000, 0.20000, 1}
local blue = {0.20000, 0.20000, 0.70000, 1}
local black = {0.12549, 0.12941, 0.13333, 1}
local lightGray = {0.78431, 0.80000, 0.81961, 1}
local gray = {0.63529, 0.66275, 0.69412, 1}
local darkGray = {0.4, 0.4, 0.4, 1}
local white = {0.97255, 0.97647, 0.98039, 1}

COLORS = {
    background = {1, 1, 1, 1},

    derivativeBackground = lightGray,
    derivativeCenter = white,
    derivativeCrosshair = lightGray,
    derivativeBorder = black,

    derivativeActive = red,
    derivativeInActive = black,

    text = black,
    headlineLine = gray,
    fromWikipedia = darkGray,
    prompt = darkGray,

    tiles = black,
    player = red,
    collectables = blue,

    timerTitle = darkGray,
    timer = black,
}

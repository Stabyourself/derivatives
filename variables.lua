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

FONTS = {
    derivatives = love.graphics.newFont("font/LinLibertine_RB.ttf", 14),
    figure = love.graphics.newFont("font/LinLibertine_RBI.ttf", 32),
    title = love.graphics.newFont("font/LinLibertine_aDRS.ttf", 70),
    excerpt = love.graphics.newFont("font/LinLibertine_DR.ttf", 32),
    excerptBold = love.graphics.newFont("font/LinLibertine_RB.ttf", 32),
    excerptItalic = love.graphics.newFont("font/LinLibertine_RZI.ttf", 32),
    fromWikipedia = love.graphics.newFont("font/LinLibertine_R.ttf", 16),
}

local red = {0.70000, 0.20000, 0.20000, 1}
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
}

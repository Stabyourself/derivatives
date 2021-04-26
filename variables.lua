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

MAP = {
    "##################",
    "#                #",
    "#                #",
    "#                #",
    "#                #",
    "#                #",
    "#      #  #      #",
    "#     ##  ##     #",
    "#                #",
    "#                #",
    "#     ##  ##     #",
    "#      #  #      #",
    "#                #",
    "#                #",
    "#                #",
    "#                #",
    "#                #",
    "##################",
}

FONTS = {
    derivatives = love.graphics.newFont("font/LinLibertine_RB.ttf", 14),
    figure = love.graphics.newFont("font/LinLibertine_RBI.ttf", 32),
}

COLORS = {
    background = {1, 1, 1, 1},
    derivativeBorder = {0.78431, 0.80000, 0.81961, 1},
    derivativeBackground = {0.97255, 0.97647, 0.98039, 1},
    text = {0.12549, 0.12941, 0.13333, 1},

    tiles = {0.12549, 0.12941, 0.13333, 1},
    player = {0.70000, 0.20000, 0.20000, 1},
}

return {
    controls = {
        left = {'sc:a', 'sc:left', 'axis:leftx-', 'button:dpleft'},
        right = {'sc:d', 'sc:right', 'axis:leftx+', 'button:dpright'},
        up = {'sc:w', 'sc:up', 'axis:lefty-', 'button:dpup'},
        down = {'sc:s', 'sc:down', 'axis:lefty+', 'button:dpdown'},
    },
    pairs = {
        movement = {'left', 'right', 'up', 'down'},
    },
    joystick = love.joystick.getJoysticks()[1],
    deadzone = 0.3,
}
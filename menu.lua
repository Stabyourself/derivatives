local Definition = require "class.Definition"

local menu = {}

local excerpt = "In mathematics, the **derivative** of a function of a real variable measures the sensitivity to change of the function value (output value) with respect to a change in its argument (input value). Derivatives are a fundamental tool of calculus."

function menu:init()
    self.definition = Definition:new("Derivative", excerpt)
end

function menu:enter(current)

end

function menu:update(dt)
    self.definition:update(dt)
end

function menu:draw()
    self.definition:draw((1280-700)/2, 170, 700)
end

return menu

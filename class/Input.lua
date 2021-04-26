local _Node = require "class._Node"

local Input = class("Input", _Node)

Input.name = "Input"

function Input:initialize(input)
    self.input = input
end

function Input:update(dt) end

function Input:getPosition()
    return self.input:get("movement")
end

return Input

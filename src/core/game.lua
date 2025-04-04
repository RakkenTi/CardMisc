--- Core game lua file.
--- main.lua is seperate as it is the entry point of the program.
--- This file should act as the center point of the game.

local game = {}
local utils = require("src.shared.utils.utils")
local vector2 = require("src.shared.utils.vector2")
local rect = require("src.modules.rect")
local spring = require("src.shared.utils.spring")
local cards = {}
local cardSpring = spring.new(vector2.new(), vector2.new())
local card = rect.new(
    vector2.new(0.5, 0.5),
    vector2.new(250, 250)
)
local velocity = vector2.new()

--- love.load()
function game.init()
    card:setAnchor(vector2.new(0.5, 0.5))
    cardSpring:setEndPos(vector2.new(0.5, 0.5))
    cardSpring:setForce(250)
    cardSpring:setDamping(0.75)
end

local deltapos = vector2.new()
--- love.update()
function game.update(dt)

    local mousePos = vector2.new(love.mouse.getPosition())
    local scaledMousePos = vector2.new(utils.getMouseScalePos())
    local cardPos = card:getPos()
    local diffPos = scaledMousePos - cardPos
    local centerPos = vector2.new(0.5, 0.5)

    if (card:isInside(mousePos) and love.mouse.isDown(1)) then
        card:setOffset(diffPos)
        card:setPos(scaledMousePos)
        cardSpring:setEndPos(scaledMousePos)
        return
    end

    if ((card:getPos() - centerPos).Magnitude > 0.001) then
        local oldPos = card:getPos()
        --card:setPos(utils.lerp(card:getPos(), centerPos, .02))
        deltapos = oldPos - card:getPos()
    else
        card:setPos(centerPos)
    end

    cardSpring:setTargetPos(centerPos)
    local newpos = cardSpring:update(dt)
    card:setPos(newpos)

    card:clearOffset()
end

--- love.draw()
function game.draw()
    card:draw()
end

--- love.exit()
function game.exit()

end

return game
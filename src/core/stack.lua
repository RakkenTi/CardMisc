--- Core game lua file.
--- main.lua is seperate as it is the entry point of the program.
--- This file should act as the center point of the game.

--// Modules
local utils = require("src.shared.utils.utils")
local vector2 = require("src.shared.utils.vector2")
local rect = require("src.modules.rect")
local spring = require("src.shared.utils.spring")

--// Internals
local deck = {}

local CARD_ORIGIN = vector2.new(0.5, 0.95)
local CARD_ANCHOR = vector2.new(0.5,1)
local CARD_SIZE = vector2.new(0.01, 0.025) * 10
local CARD_DIRECTION_FACTOR = -1
local CORNER_RADIUS = 4
local CARD_GAP = 0.01 / 2
local CARD_COUNT = 100

local selectedCard = nil

--// Game
local game = {}

--- love.load()
function game.init()
    -- Create cards
    for i = 1, CARD_COUNT do
        local size = CARD_SIZE
        local pos = vector2.new(CARD_ORIGIN.x, CARD_ORIGIN.y + CARD_GAP * i * CARD_DIRECTION_FACTOR)
        local card = rect.new(pos, size)
        card:setCornerRadius(CORNER_RADIUS)
        card:setAnchor(CARD_ANCHOR)
        card:setColour({love.math.random(), love.math.random(), love.math.random()})

        local cardSpring = spring.new()
        cardSpring:setEndPos(CARD_ORIGIN)
        cardSpring:setTargetPos(pos)

        table.insert(deck, { card, cardSpring, pos, i })
    end
end

--- love.update()
function game.update(dt)
    local mousePos = vector2.new(love.mouse.getPosition())
    local scaledMousePos = vector2.new(utils.getMouseScalePos())
    for i, deckEntry in ipairs(deck) do

        --- @type Vector2
        local cardOrigin = deckEntry[3]
        --- @type Rect
        local card = deckEntry[1]
        card:update()
        --- @type springClass
        local cardSpring = deckEntry[2]

        if ((card:isInside(mousePos) and love.mouse.isDown(1)) or ((selectedCard == card) and love.mouse.isDown(1))) then

            selectedCard = card

            local oldTPos = i
            local newTPos = 1

            table.insert(deck, newTPos, table.remove(deck, oldTPos))
            cardSpring:setForce(25)
            cardSpring:setDamping(0.85)
            cardSpring:setTargetPos(scaledMousePos)
            cardSpring:setEndPos(card:getPos())

            local newPos = cardSpring:update(dt)
            card:setPos(newPos)
            return
        end

        selectedCard = nil
        cardSpring:setForce(25)
        cardSpring:setDamping(0.8)
        cardSpring:setEndPos(card:getPos())
        cardSpring:setTargetPos(cardOrigin)

        if (love.keyboard.isDown("p")) then

            table.sort(deck, function(a, b)
                return a[4] < b[4]
            end)

            if not ((card:getPos() - CARD_ORIGIN).Magnitude > 0.001) then
                card:setPos(CARD_ORIGIN)
            end

            local newPos = cardSpring:update(dt)
            card:setPos(newPos)
        end

        card:clearOffset()

    end
end

--- love.draw()
function game.draw()
    for i = #deck, 1, -1 do
        local deckEntry = deck[i]
        deckEntry[1]:draw()
    end
end

--- love.exit()
function game.exit()

end

return game
--// Modules
local utils = require("src.shared.utils.utils")
local vector2 = require("src.shared.utils.vector2")
local rect = require("src.modules.rect")
local spring = require("src.shared.utils.spring")
local cardData = require("src.data.card")

--// Internals
local deck = {}

--// Game
local stack = {
    deckRef = deck
}

--- love.load()
function stack.init()
    -- Create cards
    for i = 1, cardData.CARD_COUNT do
        local size = cardData.CARD_SIZE
        local pos = vector2.new(cardData.CARD_ORIGIN.x, cardData.CARD_ORIGIN.y + cardData.CARD_GAP * i * cardData.CARD_DIRECTION_FACTOR)
        local card = rect.new(pos, size)
        card:setCornerRadius(cardData.CORNER_RADIUS)
        card:setAnchor(cardData.CARD_ANCHOR)
        card:setColour({love.math.random(), love.math.random(), love.math.random()})
        card:setOutline(true, 2, {255, 255, 255})

        local cardSpring = spring.new()
        cardSpring:setEndPos(cardData.CARD_ORIGIN)
        cardSpring:setTargetPos(pos)

        table.insert(deck, { card, cardSpring, pos, i })
    end
end

--- love.update()
function stack.update(dt)
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

        if ((card:isInside(mousePos) and love.mouse.isDown(1)) or ((cardData.selectedCard == card) and love.mouse.isDown(1))) then

            cardData.selectedCard = card

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

        cardData.selectedCard = nil
        cardSpring:setForce(25)
        cardSpring:setDamping(0.8)
        cardSpring:setEndPos(card:getPos())
        cardSpring:setTargetPos(cardOrigin)

        if (love.keyboard.isDown("p")) then

            table.sort(deck, function(a, b)
                return a[4] < b[4]
            end)

            if not ((card:getPos() - cardData.CARD_ORIGIN).Magnitude > 0.001) then
                card:setPos(cardData.CARD_ORIGIN)
            end

            local newPos = cardSpring:update(dt)
            card:setPos(newPos)
        end

        card:clearOffset()

    end
end

--- love.draw()
function stack.draw()
    for i = #deck, 1, -1 do
        local deckEntry = deck[i]
        deckEntry[1]:draw()
    end
end

--- love.exit()
function stack.exit()

end

return stack
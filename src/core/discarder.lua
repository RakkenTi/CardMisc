--- For discarding stack entries.

--// Modules
local vector2 = require("src.shared.utils.vector2")
local cardData = require("src.data.crd")
local stack = require("src.core.stack")
local rect = require("src.modules.rect")
local colours = require("src.data.colours")
local utils = require("src.shared.utils.utils")

--// Frame Data
local SIZE = cardData.CARD_SIZE * 1.15
local POSITION = vector2.new(0.85, 0.5)
local ANCHOR = vector2.new(0.5, 0.5)
local FRAME = rect.new(POSITION, SIZE)

--- @class discarder
local discarder = {}

function discarder.init()
    FRAME:setAnchor(ANCHOR)
    FRAME:setColour()
end

function discarder.update(dt)
end

function discarder.draw()
    FRAME:draw()
end

function discarder.exit()
end

return discarder
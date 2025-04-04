--// Modules
local vector2d = require("vector2d")

--// Main
local card = {}
card.__index = object

function card.new()
    local self = setmetatable({}, card)


    return self
end

return card
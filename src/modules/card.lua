local card = {}
card.__index = object

function card.new()
    local self = setmetatable({}, card)
end

return card
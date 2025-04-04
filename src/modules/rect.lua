--// Modules
local vector2 = require("src.shared.utils.vector2")
local collision = require("src.shared.utils.collision")

--// Main
--- @class card
local rect = {}
rect.__index = rect

--- Creates an instance of rect
--- @param pos Vector2
--- @param size Vector2
function rect.new(pos, size)
    local self = setmetatable({}, rect)

    self.isScaled = false
    self.pos = pos
    self.size = size
    self.anchor = vector2.new()
    self.offset = vector2.new()

    return self
end

--// Methods
--- Set a vector2 that will be added to to the position in the draw call.
--- Note: Offset must be empty to set one. Or else it will be rejected
--- @param offset Vector2
function rect:setOffset(offset)
    if self.offset ~= vector2.new() then return end
    self.offset = offset
end

--- Clears the offset, allowing a new one to be set.
function rect:clearOffset()
    self.offset = vector2.new()
end

--- Set the anchor of the rectangle. This affects position.
--- Only has an effect when using scaled mode.
--- @param newAnchor Vector2
function rect:setAnchor(newAnchor)
    self.anchor = newAnchor
    self:update()
end

function rect:setPos(pos)
    -- micro optimization
    if (pos == self.pos) then return end
    self.pos = pos - self.offset
    self:update()
end

function rect:setSize(size)
    self.size = size
    self:update()
end

--- Returns the raw position of the rectangle. Scaled or pixels.
--- @return Vector2
function rect:getPos()
    return self.pos
end

--- Returns the raw position of the rectangle strictly in pixels.
--- @return Vector2
function rect:getRawPos()
    local screenSize = vector2.new(love.window.getMode())
    return vector2.new(self:getPos().x * screenSize.x, self:getPos().y * screenSize.y)
end

--- Returns the center position of the rectangle in pixels.
--- @return Vector2
function rect:getCenteredPos()
    local screenSize = vector2.new(love.window.getMode())
    return vector2.new(
            self.pos.x * screenSize.x - (self.anchor.x * self.size.x) + self.size.x / 2,
            self.pos.y * screenSize.y - (self.anchor.y * self.size.y) + self.size.y / 2
    )
end

--- Returns true if the given position is inside the rectangle. Else false.
--- @param pos Vector2
--- @return boolean
function rect:isInside(pos)
    return collision.checkRect(
        pos.x,
        pos.y,
        self:getCenteredPos().x - self.size.x / 2,
        self:getCenteredPos().y - self.size.y / 2, self.size.x, self.size.y
    )
end

function rect:update()
    local screenSize = vector2.new(love.window.getMode())
    self.scalePos = vector2.new(
        (self.pos.x * screenSize.x - (self.anchor.x * self.size.x)),
        (self.pos.y * screenSize.y - (self.anchor.y * self.size.y))
    )
end

function rect:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", self.scalePos.x, self.scalePos.y, self.size.x, self.size.y)
end

return rect
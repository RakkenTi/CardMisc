--- @class RectClass
local rect = {}
rect.__index = rect

--// Modules
local vector2 = require("src.shared.utils.vector2")
local collision = require("src.shared.utils.collision")

--// Main

--- @class Rect : RectClass
--- Creates an instance of rect
--- @param pos Vector2
--- @param size Vector2
--- @return Rect
function rect.new(pos, size)
    local self = setmetatable({}, rect)

    self.isScaled = false
    self.pos = pos or vector2.new()
    self.size = size or vector2.new()
    self.pixelSize = vector2.new()
    self.anchor = vector2.new()
    self.offset = vector2.new()
    self.scalePos = vector2.new()
    self.colour = {255, 255, 255}
    self.cornerRadius = 0

    return self
end

--// Methods
function rect:setColour(colour)
    self.colour = colour
end

--- Set the corner radius to a number
--- A corner radius greater than 0 will create a rounded rectangle.
--- @param radius number
function rect:setCornerRadius(radius)
    self.cornerRadius = radius
end

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
            self.pos.x * screenSize.x - (self.anchor.x * self.pixelSize.x) + self.pixelSize.x / 2,
            self.pos.y * screenSize.y - (self.anchor.y * self.pixelSize.y) + self.pixelSize.y / 2
    )
end

--- Returns true if the given position is inside the rectangle. Else false.
--- @param pos Vector2
--- @return boolean
function rect:isInside(pos)
    return collision.checkRect(
        pos.x,
        pos.y,
        self:getCenteredPos().x - self.pixelSize.x / 2,
        self:getCenteredPos().y - self.pixelSize.y / 2,
        self.pixelSize.x,
        self.pixelSize.y
    )
end

function rect:update()
    local screenSize = vector2.new(love.window.getMode())
    self.pixelSize = vector2.new((self.size.x * screenSize.x), (self.size.y * screenSize.y))
    self.scalePos = vector2.new(
        (self.pos.x * screenSize.x - (self.anchor.x * self.pixelSize.x)),
        (self.pos.y * screenSize.y - (self.anchor.y * self.pixelSize.y))
    )
end

function rect:draw()
    love.graphics.setColor(self.colour)
    love.graphics.rectangle("fill", self.scalePos.x, self.scalePos.y, self.pixelSize.x, self.pixelSize.y, self.cornerRadius, self.cornerRadius)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", self.scalePos.x, self.scalePos.y, self.pixelSize.x, self.pixelSize.y, self.cornerRadius, self.cornerRadius)
end

return rect
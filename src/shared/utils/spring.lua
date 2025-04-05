local vector2 = require("src.shared.utils.vector2")

--- @class springClass
local spring = {}
spring.__index = spring

--- @class spring
--- @param targetPos Vector2 Where the spring is rooted, ie: pulling into
--- @param endPos Vector2 The point that the spring is pulling in to the target.
--- @param force number? How much force to attract with
--- @param damping number? How much to diffuse the acceleration by.
--- Creates an instance of the spring class.
function spring.new(targetPos, endPos, force, damping)
    local self = setmetatable({}, spring)

    self.velocity = vector2.new()
    self.targetPos = targetPos or vector2.new()
    self.endPos = endPos or vector2.new()
    self.force = force or 1
    self.damping = damping or 2

    return self
end

--// Methods
--- @param targetPos Vector2 Sets the target position of the spring. This is where the force is directed towards.
function spring:setTargetPos(targetPos)
    self.targetPos = targetPos
end

--- @param endPos Vector2 Sets the end position of the spring. This is the position being pulled towards the target.
function spring:setEndPos(endPos)
    self.endPos = endPos
end

function spring:setForce(force)
    self.force = force
end

function spring:setDamping(damping)
    self.damping = damping
end

function spring:update(dt)
    local displacement = self.endPos - self.targetPos
    local acceleration = (displacement * -self.force) * dt
    self.velocity = (self.velocity + acceleration) * self.damping
    self:setEndPos(self.endPos + self.velocity)
    return self.endPos
end

return spring
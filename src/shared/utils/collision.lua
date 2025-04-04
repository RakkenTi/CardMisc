-- for checking collisions
local collision = {}

--- Checks if a given position is within a rectangle defined by a position and size.
--- Assumes that (0,0) is the top-left.
--- Also assumes that all dimensions are in pixels.
--- Make sure to give a
--- @param targetPosX number The x-position of the point that will be checked.
--- @param targetPosY number The y-position of the point that will be checked.
--- @param rootPosX number The x-position of the rectangle assuming an anchor of (0,0)
--- @param rootPosY number the y-position of the rectangle assuming an anchor of (0, 0)
--- @param rectSizeX number The width of the rectangle.
--- @param rectSizeY number The height of the rectangle.
--- @return boolean
function collision.checkRect(targetPosX, targetPosY, rootPosX, rootPosY, rectSizeX, rectSizeY)
    local isXBound = targetPosX > rootPosX and targetPosX < (rootPosX + rectSizeX)
    local isYBound = targetPosY > rootPosY and targetPosY < (rootPosY + rectSizeY)
    return isXBound and isYBound
end

return collision
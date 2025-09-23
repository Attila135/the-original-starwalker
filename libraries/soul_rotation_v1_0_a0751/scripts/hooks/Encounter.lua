---@class Encounter : Encounter
---@overload fun(...) : Encounter
local Encounter, super = Class("Encounter", true)

function Encounter:getSoulRotation()
    return Game:getSoulRotation()
end

function Encounter:createSoul(x, y, color, rotation)
    return Soul(x, y, color, rotation)
end

return Encounter
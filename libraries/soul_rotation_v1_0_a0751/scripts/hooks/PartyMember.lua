---@class PartyMember : PartyMember
---@overload fun(...) : PartyMember
local PartyMember, super = Class("PartyMember", true)

function PartyMember:init()
	super.init(self)

    self.soul_rotation = 0
end

function PartyMember:getSoulRotation() return (self.soul_rotation or 0) end

return PartyMember
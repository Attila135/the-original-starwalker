local Game, super = Game

function Game:getSoulRotation()
	if Game:getFlag("#soulRotationOverride", 0) ~= 0 then
		return Game:getFlag("#soulRotationOverride", 0)
	end
	
    local r = Kristal.callEvent(KRISTAL_EVENT.getSoulRotation)
    if r ~= nil then
        return r or 0
    end

    local chara = Game:getSoulPartyMember()

    if chara and chara:getSoulPriority() >= 0 then
        local r = chara:getSoulRotation()
        return r or 0
    end

    return 0
end

return Game
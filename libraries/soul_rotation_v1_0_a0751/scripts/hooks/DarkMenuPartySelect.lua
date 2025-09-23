---@class DarkMenuPartySelect : DarkMenuPartySelect
---@overload fun(...) : DarkMenuPartySelect
local DarkMenuPartySelect, super = Class(DarkMenuPartySelect)

function DarkMenuPartySelect:draw()
    for i,party in ipairs(Game.party) do
        if self.selected_party ~= i then
            Draw.setColor(1, 1, 1, 0.4)
        else
            Draw.setColor(1, 1, 1, 1)
        end
        local ox, oy = party:getMenuIconOffset()
        Draw.draw(Assets.getTexture(party:getMenuIcon()), (i-1)*50 + (ox*2), oy*2, 0, 2, 2)
    end
    if self.focused then
        local frames = Assets.getFrames("player/heart_harrows")
		local heart_sprite = Assets.getTexture("player/heart")
		
        Draw.setColor(Game:getSoulColor())
        Draw.draw(heart_sprite, (self.selected_party-1)*50 + 26, -10, Game:getSoulRotation(), 1, 1, 8, 8)
        Draw.draw(frames[(math.floor(self.heart_siner/20)-1)%#frames+1], (self.selected_party-1)*50 + 10, -18)
    end
    super.super.draw(self)
end

return DarkMenuPartySelect
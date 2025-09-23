---@class Battle : Battle
---@overload fun(...) : Battle
local Battle, super = Class(Battle)

function Battle:spawnSoul(x, y)
    local bx, by = self:getSoulLocation()
    local color = {self.encounter:getSoulColor()}
	local rotation = self.encounter:getSoulRotation()
    self:addChild(HeartBurst(bx, by, color))
    if not self.soul then
        self.soul = self.encounter:createSoul(bx, by, color, rotation)
        self.soul:transitionTo(x or SCREEN_WIDTH/2, y or SCREEN_HEIGHT/2)
        self.soul.target_alpha = self.soul.alpha
        self.soul.alpha = 0
        if Game:getConfig("soulInvBetweenWaves") then
            self.soul.inv_timer = Game.old_soul_inv_timer
        end
        Game.old_soul_inv_timer = 0
        self:addChild(self.soul)
    end

    if self.state == "DEFENDINGBEGIN" or self.state == "DEFENDING" then
        self.soul:onWaveStart()
    end
end

return Battle

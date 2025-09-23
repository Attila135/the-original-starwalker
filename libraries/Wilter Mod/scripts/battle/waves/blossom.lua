local Basic, super = Class(Wave)
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 13
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())
    
    self.timer:everyInstant(2/Game:getFlag("bul_speed"), function()
        self.skipped_bullet = love.math.random(1, 9)
        self.current_bullet = 1
        for i=1, 3 do
            for g=1, 3 do
                if self.current_bullet == self.skipped_bullet then
                    self.current_bullet = self.current_bullet + 1
                else
                    local bullet = self:spawnBullet("bloomingflower", Game.battle.arena:getLeft()+Game.battle.arena.width/4*g, Game.battle.arena:getTop()+Game.battle.soul.strings[i], math.rad(180), 0)
                    self.current_bullet = self.current_bullet + 1
                end
            end
        end
    end)
end

return Basic

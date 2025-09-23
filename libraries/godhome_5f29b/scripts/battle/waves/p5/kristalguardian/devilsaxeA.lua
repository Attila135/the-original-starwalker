local Devilsknife, super = Class(Wave)

function Devilsknife:init()
    super:init(self)
    self.time = 14
end

function Devilsknife:onStart()
    local arena = Game.battle.arena
    for i=1,4 do
        local angle = -math.pi/6 + i*math.pi/2
        local axe = self:spawnBullet("bullets/star", arena.x, arena.y, angle, arena.width)
        star.destroy_on_hit = false
        star.inv_timer = 1/30
        self.timer:after(0.05, function()
            self.timer:tween(0.05, axe, {spinning = 5})
        end)
    end
end

return Devilsknife
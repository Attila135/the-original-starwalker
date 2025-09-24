local Xture, super = Class(Bullet)

function Xture:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/susie/left/dragon")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false

    self.sprite:setAnimation({"bullets/susie/left/dragon", 1/8, true})

end

function Xture:onWaveSpawn(wave)
    wave.timer:after(0.7, function()
    self.sprite:setAnimation({"bullets/susie/left/atk", 1/8, true})
    for i = -1, 1 do
        local offset = i * 15
    local Xture = wave:spawnBullet("bullets/smallbullet", self.x, self.y)
            Xture.physics.direction = math.atan2(Game.battle.soul.y - self.y, Game.battle.soul.x - self.x) + math.rad(offset)
            Xture.physics.speed = 8
    end
end)
    wave.timer:after(0.8, function()
        for i = -1, 1 do
            local offset = i * 15
        local Xture = wave:spawnBullet("bullets/smallbullet", self.x, self.y)
                Xture.physics.direction = math.atan2(Game.battle.soul.y - self.y, Game.battle.soul.x - self.x) + math.rad(offset)
                Xture.physics.speed = 8
        end
    end)
    wave.timer:after(0.9, function()
        self.sprite:setAnimation({"bullets/susie/left/dragon", 1/8, true})
        for i = -1, 1 do
            local offset = i * 15
        local Xture = wave:spawnBullet("bullets/smallbullet", self.x, self.y)
                Xture.physics.direction = math.atan2(Game.battle.soul.y - self.y, Game.battle.soul.x - self.x) + math.rad(offset)
                Xture.physics.speed = 8
        end
        end)
    wave.timer:after(1, function()
        self:fadeOutAndRemove(0.5)
    end)
end

function Xture:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Xture
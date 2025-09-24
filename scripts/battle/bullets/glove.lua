local Slash, super = Class(Bullet)

function Slash:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/glove")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function Slash:onWaveSpawn(wave)
    self.wave = wave
    timer = 0
end

function Slash:update()
    timer = timer + 1
    if timer == 10 then
        Assets.playSound("spare")
        local Xture = self.wave:spawnBullet("bullets/Xture", self.x, self.y)
                Xture.physics.direction = math.atan2(Game.battle.soul.y - Xture.y, Game.battle.soul.x - Xture.x)
                Xture.physics.speed = 8
                Xture:setScale(0.5)
    elseif timer == 15 then
        local Xture = self.wave:spawnBullet("bullets/Xture", self.x, self.y)
                Xture.physics.direction = math.atan2(Game.battle.soul.y - Xture.y, Game.battle.soul.x - Xture.x)
                Xture.physics.speed = 8
                Xture:setScale(0.5)
    elseif timer == 20 then
        local Xture = self.wave:spawnBullet("bullets/Xture", self.x, self.y)
                Xture.physics.direction = math.atan2(Game.battle.soul.y - Xture.y, Game.battle.soul.x - Xture.x)
                Xture.physics.speed = 8
                Xture:setScale(0.5)
    end
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Slash
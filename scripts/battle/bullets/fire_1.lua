local Xture, super = Class(Bullet)

function Xture:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/fire")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

end

function Xture:onWaveSpawn(wave)
    self.wave = wave
end

function Xture:update()
    if math.random(30) == 2 then 
        fire = self.wave:spawnBullet("fire_2", self.x, self.y)
        fire:setScale(0.5)
        fire:fadeOutAndRemove(0.5)
    end
    super.update(self)
end

return Xture
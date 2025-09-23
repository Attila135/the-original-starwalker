local Slash, super = Class(Bullet)

function Slash:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/slash3")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    Assets.playSound("laz_c")
end

function Slash:onWaveSpawn(wave)
    self.wave = wave
end

function Slash:update()
    if math.random() > 0.4 then 
        ture = self.wave:spawnBullet("Xture", self.x, self.y)
        ture:setScale(0.5)
        ture.color = {1,0,0}
        ture:fadeOutAndRemove(1)
    end
    
    super.update(self)
end

return Slash
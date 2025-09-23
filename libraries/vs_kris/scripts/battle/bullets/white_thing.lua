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
end

function Slash:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.timer:script(function(wait)
        local angle = Utils.angle(Slash.x, Game.battle.soul.y)
    end)
    super.update(self)
end

return Slash
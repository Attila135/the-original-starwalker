local Slap, super = Class(Bullet)

function Slap:init(x, y, dir, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/slap")
    self.sprite:setScale(0.5)
    self:setHitbox(6, 7.5, (self.sprite.width/2)-14, (self.sprite.height/2)-14)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    --self.physics.gravity_direction = dir
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    --self.physics.friction = 0.2
end

function Slap:update()
    -- For more complicated bullet behaviours, code here gets called every update

    self.physics.speed = self.physics.speed-0.2*DTMULT

    super:update(self)
end

return Slap
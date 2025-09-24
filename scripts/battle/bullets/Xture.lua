local Xture, super = Class(Bullet)

function Xture:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/Xture")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = math.rad(math.random(0, 360))
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = math.random(2, 3)

    self.sprite:setAnimation({"bullets/Xture", 1/8, true})

end

function Xture:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Xture
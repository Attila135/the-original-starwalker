local Stallactic, super = Class(Bullet)

function Stallactic:init(x, y, dir, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/stallactic")
    print("yes_C")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.rotation = dir
    self.physics.match_rotation = true
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.physics.gravity = 0.25
end

function Stallactic:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

return Stallactic
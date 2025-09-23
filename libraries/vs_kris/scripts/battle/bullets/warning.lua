local Warning, super = Class(Bullet)

function Warning:init(x, y, rot)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/warning")

    -- Top-center origin point (will be rotated around it)

    self:setScale(1.6, 0.5)

    -- Rotation of the bullet (in radians)
    self.rotation = rot

    -- Don't destroy this bullet when it damages the player
    self.destroy_on_hit = false
end

function Warning:onCollide(soul) end

function Warning:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Warning
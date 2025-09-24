local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, rot)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/slice")

    self:setScale(10, 0.5)

    self.rotation = rot

    self.destroy_on_hit = false

    Assets.playSound("laz_c")
end

function SmallBullet:update()
    self.scale_y = self.scale_y + 0.1
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return SmallBullet
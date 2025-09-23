local Eye, super = Class(WorldBullet)

function Eye:init(x, y, flip)
    super.init(self, x, y)

    self.damage = 5
    self.destroy_on_hit = false
end

function Eye:update()
    super.update(self)
end

return Eye

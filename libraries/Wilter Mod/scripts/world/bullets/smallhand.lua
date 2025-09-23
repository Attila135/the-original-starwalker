local Eye, super = Class(WorldBullet)

function Eye:init(x, y, flip)
    super.init(self, x, y)
    self:setSprite("bullets/world/smallhand_" .. Utils.pick({"a", "b", "c"}))

    self.physics.direction = 0

    self.rand = love.math.random(0, math.pi, 0.1)

    self.siner = 0
    self:setLayer(101)

    self.anchorX = self.x

    self.startX = self.x

    self.collidable = false
end

function Eye:update()
    super.update(self)

    self.siner = self.siner + DT
    self.x = self.anchorX + math.cos(self.siner+self.rand)*20
    self.anchorX = self.anchorX + 4*DTMULT
end

function Eye:onCollide(soul)
    
end

return Eye
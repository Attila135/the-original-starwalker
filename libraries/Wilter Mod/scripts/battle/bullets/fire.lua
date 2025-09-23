local SmallBullet, super = Class(Bullet, "fire")

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/fire")
    self.sprite:setAnimation({"bullets/fire", 1/10, true})

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self:setScale(0)
    self.alpha = 0

    Game.battle.waves[1].timer:tween(0.5, self, {scale_x = 2, scale_y = 2, alpha = 1}, "out-quad")
    
    self.old_y = self.y

    self.old_x = self.x

    self.siner = 0

    --self.rand = love.math.random(1, 3)

    --self.physics.speed = 6 + self.rand

    self.direction = "up"
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    if self.direction == "up" then
        self.y = self.old_y+math.sin((self.x-self.old_x)/50)*50
    else
        self.y = self.old_y+math.cos((self.x-self.old_x)/50)*50
    end
    self.siner = self.siner + DT

    super.update(self)
end

return SmallBullet
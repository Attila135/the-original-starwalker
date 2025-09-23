local SmallBullet, super = Class(Bullet, "trident")

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/trident")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self:setScale(0)
    self.alpha = 0

    Game.battle.waves[1].timer:tween(1, self, {scale_x = 2, scale_y = 2, alpha = 1})

    self:setOrigin(0.5)

    self:setHitbox(10, 18, 210, 10)
    self.remove_offscreen = false
    self.destroy_on_hit = false

end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    self.rotation = self.rotation - math.rad(DTMULT*2)*Game:getFlag("bul_speed")
    if self.x <= 320 then
        self.physics.speed = 0
    end

    super.update(self)
end

return SmallBullet
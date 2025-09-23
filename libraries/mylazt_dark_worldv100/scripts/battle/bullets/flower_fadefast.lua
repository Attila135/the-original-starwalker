local flower_fadefast, super = Class(Bullet)

function flower_fadefast:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/flower")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.rotation = dir;
    self.damage = 80;
    self.moveVar = 0;
    self.destroy_on_hit = false;
    self:setScale(-1, 1);
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(-2, 2)
    self.inv_timer = 0.3;
end

function flower_fadefast:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.moveVar = self.moveVar + 1 * DTMULT;
    if (self.moveVar > 5)
        then
        self.alpha = self.alpha - 0.1 * DTMULT;
        end

    super.update(self)
end

return flower_fadefast
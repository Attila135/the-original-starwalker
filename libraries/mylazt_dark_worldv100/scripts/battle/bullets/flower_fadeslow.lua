local flower_fadeslow, super = Class(Bullet)

function flower_fadeslow:init(x, y, dir, speed)
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
    self.scale_x = 1
    self.scale_y = 1
    
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(2, 2)
    self.inv_timer = 0.3;
end

function flower_fadeslow:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.alpha = self.alpha - 0.01 * DTMULT;
    if (self.alpha < 0.2) then self.damage = 0; self.tp = 0; end
    if (self.alpha < 0.55) then self.alpha = self.alpha - 0.04 * DTMULT; end
    if (self.alpha <= 0) then self:remove(); end

    super.update(self)
end

return flower_fadeslow
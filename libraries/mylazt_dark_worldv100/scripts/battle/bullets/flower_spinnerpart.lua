local flower_spinnerpart, super = Class(Bullet)

function flower_spinnerpart:init(distance, angle, angleSpeed, flowerCore)
    -- Last argument = sprite path
    super.init(self, -999, -999, "bullets/flower")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.damage = 80;
    -- self.tp = 0;
    self.moveVar = 0;
    self.destroy_on_hit = false;
    self.scale_x = 1
    self.scale_y = 1
    self.flowerCore = flowerCore;
    self.currentDistance = 0;
    self.desiredDistance = distance;
    self.angleSpeed = angleSpeed;
    self.rotation = angle;
    --self.wave:spawnBullet("flower_spinnerpart", self.x, self.y, self.currentAngle + math.rad(180), 6);
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(2, 2);
    self.timeVar = 0;
    self.inv_timer = 0.3;
end

function flower_spinnerpart:update()
    self.rotation = self.rotation + math.rad(self.angleSpeed);
    self.timeVar = self.timeVar + 0.5;
    self.currentDistance = Utils.ease(self.currentDistance, self.desiredDistance, self.timeVar / 40, "in-out-quad")
    if (self.flowerCore ~= nil)
        then
        self.x = self.flowerCore.x + math.cos(self.rotation) * self.currentDistance;
        self.y = self.flowerCore.y + math.sin(self.rotation) * self.currentDistance;
        self.alpha = self.flowerCore.alpha;
        if (self.alpha <= 0) then self:remove(); end
        end
    -- For more complicated bullet behaviours, code here gets called every update
    -- self.alpha = self.alpha - 0.01;
    -- if (self.alpha < 0.2) then self.damage = 0; self.tp = 0; end
    -- if (self.alpha < 0.55) then self.alpha = self.alpha - 0.04; end
    -- if (self.alpha <= 0) then self:remove(); end

    super.update(self)
end

return flower_spinnerpart
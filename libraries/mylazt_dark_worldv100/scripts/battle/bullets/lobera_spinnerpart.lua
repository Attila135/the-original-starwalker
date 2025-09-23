local lobera_spinnerpart, super = Class(Bullet)

function lobera_spinnerpart:init(distance, angle, angleSpeed, loberaCore)
    -- Last argument = sprite path
    super.init(self, -999, -999, "bullets/lobera_spinner")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.damage = 50;
    -- self.tp = 0;
    self.moveVar = 0;
    self.destroy_on_hit = false;
    self.scale_x = 1
    self.scale_y = 1
    self.loberaCore = loberaCore;
    self.currentDistance = distance;
    self.desiredDistance = 0;
    self.angleSpeed = angleSpeed;
    self.rotation = angle;
    --self.wave:spawnBullet("lobera_spinnerpart", self.x, self.y, self.currentAngle + math.rad(180), 6);
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(2, 2);
    self.alpha = 0;
    self.timeVar = 0;
    self.inv_timer = 0.3;
    self.loberaLifetime = 0;
    self.timer = Timer(); self:addChild(self.timer);
    self.initEase = false;
end

function lobera_spinnerpart:update()
    self.loberaLifetime = self.loberaLifetime + 1 * DTMULT;
    self.rotation = self.rotation + math.rad(self.angleSpeed) * DTMULT;
    self.timeVar = self.timeVar + 0.25 * DTMULT;
    if (self.initEase == false) then self.initEase = true; self.timer:tween(1.5, self, {currentDistance = self.desiredDistance}, 'in-out-quad'); end --  self.currentDistance = Utils.ease(self.currentDistance, self.desiredDistance, self.timeVar / 40, "in-out-quad")
    if (self.loberaCore ~= nil)
        then
        self.x = self.loberaCore.x + math.cos(self.rotation) * self.currentDistance;
        self.y = self.loberaCore.y + math.sin(self.rotation) * self.currentDistance;
        self.alpha = Utils.approach(self.alpha, self.loberaCore.alpha, 0.05 * DTMULT);
        -- self.alpha = self.loberaCore.alpha;
        if (self.alpha <= 0.1 and self.loberaLifetime > 20) then self:remove(); end
        if (self.alpha <= 0.2 and self.timeVar > 10) then self.damage = 0; end
        end
    -- For more complicated bullet behaviours, code here gets called every update
    -- self.alpha = self.alpha - 0.01;
    -- if (self.alpha < 0.2) then self.damage = 0; self.tp = 0; end
    -- if (self.alpha < 0.55) then self.alpha = self.alpha - 0.04; end
    -- if (self.alpha <= 0) then self:remove(); end

    super.update(self)
end

return lobera_spinnerpart
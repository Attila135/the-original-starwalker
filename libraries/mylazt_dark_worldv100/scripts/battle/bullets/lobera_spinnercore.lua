local lobera_spinnercore, super = Class(Bullet)

function lobera_spinnercore:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/lobera")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.rotation = dir;
    self.damage = 0;
    self.tp = 0;
    self.moveVar = 0;
    self.destroy_on_hit = false;
    self.scale_x = 1;
    self.scale_y = 1;
    self.alpha = 2.5;
    self.spawnedloberas = false;
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(0, 0)
    self.spinSpeed = Utils.pick({-2, 2});
--    self.inv_timer = 0.3;
end

function lobera_spinnercore:update()
    if (self.spawnedloberas == false)
        then
        self.spawnedloberas = true;
        self.wave:spawnBullet("lobera_spinnerpart", 200, 0, self.spinSpeed, self);
        self.wave:spawnBullet("lobera_spinnerpart", 200, math.rad(72), self.spinSpeed, self);
        self.wave:spawnBullet("lobera_spinnerpart", 200, math.rad(144), self.spinSpeed, self);
        self.wave:spawnBullet("lobera_spinnerpart", 200, math.rad(216), self.spinSpeed, self);
        self.wave:spawnBullet("lobera_spinnerpart", 200, math.rad(288), self.spinSpeed, self);
        end
    self.alpha = self.alpha - 0.05 * DTMULT;
    if (self.alpha <= -0.2)
        then 
        self:remove();
        end
    -- For more complicated bullet behaviours, code here gets called every update
    -- self.alpha = self.alpha - 0.01;
    -- if (self.alpha < 0.2) then self.damage = 0; self.tp = 0; end
    -- if (self.alpha < 0.55) then self.alpha = self.alpha - 0.04; end
    -- if (self.alpha <= 0) then self:remove(); end

    super.update(self)
end

return lobera_spinnercore
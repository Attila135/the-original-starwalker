local bouquet_regular, super = Class(Bullet)

function bouquet_regular:init(x, y, angleStart, angleSpeed, angleDistance, shootMoment)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/bouquet_regular")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.x = -999;
    self.y = -999;
    self.angleStart = angleStart;
    self.angleSpeed = angleSpeed;
    self.angleDistance = angleDistance;
    self.originalDistance = angleDistance;
    self.shootMoment = shootMoment;
    self.timeVar = 0;
    self.currentAngle = 0;
    self.alpha = 0;
    self.destroy_on_hit = false;
    self.wentBack = false;
    self.backDistance = 50;
    self.backVar = 0;
    self.damage = 0;
    self.tp = 0;
    self.sprite:setScaleOrigin(0.5, 0.5);
    self.scaleVar = 1.1;
    self:setScale(4 * self.scaleVar, 4 * self.scaleVar);
    self.sprite:setScale(0.5 / self.scaleVar, 0.5 / self.scaleVar)
end

function bouquet_regular:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.alpha < 1) then self.alpha = self.alpha + 0.05 * DTMULT; end
    self.timeVar = self.timeVar + 1 * DTMULT;
    
    if (self:collidesWith(Game.battle.arena.collider))
        then
        Assets.playSound("darkbomb")
        self.wave:spawnBullet("flower", self.x, self.y, self.currentAngle + math.rad(180), 6);
        self.wave:spawnBullet("flower", self.x, self.y, self.currentAngle + math.rad(180 + 25), 6);
        self.wave:spawnBullet("flower", self.x, self.y, self.currentAngle + math.rad(180 - 25), 6);
        self:remove();
        end

    if (self.timeVar < self.shootMoment)
        then
        self.currentAngle = self.currentAngle + self.angleSpeed * DTMULT;
        self.rotation = math.cos(self.timeVar / 2) * math.rad(15);

        else 
        -- begin swinging/charging
        self.backVar = self.backVar + 1 * DTMULT;
        if (self.wentBack == false)
            then
            self.angleDistance = Utils.ease(self.originalDistance, self.originalDistance + self.backDistance, self.backVar / 20, "in-out-quad")
            if (self.angleDistance == self.originalDistance + self.backDistance) then self.wentBack = true; self.backVar = 0; self.originalDistance = self.angleDistance; self.sprite:setSprite("bullets/bouquetspin", 0, false); self.rotation = 0; end
            -- Kristal.Console:log("checked!")
            else
            -- shoot forward
            if (self.backVar % 2 == 0) then self.rotation = self.rotation + math.rad(90) * DTMULT; end
            self.angleDistance = Utils.ease(self.originalDistance, 0, self.backVar / 15, "in-out-quad")
            end 
        self.angleDistance = self.angleDistance
        end
    self.x = Game.battle.arena.x + math.cos(self.currentAngle) * self.angleDistance + self.angleStart;
    self.y = Game.battle.arena.y + math.sin(self.currentAngle) * self.angleDistance + self.angleStart;
    super.update(self)
end

return bouquet_regular
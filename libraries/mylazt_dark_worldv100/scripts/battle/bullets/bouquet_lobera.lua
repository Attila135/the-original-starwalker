local bouquet_lobera, super = Class(Bullet)

function bouquet_lobera:init(x, y, angleStart, angleSpeed, angleDistance, shootMoment, loberaColor)
    -- Last argument = sprite path
    self.loberaColor = loberaColor;
    super.init(self, x, y, "bullets/lobera_" .. self.loberaColor)

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
    
    self.rotation = math.rad(180);

    self.timeVar = 0;
    self.currentAngle = 0 + self.angleStart;
    self.alpha = 0;
    self.destroy_on_hit = false;
    self.wentBack = false;
    self.backDistance = 50;
    self.backVar = 0;
    self.damage = 0;
    self.tp = 0;
    self.sprite:setScaleOrigin(0.5, 0.5);
    self.scaleVar = 1.3;
    self:setScale(4 * self.scaleVar, 4 * self.scaleVar);
    self.frameVar = 0;
    self.sprite:setScale(0.5 / self.scaleVar, 0.5 / self.scaleVar)
    self.timer = Timer(); self:addChild(self.timer);
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
if (self.timeVar < self.shootMoment)
    then
    else self.frameVar = self.frameVar + 1 
    if (self.wentBack == true and self.frameVar % 2 == 0) then self.rotation = self.rotation - math.rad(45); end
    end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function bouquet_lobera:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.alpha < 1) then self.alpha = self.alpha + 0.05 * DTMULT; end
    self.timeVar = self.timeVar + 1 * DTMULT;
    
    if (self:collidesWith(Game.battle.arena.collider))
        then
        -- self.wave:spawnBullet("loberaswing", self.x + (Game.battle.soul.x - Game.battle.arena.x), self.y, Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y), self.loberaColor);
        self.wave:spawnBullet("loberaswing", Game.battle.arena.x, Game.battle.arena.y, self.currentAngle + math.rad(180), self.loberaColor);
        -- self.wave:spawnBullet("loberaswing", Game.battle.arena.x + (Game.battle.soul.x - Game.battle.arena.x), Game.battle.arena.y - 40 + (Game.battle.soul.y - Game.battle.arena.y), self.currentAngle + math.rad(180), self.loberaColor);
        -- self.wave:spawnBullet("flower", self.x, self.y, self.currentAngle + math.rad(180 + 25), 6);
        -- self.wave:spawnBullet("flower", self.x, self.y, self.currentAngle + math.rad(180 - 25), 6);
        self:remove();
        end

    if (self.timeVar < self.shootMoment)
        then
        self.currentAngle = self.currentAngle + self.angleSpeed * DTMULT;
        if (self.timeVar > 2) then self.rotation = Utils.angle(self.x, self.y, Game.battle.arena.x, Game.battle.arena.y); end

        else 
        -- begin swinging/charging
        self.backVar = self.backVar + 1 * DTMULT;
        if (self.wentBack == false)
            then
            self.angleDistance = Utils.ease(self.originalDistance, self.originalDistance + self.backDistance, self.backVar / 20, "in-out-quad")
            if (self.angleDistance == self.originalDistance + self.backDistance)
                then
                self.wentBack = true; self.backVar = 0; self.originalDistance = self.angleDistance; self.sprite:setSprite("bullets/loberaspin_" .. self.loberaColor, 0, false); self.rotation = 0;
                end
            -- Kristal.Console:log("checked!")
            else
            -- shoot forward
            
            self.angleDistance = Utils.ease(self.originalDistance, 0, self.backVar / 15, "in-out-quad")
            end 
        self.angleDistance = self.angleDistance
        end
    self.x = Game.battle.arena.x + math.cos(self.currentAngle) * self.angleDistance + self.angleStart;
    self.y = Game.battle.arena.y + math.sin(self.currentAngle) * self.angleDistance + self.angleStart;
    super.update(self)
end

return bouquet_lobera
local Lobera, super = Class(Bullet)

function Lobera:init(x, y, dir, throwSpeed, throwLength)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/lobera")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.rotation = dir;
    self.throwSpeed = throwSpeed;
    self.throwLength = throwLength;
    self.originalX = x;
    self.originalY = y;
    self.alpha = 0;
    self.swordReady = false;
    self.stabVar = 0;
    self.stabState = 0;
    self.swordComplete = false;

    self.damage = 80;
    self.destroy_on_hit = false;
    self.addX = 0;
    self.addY = 0;
    self.returnX = 0;
    self.returnY = 0;
    self.shakeTimer = 12;
    self.shakeAmount = 6;
    self.shakeX = 0;
    self.shakeY = 0;
    self.stillTime = 0;
    self.completeTime = 0;
    self.isBroken = false;

    self.childConnector = nil;
    self.childPillar = nil;
    self.tp = 0;


    self.scale_x = 2
    self.scale_y = 0.5
    
    self.sprite:setScaleOrigin(0.5, 0.5);
    
    self.sprite:setScale(1, 4);
    self.inv_timer = 0.3;

    self.spawnedGraze = false;


end
function Lobera:remove()
    
    self.destroyGraze = 1;
    if (self.originWave ~= nil)
        then
        self.originWave.swordAmount = self.originWave.swordAmount + 1;
        if (self.isBroken == true)
            then
            self.originWave.brokenAmount = self.originWave.brokenAmount + 1;
            end
        end
    -- if (self.Line1Sprite ~= nil) then self.Line1Sprite:remove(); end
    if (self.childConnector ~= nil) then self.childConnector:remove(); end
    if (self.childPillar ~= nil) then self.childPillar:remove(); end
    super.remove(self);
end

function Lobera:draw()
    if (self.childPillar ~= nil)
        then
        love.graphics.setColor(0.63, 0.38, 0.76, math.min(self.alpha, 0.5));
        love.graphics.setLineWidth(2);
        love.graphics.line(0, 5, 25 + math.sqrt((((self.childPillar.x - self.x)^2) + ((self.childPillar.y - self.y)^2))) / -2, 2);
        super.draw(self);
        end
end

function Lobera:update()
   -- Kristal.Console:log(self.layer .. " and " .. self.Line1Sprite.layer)
    if (self.spawnedGraze == false) then self.wave:spawnBullet("grazerbullet", self, 3); self.spawnedGraze = true; else end
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.shakeTimer > 0)
        then
        self.shakeTimer = self.shakeTimer - 1 * DTMULT;
        self.shakeX = 5 * self.shakeTimer / self.shakeAmount -- determines shake
        self.shakeY = 2 * self.shakeTimer / self.shakeAmount -- determines shake
        end
    self.physics.direction = self.rotation;
    local attackers2 = Game.battle.waves[1]:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        if (attacker2.id == "maskaught")
            then
            if (((attacker2.sprite.maskaughtArmleft.startSprite == "enemies/MaskaughtCombat/armraise_2") or (Game.battle.waves[1].shouldAttack ~= nil and Game.battle.waves[1].shouldAttack > 0)) and self.alpha >= 0.5)
               then
               self.swordReady = true;
               
               end
            end
        end
    if (self.alpha < 1.0)
        then
        self.alpha = self.alpha + 0.1 * DTMULT;
        else
        end
    if (self.swordReady == false)
        then

        else
        if (self.isBroken == false)
            then
            if (self.swordComplete == false)
                then
                    self.stabVar = self.stabVar + 1 * DTMULT;
                    self.stabState = math.sin(self.stabVar / 100 * self.throwSpeed);
                    -- self.stabState = math.sin(self.stabVar / 20 * self.throwSpeed);
                    -- self.alpha = 1.0 + self.stabState * 2;
                    self.addX = math.cos(self.rotation) * (self.stabState) * self.throwLength;
                    self.addY = math.sin(self.rotation) * (self.stabState) * self.throwLength;
                    if (self.stabState > 0.9) then self.swordComplete = true; self.shakeTimer = self.shakeAmount; end
                
                else
                if (self.stillTime < 10)
                    then
                    self.stillTime = self.stillTime + 1 * DTMULT;
                    else
                    self.completeTime = self.completeTime + 1 * DTMULT;
                    self.returnX = self.returnX + (math.cos(self.rotation) * 8) * DTMULT;
                    self.returnY = self.returnY + (math.sin(self.rotation) * 8) * DTMULT;
                    if (self.addX ~= 0 and self.returnX ~= 0) then self.alpha = 1 - (self.returnX / self.addX); end
                    end
                end
            else -- if isbroken below
            end
        end
    self.x = self.originalX + self.addX + self.shakeX - self.returnX;
    self.y = self.originalY + self.addY + self.shakeY - self.returnY;
    if (self.alpha <= 0)
        then
        -- Kristal.Console:log("removed lobera")
        self:remove();
        end
    
    super.update(self)
end

return Lobera
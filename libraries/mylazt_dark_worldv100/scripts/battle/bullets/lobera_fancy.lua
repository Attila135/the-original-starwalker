local lobera_fancy, super = Class(Bullet)

local pillarSprite = {Assets.getTexture("bullets/lifepillar_1"), Assets.getTexture("bullets/lifepillar_2"), Assets.getTexture("bullets/lifepillar_3"), Assets.getTexture("bullets/lifepillar_4")}

function lobera_fancy:init(x, y, dir, throwSpeed, throwLength, grabArena, makeNoise)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/lobera")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.rotation = dir;
    self.throwSpeed = throwSpeed;
    self.throwLength = throwLength;

    self.grabArena = grabArena;

    self.makeNoise = makeNoise;

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
    self.pillarX = 0;
    self.pillarY = 0;
    self.startX = self.x;
    self.startY = self.y;
    self.spawnX = 0;
    self.spawnY = 0;


end
function lobera_fancy:remove()
    
    self.destroyGraze = 1;
    if (self.wave ~= nil)
        then
        self.wave.swordAmount = self.wave.swordAmount + 1;
        if (self.isBroken == true)
            then
            self.wave.brokenAmount = self.wave.brokenAmount + 1;
            end
        end
    -- if (self.Line1Sprite ~= nil) then self.Line1Sprite:remove(); end
    if (self.childConnector ~= nil) then self.childConnector:remove(); end
    if (self.childPillar ~= nil) then self.childPillar:remove(); end
    super.remove(self);
end

function lobera_fancy:triggered(bulletType, bulletSpeed)
    local centerPos = Game.battle.arena:getCenter();
    self.wave:spawnBulletTo(Game.battle.arena, bulletType, self.startX - Game.battle.arena:getLeft(), self.startY - Game.battle.arena:getTop(), self.rotation, bulletSpeed)
    --Kristal.Console:log("meow");
end

function lobera_fancy:disappear()
    self.isBroken = true;
    self.damage = 0;
    self.tp = 0;
end

function lobera_fancy:draw()
        
        local loberaDirection = Utils.angle(self.startX, self.startY, self.x, self.y);
        local pillarX = (math.sqrt(  (
            ((self.startX - self.x + self.shakeX)^2) 
            + 
            ((self.startY - self.y + self.shakeY)^2) 
            ))  ) / -2;
        local pillarY = 5; -- + (self.startY - self.y + self.shakeY) / -0.5;
        local pillarFrame = 1;

        if (Utils.round(self.x)%100 < 100) then pillarFrame = 4; end
        if (Utils.round(self.x)%100 < 75) then pillarFrame = 3; end
        if (Utils.round(self.x)%100 < 50) then pillarFrame = 2; end
        if (Utils.round(self.x)%100 < 25) then pillarFrame = 1; end

        love.graphics.draw(pillarSprite[pillarFrame], pillarX - 5, pillarY - 16, 0, 1, 4);
        love.graphics.setColor(0.63, 0.38, 0.76, math.min(self.alpha, 0.5));
        love.graphics.setLineWidth(2);

        
        love.graphics.line(0, 5, pillarX, pillarY);
        super.draw(self);
end

function lobera_fancy:update()
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
    if (self.isBroken == false)
        then -- if not broken
        if (self.alpha < 1.0)
            then
            self.alpha = self.alpha + 0.1 * DTMULT;
            else
            end
        else -- if broken
        self.alpha = self.alpha - 0.1 * DTMULT;
        if (self.alpha <= 0) then self:remove(); end
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
                    if (self.grabArena == true)
                        then
                        if (self.x < Game.battle.arena.x - Game.battle.arena.width / 2 + 30) then self.stabState = 1; if (self.makeNoise == true) then Assets.playSound("darkgrabweakest"); end end
                        end
                    if (self.stabState > 0.9) then self.swordComplete = true; self.shakeTimer = self.shakeAmount; end
                
                else
                if (self.stillTime < 1000)
                    then
                    self.stillTime = self.stillTime + 1 * DTMULT;
                    if (self.grabArena == true)
                        then
                            if (Game.battle.arena.x < 340 or 1 == 1) then self.wave:setArenaPosition(Game.battle.arena.x + 0.2 * DTMULT, Game.battle.arena.y); end
                            --Game.battle.arena.x = Game.battle.arena.x + 0.2;
                            self.addX = Game.battle.arena.x - Game.battle.arena.width / 2 - self.originalX;
                        end
                    else
                    self.completeTime = self.completeTime + 1 * DTMULT;
                    self.returnX = self.returnX + (math.cos(self.rotation) * 8) * DTMULT;
                    self.returnY = self.returnY + (math.sin(self.rotation) * 8) * DTMULT;
                    --if (self.addX ~= 0 and self.returnX ~= 0) then self.alpha = 1 - (self.returnX / self.addX); end
                    end
                end
            else -- if isbroken below
            end
        end
    self.x = self.originalX + self.addX + self.shakeX - self.returnX;
    self.y = self.originalY + self.addY + self.shakeY - self.returnY;
    if (self.alpha <= 0)
        then
        -- Kristal.Console:log("removed lobera_fancy")
        self:remove();
        end
    super.update(self)
end

return lobera_fancy
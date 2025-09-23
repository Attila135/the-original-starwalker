local wolfpaw, super = Class(Bullet)

function wolfpaw:init(x, y, leftSide, spinBox)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/wolfpaw")
    
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS
    self.openAnim = {"bullets/wolfpaw", 0.15, false, frames = {4, 4, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1} };
    self.openFastAnim = {"bullets/wolfpaw", 0.05, false, frames = {4, 3, 3, 3, 2, 2, 2, 1} };
    self.sprite:setAnimation(self.openAnim)
    self.physics.speed = speed
    self.sprite.frame = 4;
    self.timeVar = 0;
    self.damage = 0;
    self.tp = 0;
    self.alpha = -0.5;
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.leftSide = leftSide;
    self.faceDirection = 1;
    self.faceAngle = 0;
    self.spinBox = spinBox;
    
    self.originalX = 0;
    self.originalY = 0;
    self.boxX = -1;
    self.boxY = -1;
    self.boxTime = 0;
    self.followSoul = false;
    self.spawnFinale = -10;

    self.swingSpeed = 0.005;
    self:setLayer(145)
    self.boxSlow = 20;
    self.swingCount = 0;
    self.pawVar = 0;
    self.swingDirection = 1;
    self.addX = x;
    self.addY = y;
    self.addRotation = 0;
    self.pawDanceX = 0;
    self.pawDanceY = 0;
    self.danceVar = 0;
    self.rumbleVar = 30;
    self.danceSpeed = 1;

    if (self.leftSide == false) then self.faceDirection = -1; self.faceAngle = math.rad(180); end
    self.destroy_on_hit = false;
    self.shootNumber = 0;
    self.chargeAnim = {"bullets/wolfpaw", self.swingSpeed, false, frames = {1, 2, 3, 4}, 
        callback =function(spritething)
            self.addX = self.addX + 80 * self.faceDirection
            self.addY = self.addY + 60
            self.addRotation = self.addRotation + math.rad(70 * self.faceDirection);
            self.sprite:setAnimation(self.shootAnim);
        end };

    self.shootAnim = {"bullets/wolfpaw", 0.05, false, frames = {4, 4}, 
        callback =function(spritething)
            self.addRotation = 0;
            self.addX = self.originalX;
            self.addY = self.originalY;
            self.shootNumber = self.shootNumber + 1;
            self.sprite:setAnimation(self.openFastAnim);
        end };
    

if (self.leftSide == false)
        then
        self.sprite:setScale(-1, 1)
        end


    self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
self.timeVar = self.timeVar + 1;
    self.pawVar = self.pawVar + 1; 

    if (self.boxSlow > 20) 
        then
        self.boxTime = self.boxTime - 0.3; 
        if (self.boxTime > 10) then self.boxTime = self.boxTime - 0.3; end
        if (self.boxTime > 25) then self.boxTime = self.boxTime - 0.3; if (self.timeVar % 3 == 0) then self:shake(1); Game.battle.arena:shake(1); end end
        Game.battle.arena.y = self.y;
        end
    if (self.boxY ~= -1)
        then
        self.boxTime = self.boxTime + 1
        self.addY = Utils.ease(self.originalY, self.boxY, self.boxTime / self.boxSlow, "in-out-quad")
        end
    if (self.y == self.boxY)
       then
       if (self.leftSide == false)
           then
           if (self.followSoul == false) 
                then
                self.wave:spawnBullet("flashbox", Game.battle.arena.x, Game.battle.arena.y, self.spinBox);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 180, -140);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 160, -120);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 140, -100);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 120, -80);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 100, -60);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 80, -40);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 60, -30);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 40, -20);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 20, -10);
                self.wave:spawnBullet("loberafinale", -999, -999, self, 0, 0); 
                self.wave:spawnBullet("loberafinale", -999, -999, self, -20, -10);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -40, -20);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -60, -30);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -80, -40);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -100, -60);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -120, -80);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -140, -100);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -160, -120);
                self.wave:spawnBullet("loberafinale", -999, -999, self, -180, -140);
                end
           self.followSoul = true;
           self.boxY = self.boxY - 1;
           -- self.addX = Utils.approach(self.x, Game.battle.soul.x, 5); -- follows soul
           end
       end
    if (self.followSoul == true)
        then
        if (self.rumbleVar % 30 == 0 and self.rumbleVar < 180)
                then
                Assets.playSound("rumble")
                -- self.wave:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, math.rad(-90), math.rad(self.swingDirection), 200, 10, "cyan");
                -- self.swingDirection = self.swingDirection * -1;
                end
        self.rumbleVar = self.rumbleVar + 1;
        -- Kristal.Console:log(self.rumbleVar);
        end
    if (self.boxX ~= -1)
        then
        if (self.followSoul == false) then self.addX = Utils.ease(self.originalX, self.boxX, self.boxTime / self.boxSlow, "in-out-quad"); end
        if (self.x == self.boxX)
            then
            if (self.leftSide)
                then
                Assets.playSound("darkgrab");
                self:shake(4);
                Game.battle.arena:shake(4);
                self.boxX = -1;
                self.originalX = self.x;
                self.originalY = self.y;
                self.boxTime = 0;
                self.boxY = self.y + 150;
                self.boxSlow = 50;
                self.sprite:setAnimation({"bullets/wolfpaw", 0.05, false, frames = {4}});
                end
            end
        end
    
    if (self.timeVar == 260)
        then
        -- self.swingSpeed = 0.04;
        self.chargeAnim = {"bullets/wolfpaw", self.swingSpeed, false, frames = {1, 1, 1, 1, 2, 2, 3, 4}, 
        callback =function(spritething)
            self.addX = self.addX + 80 * self.faceDirection
            self.addY = self.addY + 60
            self.addRotation = self.addRotation + math.rad(70 * self.faceDirection);
            self.sprite:setAnimation(self.shootAnim);
        end };
        end
    if (self.timeVar == 400)
        then
        --self.swingSpeed = 0.04;
        self.chargeAnim = {"bullets/wolfpaw", self.swingSpeed, false, frames = {1}};
        self:boxgrab();
            -- self.rotation = self.rotation + math.rad(40 * self.faceDirection);
        end
    if (self.alpha < 1) then self.alpha = self.alpha + 0.02; self.addY = self.y - 1; self.originalX = self.x; self.originalY = self.y; end
    if (self.leftSide == true)
        then
        if (self.timeVar == -80
        or (self.timeVar >= 100 and self.timeVar < 160 and self.pawVar % 30 == 0)
        or (self.timeVar >= 160 and self.timeVar < 235 and (self.pawVar + 0) % 30 == 0)
        or (self.timeVar >= 240 and self.timeVar < 345 and (self.pawVar + 0) % 20 == 0)
        or (self.timeVar >= 345 and self.timeVar < 385 and (self.pawVar + 0) % 20 == 0)
        or self.timeVar == -400
        )
            then
            self:swingpaw();
            end
        end

    if (self.leftSide == false)
        then
        if (self.timeVar == -100
        or (self.timeVar >= 100 and self.timeVar < 160 and self.pawVar % 30 == 0)
        or (self.timeVar >= 160 and self.timeVar < 235 and (self.pawVar + 0) % 30 == 0)
        or (self.timeVar >= 240 and self.timeVar < 345 and (self.pawVar + 0) % 20 == 0)
        or (self.timeVar >= 345 and self.timeVar < 385 and (self.pawVar + 0) % 20 == 0)
        or self.timeVar == -400
        )
            then
            self:swingpaw();
            end
        end
    -- if (self.timeVar >= 160) then self.danceSpeed = self.danceSpeed + 0.5; end
   
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function wolfpaw:swingpaw()
self.spinBox.shouldSound = true;
self.sprite:setAnimation(self.chargeAnim);

local spawnX = Game.battle.arena.x - 300 * self.faceDirection;
local spawnY = Game.battle.arena.y - 10;
local indentY = {-60, -40, -20, 0, 20, 40, 60, 80}; -- 1, 2, 3, 4 (middle), 5, 6, 7

if (self.swingCount % 4 <= 1)
    then
        if (self.leftSide == true)
        then
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
        else
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[8], self.faceAngle, 8);
        end
    else
        if (self.leftSide == true)
        then
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[8], self.faceAngle, 8);
        else
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
        end
    end
-- if (self.swingCount ~= -1) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8); end
-- if (self.swingCount ~= -1 and self.swingCount ~= 0 and self.swingCount ~= 3 and self.swingCount ~= 11) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8); end
-- if (self.swingCount ~= -1 and self.swingCount ~= 0 and self.swingCount ~= 2 and self.swingCount ~= 4 and self.swingCount ~= 10) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8); end
-- if (self.swingCount ~= -1 and self.swingCount ~= 0 and self.swingCount ~= 5 and self.swingCount ~= 12) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8); end
-- if (self.swingCount ~= -1 and self.swingCount ~= 0 and self.swingCount ~= 1 and self.swingCount ~= 6 and self.swingCount ~= 9) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8); end
-- if (self.swingCount ~= -1 and self.swingCount ~= 0 and self.swingCount ~= 7) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8); end
-- if (self.swingCount ~= -1 and self.swingCount ~= 8) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8); end

-- previous paw below
--nvm--if (self.leftSide == true)
--nvm--    then
--nvm--    if (self.swingCount < 7)
--nvm--        then
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
--nvm--        -- self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
--nvm--        --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
--nvm--        -- self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
--nvm--        else
--nvm--        if (self.swingCount < 10)
--nvm--            then
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
--nvm--            if (self.swingCount > 8) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8); end
--nvm--            if (self.swingCount > 7) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8); end
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
--nvm--            else
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
--nvm--            end
--nvm--        end
--nvm--    else
--nvm--    -- rightside
--nvm--    if (self.swingCount < 7)
--nvm--        then
--nvm--        -- self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
--nvm--        --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
--nvm--        -- self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
--nvm--        self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
--nvm--        -- self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
--nvm--        else 
--nvm--        if (self.swingCount < 10)
--nvm--            then
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
--nvm--            if (self.swingCount > 7) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8); end
--nvm--            if (self.swingCount > 8) then self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8); end
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
--nvm--            else
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[1], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[2], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[3], self.faceAngle, 8);
--nvm--            --self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[4], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[5], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[6], self.faceAngle, 8);
--nvm--            self.wave:spawnBullet("loberapierce", spawnX, spawnY + indentY[7], self.faceAngle, 8);
--nvm--            end
--nvm--        end
--nvm--    end
-- previous paw above
self.swingCount = self.swingCount + 1;
 if (self.swingCount == 7) then self.danceSpeed = self.danceSpeed + 1; end
    if (self.swingCount == 10) then self.danceSpeed = self.danceSpeed + 1; end

end

function wolfpaw:boxgrab()
if (self.leftSide == true)
    then
    self.boxX = Game.battle.arena.x - (Game.battle.arena.width * self.faceDirection) + (80 * self.faceDirection);
    self.boxY = Game.battle.arena.y;
    self.addRotation = self.addRotation - math.rad(30);
    end
if (self.leftSide == false)
    then
    self.boxX = Game.battle.arena.x;
    self.boxY = Game.battle.arena.y + 380;
    end




end

function wolfpaw:update()
    -- For more complicated bullet behaviours, code here gets called every update
    
    if (self.timeVar > 80 and self.timeVar <= 399) 
        then
        self.danceVar = self.danceVar + self.danceSpeed * DTMULT; 
        self.pawDanceX = 20 * math.sin(self.danceVar / 10); 
        self.pawDanceY = 12 * math.sin(self.danceVar * 2 / 10); 
        else
        self.pawDanceX = Utils.approach(self.pawDanceX, 0, 5); -- follows soul
        self.pawDanceY = Utils.approach(self.pawDanceY, 0, 5); -- follows soul
        end
    self.x = self.addX + self.pawDanceX;
    self.y = self.addY + self.pawDanceY;
    self.rotation = self.addRotation;
    if (self.spinBox.shouldKill == true) then self:remove(); end
    super.update(self)
end

return wolfpaw
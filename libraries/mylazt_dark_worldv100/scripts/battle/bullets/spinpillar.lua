local SpinPillar, super = Class(Bullet)

function SpinPillar:onCollide(soul)
super.onCollide(self, soul)
if (self.damage > 0 and self.isDark == true)
    then
            -- Kristal.Console:log("fakecollidee!")
            local targets = Game.battle:getPartyFromTarget(self:getTarget())
            for _, target in ipairs(targets) do
            -- Kristal.Console:log("fakecollidee!")
            -- target.x = target.x + 5
            target.isCursed = true
        
            end
    end
end

function SpinPillar:init(x, y, lengthX, lengthY, speedX, speedY, timeX, timeY, pillarType, laserInitial, laserCooldown, laserRotation)
    -- Last argument = sprite path
    self.pillarType = pillarType;
    super.init(self, x, y, "bullets/" .. self.pillarType .. "pillar") -- spin or laser
    if (self.pillarType == "laser")
        then
        self.laserTime = laserInitial;
        self.laserTimeMax = laserCooldown; -- self.laserTime;
        end
    if (self.pillarType == "spin")
        then
        self.isBreak = true;
        self.breakType = "pillar";
        end
    if (self.pillarType == "dark")
        then
        self.laserTime = laserInitial;
        self.laserTimeMax = laserCooldown; -- self.laserTime;
        self.isDark = true;
        end

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.originX = x;
    self.originY = y;
    self.addMaskaughtX = 0;
    self.addMaskaughtY = 0;
    self.addX = 0;
    self.addY = 0;
    self.timeVar = 0;
    self.timeVarX = timeX;
    self.timeVarY = timeY;
    self.lengthX = lengthX;
    self.lengthY = lengthY;
    self.speedX = speedX;
    self.speedY = speedY;
    self.originMaskaught = nil;
    self.childConnector = nil;
    self.speedReduceX = 200;

    
    
    self.damage = 80;
    self.tp = 1.6;
    self.damageIntend = self.damage;
    self.tpIntend = self.tp;
    self.scale_x = 1
    self.scale_y = 1
    self.destroy_on_hit = false
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(2, 2)self.destroy_on_hit = false;
    self.alpha = 0;
    self.addAlpha = 0;
    self.reduceAlpha = 0;
    self.alphaMain = 0.3;
    self.inv_timer = 0.3;
    
    self.initialAlphaReduction = 1;

    self.laserMoment = 0;
    self.laserRotation = laserRotation;

    self.addLineX = love.math.random(-5, 5);
    self.addLineY = love.math.random(-10, 10);

    --self.layer = 700;
    -- self.layerIntend = self.layer;
end
function SpinPillar:startLaser()
    self.laserMoment = 1;
end

function SpinPillar:draw()
    if (self.originMaskaught ~= nil)
        then
        love.graphics.setColor(0.63, 0.38, 0.76, self.alpha - 0.7);
        --if (self.isDark ~= nil) then love.graphics.setColor(0.8, 0.8, 0.8, self.alpha - 0.7); end
        love.graphics.setLineWidth(1);
        love.graphics.line(0, 0, self.originMaskaught.x - self.x + self.addLineX, self.originMaskaught.y - self.y + 14 + self.addLineY);
        super.draw(self);
        end
end

function SpinPillar:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.addAlpha < 1) then self.addAlpha = self.addAlpha + 0.05 * DTMULT; end
    if (self.initialAlphaReduction > 0) then self.initialAlphaReduction = self.initialAlphaReduction - 0.02 * DTMULT; end
    if (self.originMaskaught ~= nil)
        then
        local theY = Game.battle.arena.y - self.y;
        self.originMaskaught.sprite.pillarTime = 2;

        -- if (Utils.round(self.x)%150 < 150) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end
        -- if (Utils.round(self.x)%150 < 125) then self.sprite:setSprite("bullets/spinpillar_5", 0, false) end
        -- if (Utils.round(self.x)%150 < 100) then self.sprite:setSprite("bullets/spinpillar_4", 0, false) end
        -- if (Utils.round(self.x)%150 < 75) then self.sprite:setSprite("bullets/spinpillar_3", 0, false) end
        -- if (Utils.round(self.x)%150 < 50) then self.sprite:setSprite("bullets/spinpillar_2", 0, false) end
        -- if (Utils.round(self.x)%150 < 25) then self.sprite:setSprite("bullets/spinpillar_1", 0, false) end

        -- if (Utils.round(self.x)%150 < 150) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end
        -- if (Utils.round(self.x)%150 < 125) then self.sprite:setSprite("bullets/spinpillar_5", 0, false) end
        -- if (Utils.round(self.x)%150 < 100) then self.sprite:setSprite("bullets/spinpillar_4", 0, false) end
        -- if (Utils.round(self.x)%150 < 75) then self.sprite:setSprite("bullets/spinpillar_3", 0, false) end
        -- if (Utils.round(self.x)%150 < 50) then self.sprite:setSprite("bullets/spinpillar_2", 0, false) end
        -- if (Utils.round(self.x)%150 < 25) then self.sprite:setSprite("bullets/spinpillar_1", 0, false) end
        -- Kristal.Console:log(self.speedReduceX);
        --selfreminder-- if (self.speedReduceX > 190) then self.speedReduceX = self.speedReduceX - 0.25 * DTMULT; end
        self.timeVar = self.timeVar + 1 * DTMULT;
        if (self.timeVar > self.timeVarX * -1) then self.addX = math.abs(math.sin((self.timeVar + self.timeVarX) * self.speedX / self.speedReduceX)) * (self.lengthX * -1); end
        local sinY = math.sin((self.timeVar + self.timeVarY) * self.speedX / self.speedReduceX);
        local sinYFancy = (math.cos((self.timeVar + self.timeVarY) * self.speedX / self.speedReduceX));

        local sinYFrame = sinY;
        self.devY = sinYFrame;

        if (self.isDark == nil)
        then

            if (sinYFrame <= 6/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_6", 0, false) end
            if (sinYFrame <= 5/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_5", 0, false) end
            if (sinYFrame <= 4/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_4", 0, false) end
            if (sinYFrame <= 3/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_3", 0, false) end
            if (sinYFrame <= 2/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_2", 0, false) end
            if (sinYFrame <= 1/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_1", 0, false) end
            if (sinYFrame <= 0) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_6", 0, false) end
            if (sinYFrame <= -1/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_5", 0, false) end
            if (sinYFrame <= -2/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_4", 0, false) end
            if (sinYFrame <= -3/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_3", 0, false) end
            if (sinYFrame <= -4/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_2", 0, false) end
            if (sinYFrame <= -5/6) then self.sprite:setSprite("bullets/" .. self.pillarType .. "pillar_1", 0, false) end

        end

        -- if (sinYFrame <= 6/6) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end
        -- 
        -- if (sinYFrame <= 4/6) then self.sprite:setSprite("bullets/spinpillar_5", 0, false) end
        -- 
        -- if (sinYFrame <= 2/6) then self.sprite:setSprite("bullets/spinpillar_4", 0, false) end
        -- 
        -- if (sinYFrame <= 0) then self.sprite:setSprite("bullets/spinpillar_3", 0, false) end
        -- 
        -- if (sinYFrame <= -2/6) then self.sprite:setSprite("bullets/spinpillar_2", 0, false) end
        -- 
        -- if (sinYFrame <= -4/6) then self.sprite:setSprite("bullets/spinpillar_1", 0, false) end
      



        --c if (sinYFrame <= 1/6) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end

        -- if (sinYFrame <= -0.2) then self.sprite:setSprite("bullets/spinpillar_5", 0, false) end
        -- if (sinYFrame <= -0.4) then self.sprite:setSprite("bullets/spinpillar_5", 0, false) end
        -- if (sinYFrame <= -0.6) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end
        -- if (sinYFrame <= -0.8) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end
        --if (sinYFrame <= -1) then self.sprite:setSprite("bullets/spinpillar_6", 0, false) end



        self.addY = sinY / 2 * (self.lengthY);
        
        self.reduceAlpha = math.min(0, sinYFancy);
        self.addMaskaughtY = (self.originMaskaught.y - self.originY - 10)
        -- self.x = self.originX self.addX;
        end 
    self.x = self.addX + self.originX + self.addMaskaughtX;
    self.y = self.addY + self.originY + self.addMaskaughtY;
    self.alpha = self.addAlpha + self.reduceAlpha;
    

    if (self.reduceAlpha >= 0)
            then
            -- self.reduceAlpha = 0;
            self.damage = self.damageIntend;
            self.tp = self.tpIntend;
            self:setLayer(350);
            else
            -- self.reduceAlpha = 1;
            self.damage = 0;
            self.tp = 0;
            self:setLayer(200);
            end

    if (self.alpha < self.alphaMain) then self.alpha = self.alphaMain; end
    self.alpha = self.alpha - self.initialAlphaReduction;
    if (self.childConnector ~= nil)
        then
        
        self.childConnector:setLayer(self.layer - 1);
        self.childConnector.alpha = self.alpha;
        if (self.childConnector.alpha > 0.3) then self.childConnector.alpha = 0.3; end
        -- self.childConnector.alpha = 0;
        -- self.childConnector.alpha = self.alpha - 0.4;
        -- Kristal.Console:log(self.childConnector.layer);
        end

    if (self.laserTime ~= nil)
        then
        self.laserTime = self.laserTime - 1 * DTMULT;
        if (self.laserTime <= 0)
            then
            self.laserTime = self.laserTimeMax;
            self:startLaser();

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua

            end
        end
    if (self.laserMoment > 0)
        then
        self.laserMoment = self.laserMoment - 1 * DTMULT;
        if (self.laserMoment <= 0)
            then
            local angle = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y);
            -- self.wave:spawnBullet("smallbullet", self.x, self.y, angle, 6);
            self.wave:spawnBullet("laserwarning", 0, 0, self.laserRotation, self);
            end
        end

    super.update(self)
end

return SpinPillar
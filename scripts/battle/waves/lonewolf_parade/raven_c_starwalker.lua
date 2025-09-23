local raven_c, super = Class(Wave)
local angleChange = 1
local clawTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function raven_c:onDamage(soul)
-- super.onDamage(self)
-- Kristal.Console:log("Cursed real!")
-- if Game:getConfig("targetSystem") then
-- 			local target = self:getTarget()
-- 
-- 			target:heal(amountHealed)
-- 		else
-- 			local target = Utils.pick(Game.party)
-- 			target:heal(amountHealed)
-- 		end
-- end

function raven_c:ClawMoveTo(posX, posY)
local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers)
        do
        self.moveVar = 0;
        self.initialX = attacker.x;
        self.initialY = attacker.y;
        self.desX = posX;
        self.desY = posY;
        end
end

function raven_c:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function raven_c:init()
super.init(self);
self:setArenaSize(200, 142)
end
function raven_c:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 13.5;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.attackAmount = 3
    self.clawTimeVar = -5
    self.angleChange = 0
    self.moveVar = 0;
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        self.initialX = attacker2.x
        self.initialY = attacker2.y
        self.desX = attacker2.x + 60;-- + love.math.random(0, 50)
        self.desY = attacker2.y;
        if (attacker2.onAir == false) then attacker2:StartSwirl(6) end
        --if (attacker2.sprite.anim == "swirled") then self.time = 8.6; end
        end
    self.throwMoveLevel = 20;
    self.oppositeY = 1;
    self.swingDirection = 1;
    self.timeVar = 0;
    self.ravenCount = 0;
    self.ravenSwapX = Utils.pick({-1, 1});
    self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.timeVar = self.timeVar + 1;
    if (self.timeVar % 20 == 0) 
        then
        local ravenSpeed = 16;
        local ravenDelay = 1.0;
        if (self.ravenCount % 2 == 0 or self.ravenCount == 0)
            then
            local ravenAngle = Utils.pick({
                {0, 90, 90, 90}, 
                {90, 0, 90, 90}, 
                {90, 90, 0, 90}, 
                {90, 90, 90, 0}, 
            });
            if (self.ravenCount <= 2)
                then
                    self:spawnBullet("raven", Game.battle.arena.x - 20 * self.ravenSwapX, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, ravenDelay, true);
                    self:spawnBullet("raven", Game.battle.arena.x - 40 * self.ravenSwapX, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, ravenDelay, true);
                    self:spawnBullet("raven", Game.battle.arena.x - 60 * self.ravenSwapX, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, ravenDelay, true);
                    self:spawnBullet("raven", Game.battle.arena.x - 80 * self.ravenSwapX, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, ravenDelay, true);
                    self:spawnBullet("raven", Game.battle.arena.x - 100 * self.ravenSwapX, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, ravenDelay, true);
                    self.ravenSwapX = self.ravenSwapX * -1;

                else
                self:spawnBullet("raven", Game.battle.arena.x - 20, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[1]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 40, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[1]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 60, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[1]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 80, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[1]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 100, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[1]), ravenSpeed, ravenDelay, true);
                -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
                -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 20, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[2]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 40, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[2]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 60, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[2]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 80, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[2]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 100, Game.battle.arena.y - 100, 0, -50, math.rad(90 + ravenAngle[2]), ravenSpeed, ravenDelay, true);

                self:spawnBullet("raven", Game.battle.arena.x - 20, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[3]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 40, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[3]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 60, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[3]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 80, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[3]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x - 100, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[3]), ravenSpeed, ravenDelay, true);
                -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
                -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 20, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[4]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 40, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[4]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 60, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[4]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 80, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[4]), ravenSpeed, ravenDelay, true);
                self:spawnBullet("raven", Game.battle.arena.x + 100, Game.battle.arena.y + 100, 0, 50, math.rad(-90 + ravenAngle[4]), ravenSpeed, ravenDelay, true);
                end
            end
        self.ravenCount = self.ravenCount + 1;
        end
    if (self.timeVar % 20 == 0 and ((self.timeVar < 250 and self.time > 10) or (self.timeVar < 190 and self.time <= 10)) )
    then
        --self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, 0, 0.020 * self.swingDirection, 200, 20, Utils.pick({"cyan", "orange"}) );
        self.swingDirection = self.swingDirection * -1;
    end
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers)
    do

    attacker.x = Utils.ease(self.initialX, self.desX, self.moveVar / self.throwMoveLevel, "in-out-quad")
    attacker.y = Utils.ease(self.initialY, self.desY, self.moveVar / self.throwMoveLevel, "in-out-quad")
    local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
    if (self.clawTimeVar > 60) then self.clawTimeVar = 0; end
    end
-- FIXER END BELOW
    end)
-- FIXER MULT END


    --local targetX = Game.battle.arena.x;
    local ravenSpeed = 16;
    self.timer:every(0.2, function()
    self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y - 100, 0, -50, math.rad(Utils.pick({90, 90})), ravenSpeed, 1, false);
    --self:spawnBullet("raven", Game.battle.arena.y, Game.battle.arena.y, -50, 0, math.rad(0), ravenSpeed, 1, false);
        end, 60)
end

function raven_c:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)

    -- claw attack below
    
    self.clawTimeVar = self.clawTimeVar + 1 * DTMULT;
    self.moveVar = self.moveVar + 1 * DTMULT;
    super.update(self)
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers)
    do

    --attacker.y = Utils.ease(self.initialY, self.desY, self.moveVar / self.throwMoveLevel, "in-out-quad")
    --attacker.x = Utils.ease(self.initialX, self.desX, self.moveVar / self.throwMoveLevel, "in-out-quad")
    local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
    if (self.clawTimeVar > 60) then self.clawTimeVar = 0; end
    if (attacker.scale_x == 2 and
            (
            self.clawTimeVar == -20 or
            self.clawTimeVar == -40 or
            self.clawTimeVar == 60
            ))
            then
            local changeAmount = 40 * self.oppositeY;
            local changeY = changeAmount;
            local targetX = Game.battle.soul.x;
            --nvm--local spawnBullet1 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            --nvm--spawnBullet1.originMaskaught = attacker; changeY = changeY + changeAmount;
            
            

            -- local spawnBullet3 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            -- spawnBullet3.originMaskaught = attacker; changeY = changeY + changeAmount;
            -- 
            -- local spawnBullet4 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            -- spawnBullet4.originMaskaught = attacker; changeY = changeY + changeAmount;
            -- 
            -- local spawnBullet5 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            -- spawnBullet5.originMaskaught = attacker;

            --nvm--local spawnBullet2 = self:spawnBullet("dustclaw", targetX, 500, Utils.angle(targetX, 500, targetX, Game.battle.soul.y), 4, targetX, Game.battle.soul.y)
            --nvm--spawnBullet2.originMaskaught = attacker;
            self.oppositeY = self.oppositeY * -1;
            end
    if (Utils.dist(attacker.x, attacker.y, self.desX, self.desY) < 10) 
        then -- when reached destination
        
        --if (attacker.swirlLifetime > 0) then attacker:EndSwirl() end
        -- if (self.clawTimeVar == 0)
        --     then
        --     self:spawnBullet("dustclaw", x, y + 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 50), 3, Game.battle.soul.x, Game.battle.soul.y + 50)
        --     self:spawnBullet("dustclaw", x, y, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 3, Game.battle.soul.x, Game.battle.soul.y)
        --     self:spawnBullet("dustclaw", x, y - 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 50), 3, Game.battle.soul.x, Game.battle.soul.y - 50)
        --     end 
        
        if (attacker.scale_x == 2 and
            (
            self.clawTimeVar == 20 or
            self.clawTimeVar == 40 or
            self.clawTimeVar == 60 or
            1 == 1
            ) and 1 == 0)
            then

            local otherX = 50;
            local otherY = Game.battle.arena.y;
            
            if (self.clawTimeVar == 20)
                then 
                self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y - 40)
                --nvm--self:spawnBullet("dustclaw", x, y + 25, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 25), 5, Game.battle.soul.x, Game.battle.soul.y + 25)
                --nvm--self:spawnBullet("dustclaw", x, y + 75, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 75), 5, Game.battle.soul.x, Game.battle.soul.y + 75)

                -- self:spawnBullet("dustclaw", otherX, otherY + 25, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y + 25), 5, Game.battle.soul.x, Game.battle.soul.y + 25)
                -- self:spawnBullet("dustclaw", otherX, otherY + 75, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y + 75), 5, Game.battle.soul.x, Game.battle.soul.y + 75)
                end
                if (self.clawTimeVar == 40)
                then
                self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.soul.y + 60)
                --local ravenSpeed = 16;
                --self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 20, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y - 0, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y - 20, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm--self:spawnBullet("dustclaw", x, y - 25, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 25), 5, Game.battle.soul.x, Game.battle.soul.y - 25)
                --nvm--self:spawnBullet("dustclaw", x, y - 75, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 75), 5, Game.battle.soul.x, Game.battle.soul.y - 75)
                
                -- self:spawnBullet("dustclaw", otherX, otherY - 25, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y - 25), 5, Game.battle.soul.x, Game.battle.soul.y - 25)
                -- self:spawnBullet("dustclaw", otherX, otherY - 75, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y - 75), 5, Game.battle.soul.x, Game.battle.soul.y - 75)
                end
                if (self.clawTimeVar == -60)
                then
                self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y + 40)
                end
            
            if (self.timeVar % 130 == 0 and 1 == 0)
                then
                local spawnBullet1 = self:spawnBullet("dustclaw", x, y + 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 50), 4, Game.battle.soul.x, Game.battle.soul.y + 50)
                self:spawnBullet("dustclaw", x, y, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 4, Game.battle.soul.x, Game.battle.soul.y)
                self:spawnBullet("dustclaw", x, y - 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 50), 4, Game.battle.soul.x, Game.battle.soul.y - 50)
                spawnBullet1.originMaskaught = attacker;
                end

            -- self:spawnBullet("dustclaw", otherX, otherY + 50, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y + 50), 4, Game.battle.soul.x, Game.battle.soul.y + 50)
            -- self:spawnBullet("dustclaw", otherX, otherY, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y), 4, Game.battle.soul.x, Game.battle.soul.y)
            -- self:spawnBullet("dustclaw", otherX, otherY - 50, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y - 50), 4, Game.battle.soul.x, Game.battle.soul.y - 50)
            
            end
        end
    end
    -- claw attack above

end

return raven_c
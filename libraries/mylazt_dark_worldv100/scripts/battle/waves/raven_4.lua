local raven_4, super = Class(Wave)
local angleChange = 1
local clawTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function raven_4:onDamage(soul)
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

function raven_4:ClawMoveTo(posX, posY)
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

function raven_4:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end

function raven_4:init()
super.init(self);
self:setArenaSize(142, 200)
end

function raven_4:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 11.4;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.attackAmount = 3
    self.clawTimeVar = -5
    self.angleChange = 0
    self.moveVar = 0;
    --local attackers2 = self:getAttackers()
    --for _, attacker2 in ipairs(attackers2)
    --    do
    --    self.initialX = attacker2.x
    --    self.initialY = attacker2.y
    --    self.desX = attacker2.x + 60;-- + love.math.random(0, 50)
    --    self.desY = attacker2.y;
    --    if (attacker2.onAir == false) then attacker2:StartSwirl(6) end
    --    if (attacker2.sprite.anim == "swirled") then self.time = 8.6; end
    --    end
    self.throwMoveLevel = 20;
    self.oppositeY = 1;
    self.swingDirection = 1;
    self.timeVar = 0;
    self.ravenCount = 0;
    self.ravenAmount = 0;


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

    self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.timeVar = self.timeVar + 1;
    if (self.timeVar % 5 == 0)
        then
        local ravenSpeed = 10;
        local ravenDelay = 0.6;
        self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
        end
    if (self.timeVar % 20 == 0) 
        then
        local ravenSpeed = 10;
        local ravenDelay = 0.6;
        if (self.ravenCount % 2 == 0 or self.ravenCount == 0)
            then
            local ravenDark = true;
            ravenDark = Utils.pick({true, false});
            self.ravenAmount = self.ravenAmount + 1;
            if (self.ravenAmount % 2 == 0) then ravenDark = true; else ravenDark = false; end
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 100, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 80, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            ravenDark = not ravenDark;
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -80, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -100, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);

            ravenDark = false;
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + -20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            --nvm--self:spawnBullet("raven", Game.battle.arena.x + 220, Game.battle.arena.y + -60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, ravenDark);
            else
            --nvm--if (Utils.pick({1, 2}) == 1)
            --nvm--    then
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 80, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 00, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -80, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--
            --nvm--    else
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 80, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + -80, 50, 0, math.rad(180), ravenSpeed, ravenDelay, true);
            --nvm--
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 60, 50, 0, math.rad(180), ravenSpeed, ravenDelay, false);
            --nvm--    end
            end
        self.ravenCount = self.ravenCount + 1;
        end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function raven_4:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)

    -- claw attack below
    


    super.update(self)
    
end

return raven_4
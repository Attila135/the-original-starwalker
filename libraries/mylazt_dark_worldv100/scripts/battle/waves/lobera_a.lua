local lobera_a, super = Class(Wave)
local angleChange = 1
local loberaTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0

-- function lobera_a:onDamage(soul)
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



function lobera_a:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function lobera_a:init()
super.init(self);
self:setArenaPosition(160, 170)
self:setArenaSize(202, 142)
end

function lobera_a:spawnLobera(bulletX, bulletY, bulletR, bulletSpeed, bulletLength, bulletGrab, bulletNoise)
    self.swordsSpawned = self.swordsSpawned + 1;
    Assets.playSound("darksummon")
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        if (attacker2.id == "maskaught" and attacker2.actor.name == "MaskaughtCombat")
            then
    attacker2.sprite.raiseTime = attacker2.sprite.raiseDuration;
            end
        end
    return self:spawnBullet("lobera_fancy", bulletX, bulletY, bulletR, bulletSpeed, bulletLength, bulletGrab, bulletNoise);
end

function lobera_a:triggerLobera(theLobera, bulletSpeed, bulletType)
    if (theLobera ~= nil)
        then
        theLobera:triggered(bulletType, bulletSpeed);
        
        --Kristal.Console:log("woof");
        self.triggerCount = self.triggerCount + 1;
        end
end

function lobera_a:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 14.95;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.randomPawNum = love.math.random(0, 360)

    -- self.spinSpeeder = Utils.pick({10, 8, -10, -8})
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    self.initialX = attacker2.x
    self.initialY = attacker2.y

    -- wave lobera below
    self.loberaTimeVar = 0
    self.loberaReady = false;
    self.swordSpawnX = 0;
    self.swordSpawnY = 0;
    self.swordsSpawned = 0;
    self.brokenMax = 20;
    self.brokenAmount = 0;
    self.swordAmount = self.brokenMax;
    self.attackStraight = 0;

    self.triggerCount = 0;

    self.loberaList = {nil, nil}

    --self.updatedHide = false;
    -- wave lobera above
    --local ravenY = 0;
    --self:spawnBullet("raven", Game.battle.arena.x - 60, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x - 30, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x - 0, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x + 30, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x + 60, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    

    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y - 60, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y - 40, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y - 20, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y + 0, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y + 20, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y + 40, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y + 60, -50, 0, math.rad(0), 0, 3, false);


    --ravenY = -40;
    --self:spawnBullet("raven", Game.battle.arena.x - 60, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x - 30, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x - 0, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x + 30, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    --self:spawnBullet("raven", Game.battle.arena.x + 60, Game.battle.arena.y + ravenY, -50, 0, math.rad(0), 0, 3, false);
    
    --local targetX = Game.battle.arena.x;
    --local ravenSpeed = 16;
    --self.timer:every(0.2, function()
    ----self:spawnBullet("raven", targetX, Game.battle.arena.y - 100, 0, -50, math.rad(Utils.pick({90, 90})), ravenSpeed, 1, false);
    --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y, -50, 0, math.rad(0), ravenSpeed, 1, false);
    --    end, 40)
    -- attacker2:StartSwirl()
    end

    self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.loberaTimeVar = self.loberaTimeVar + 1;
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        if (attacker2.id == "maskaught" and attacker2.actor.name == "MaskaughtCombat")
            then
            --if (self.updatedHide == false) then attacker2.sprite:PartSet(attacker2.sprite.maskaughtArmleft, "enemies/MaskaughtCombat/armraise_1"); self.updatedHide = true; end
            attacker2.sprite.raiseDuration = 16; -- sets how fast lobera shooting is
            if (self.loberaTimeVar >= 170) then self.loberaTimeVar = 0; end
            if (self.loberaTimeVar == 60
            )
                then
                local ravenSpeed = 16;
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 60, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 40, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 20, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 0, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + -20, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- --self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + -40, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + -60, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --local targetX = Game.battle.soul.x;
                --self.timer:every(0.2, function()
                --    self:spawnBullet("raven", targetX, Game.battle.arena.y - 100, 0, -50, math.rad(Utils.pick({85, 95})), ravenSpeed, 1, false);
                --    end, 20)
                end
            if (self.loberaTimeVar == 110
            )
                then
                local ravenSpeed = 16;
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 60, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- --self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 40, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 20, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + 0, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + -20, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + -40, -50, 0, math.rad(0), ravenSpeed, 1, false);
                --nvm-- self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.arena.y + -60, -50, 0, math.rad(0), ravenSpeed, 1, false);
                end
            if (self.triggerCount < 14)
                then
                if (self.loberaTimeVar == -1) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 20) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 50) then self:triggerLobera(self.loberaList[1], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 60) then self:triggerLobera(self.loberaList[1], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 114) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 124) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 150) then self:triggerLobera(self.loberaList[1], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 160) then self:triggerLobera(self.loberaList[1], 5, "fancy_lineward");
                    end
                end
            if (self.swordAmount > 0)
                then
                if (self.loberaTimeVar == 20 or
                    self.loberaTimeVar == 22 or
                    self.loberaTimeVar == -1 or
                    self.loberaTimeVar == -1)
                    then

                    if (self.attackStraight == -1) then self.attackStraight = 2; end

                    
                    self.loberaReady = true;
                    local bulletX = Game.battle.arena.x + 320;
                    local bulletY = Game.battle.arena.y;
                    local bulletR = math.rad(180);

                    if (self.swordsSpawned == 0) 
                        then
                        bulletY = bulletY - 50;
                        self.loberaList[1] = self:spawnLobera(bulletX, bulletY, bulletR, 4, 560, true, true);
                    elseif (self.swordsSpawned == 1) 
                        then
                        bulletY = bulletY + 50;
                        self.loberaList[2] = self:spawnLobera(bulletX, bulletY, bulletR, 4, 560, true);
                        end

                   
                   
                    -- attacker2:setAnimation("raise");
                end
                if (attacker2.sprite.maskaughtArmleft.startSprite == "enemies/MaskaughtCombat/armraise_1") --and attacker2.sprite.frame == 1)
                    then
                
                    end
                 if (attacker2.sprite.maskaughtArmleft.startSprite == "enemies/MaskaughtCombat/armraise_2" and self.loberaReady == true)-- attacker2.sprite.anim == "raise" and attacker2.sprite.frame == 3 and self.loberaReady == true)
                    then
                    Assets.playSound("darkstrike")
                    self.loberaReady = false;
                
                    end
                end

            end
        end
-- FIXER END BELOW
    end)
-- FIXER MULT END
    
end

function lobera_a:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    -- wave lobera below
    
    -- wave lobera above

    super.update(self)
    

end

return lobera_a
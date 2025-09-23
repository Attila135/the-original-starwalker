local lobera_b, super = Class(Wave)
local angleChange = 1
local loberaTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0

-- function lobera_b:onDamage(soul)
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



function lobera_b:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function lobera_b:init()
super.init(self);
self:setArenaPosition(160, 170)
self:setArenaSize(202, 142)
end

function lobera_b:spawnLobera(bulletX, bulletY, bulletR, bulletSpeed, bulletLength, bulletGrab, bulletNoise)
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

function lobera_b:triggerLobera(theLobera, bulletSpeed, bulletType)
    if (theLobera ~= nil)
        then
        theLobera:triggered(bulletType, bulletSpeed);
        
        --Kristal.Console:log("woof");
        self.triggerCount = self.triggerCount + 1;
        end
end

function lobera_b:resetLobera()
    for _,bullet in ipairs(Game.stage:getObjects(Bullet))
        do
        if (bullet.id == "lobera_fancy") then bullet:disappear(); end
        end
end

function lobera_b:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 19.75;
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

    self.loberaList = {nil, nil, nil, nil, nil, nil}

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
            --if (self.loberaTimeVar >= 170) then self.loberaTimeVar = 0; end
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
            if (self.triggerCount < 140)
                then
                if (self.loberaTimeVar == -1) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == -40) then self:triggerLobera(self.loberaList[1], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 45) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 50) then self:triggerLobera(self.loberaList[3], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 85) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 80) then self:triggerLobera(self.loberaList[3], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 110) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 115) then self:triggerLobera(self.loberaList[3], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 120) then self:triggerLobera(self.loberaList[4], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 150) then self:triggerLobera(self.loberaList[3], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 155) then self:triggerLobera(self.loberaList[2], 5, "fancy_lineward");
                elseif (self.loberaTimeVar == 160) then self:triggerLobera(self.loberaList[1], 5, "fancy_lineward");

                elseif (self.loberaTimeVar == 190) then self:triggerLobera(self.loberaList[1], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 195) then self:triggerLobera(self.loberaList[1], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 225) then self:triggerLobera(self.loberaList[2], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 230) then self:triggerLobera(self.loberaList[2], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 250) then self:triggerLobera(self.loberaList[3], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 255) then self:triggerLobera(self.loberaList[3], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 285) then self:triggerLobera(self.loberaList[4], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 290) then self:triggerLobera(self.loberaList[4], 4, "fancy_lineward");
                elseif (self.loberaTimeVar == 330) then self:resetLobera();
                elseif (self.loberaTimeVar == 340) then self.timer:tween(1.0, Game.battle.arena, {x = 160, x = 170}, 'in-out-quad');

                elseif (self.loberaTimeVar == 390) then self:triggerLobera(self.loberaList[2], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 395) then self:triggerLobera(self.loberaList[3], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 400) then self:triggerLobera(self.loberaList[1], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 430) then self:triggerLobera(self.loberaList[5], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 435) then self:triggerLobera(self.loberaList[4], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 440) then self:triggerLobera(self.loberaList[6], 8, "fancy_lineward");

                elseif (self.loberaTimeVar == 475) then self:triggerLobera(self.loberaList[4], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 480) then self:triggerLobera(self.loberaList[4], 8, "fancy_lineward");

                elseif (self.loberaTimeVar == 505) then self:triggerLobera(self.loberaList[1], 8, "fancy_lineward");
                elseif (self.loberaTimeVar == 510) then self:triggerLobera(self.loberaList[1], 8, "fancy_lineward");



                    end
                end
            if (self.swordAmount > 0)
                then
                if (self.loberaTimeVar == 20 or
                    self.loberaTimeVar == 22 or
                    self.loberaTimeVar == 28 or
                    self.loberaTimeVar == 32 or
                    self.loberaTimeVar == 360 or
                    self.loberaTimeVar == 362 or
                    self.loberaTimeVar == 364 or
                    self.loberaTimeVar == 366 or
                    self.loberaTimeVar == 368 or
                    self.loberaTimeVar == 370 or
                    self.loberaTimeVar == -1)
                    then

                    if (self.attackStraight == -1) then self.attackStraight = 2; end

                    
                    self.loberaReady = true;
                    local bulletX = Game.battle.arena.x + 320;
                    local bulletY = Game.battle.arena.y;
                    local bulletR = math.rad(180);

                    if (self.swordsSpawned == 0) 
                        then
                        bulletY = bulletY + 50;
                        self.loberaList[1] = self:spawnLobera(bulletX, bulletY, bulletR, 4.0, 560, true, true);
                    elseif (self.swordsSpawned == 1) 
                        then
                        bulletY = bulletY + 15;
                        self.loberaList[2] = self:spawnLobera(bulletX, bulletY, bulletR, 3.8, 560, true);
                    elseif (self.swordsSpawned == 2) 
                        then
                        bulletY = bulletY - 15;
                        self.loberaList[3] = self:spawnLobera(bulletX, bulletY, bulletR, 3.6, 560, true);
                    elseif (self.swordsSpawned == 3) 
                        then
                        bulletY = bulletY - 50;
                        self.loberaList[4] = self:spawnLobera(bulletX, bulletY, bulletR, 3.4, 560, true);

                    elseif (self.swordsSpawned == 4) 
                        then
                        bulletY = bulletY + 140;
                        self.loberaList[2] = self:spawnLobera(bulletX, bulletY, bulletR + math.rad(15), 4.0, 560, true, true);
                    elseif (self.swordsSpawned == 5) 
                        then
                        bulletY = bulletY + 120;
                        self.loberaList[3] = self:spawnLobera(bulletX, bulletY, bulletR + math.rad(15), 4.0, 560, true);
                    elseif (self.swordsSpawned == 6) 
                        then
                        bulletY = bulletY + 100;
                        self.loberaList[1] = self:spawnLobera(bulletX, bulletY, bulletR + math.rad(15), 3.8, 560, true);
                    elseif (self.swordsSpawned == 7) 
                        then
                        bulletY = bulletY - 100;
                        self.loberaList[6] = self:spawnLobera(bulletX, bulletY, bulletR + math.rad(-15), 3.6, 560, true);
                    elseif (self.swordsSpawned == 8) 
                        then
                        bulletY = bulletY - 120;
                        self.loberaList[4] = self:spawnLobera(bulletX, bulletY, bulletR + math.rad(-15), 3.4, 560, true);
                    elseif (self.swordsSpawned == 9) 
                        then
                        bulletY = bulletY - 140;
                        self.loberaList[5] = self:spawnLobera(bulletX, bulletY, bulletR + math.rad(-15), 3.4, 560, true);
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

function lobera_b:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    -- wave lobera below
    
    -- wave lobera above

    super.update(self)
    

end

return lobera_b
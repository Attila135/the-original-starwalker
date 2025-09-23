local lobera_2, super = Class(Wave)
local angleChange = 1
local loberaTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0

-- function lobera_2:onDamage(soul)
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

function lobera_2:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function lobera_2:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 8.6
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
    self.brokenMax = 666;
    self.brokenAmount = 0;
    self.swordAmount = self.brokenMax;
    self.attackStraight = 0;
    self.shouldAttack = 0;
    self.waitBit = 0;
    -- wave lobera above

    -- attacker2:StartSwirl()
    end
    
end
function lobera_2:spawnLobera(attacker2, direction)
    self.swordSpawnY = math.sin(math.rad(self.swordsSpawned * 10 * direction) + 1 * direction) * 68;
    self.swordSpawnX = math.sin(self.swordsSpawned / 1.14 + self.randomPawNum) * 5 - 60;
    local bulletX = attacker2.x + self.swordSpawnX;
    local bulletY = attacker2.y - 5 + self.swordSpawnY;
    local attackDirection = Utils.angle(bulletX, bulletY, Game.battle.soul.x, Game.battle.soul.y);
    if (self.attackStraight == 0) then self.attackStraight = self.attackStraight - 1; end
    if (self.attackStraight > 0)
        then
        self.attackStraight = self.attackStraight - 1;
        attackDirection = 180 * 0.017453;
        end
    
    local lifePillar = self:spawnBullet("lifepillar", bulletX + 6, bulletY, 0)
    
    local loberaSword = self:spawnBullet("lobera", bulletX, bulletY, attackDirection, 8, 360);
    lifePillar.originSword = loberaSword;
    loberaSword.childPillar = lifePillar;
    
    self.swordsSpawned = self.swordsSpawned + 1;
    self.swordAmount = self.swordAmount - 1;
    
    
    loberaSword.originWave = self;
    local loberaConnector = self:spawnBullet("connector", bulletX, bulletY, 0)
    loberaConnector.originSword = loberaSword;
    loberaSword.childConnector = loberaConnector;
end
function lobera_2:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    -- wave lobera below
    self.loberaTimeVar = self.loberaTimeVar + 1;
    if (self.loberaTimeVar % 30 == 0)
        then
        -- self:spawnBullet("bouquet_spinner", Game.battle.arena.x, Game.battle.arena.y, 0, 0.075 * Utils.randomSign(), 150, 0);
        -- self:spawnBullet("bouquet_spinner", Game.battle.arena.x, Game.battle.arena.y, math.rad(180), 0.075 * Utils.randomSign(), 150, 0);
        end
    if (self.shouldAttack > 0) then self.shouldAttack = self.shouldAttack - 1; end
    if (self.waitBit > 0) then self.waitBit = self.waitBit - 1; end
    if (self.loberaTimeVar % 10 == 0)
        then
        self.shouldAttack = 1;
        end
    if ((self.loberaTimeVar) % 60 == 0)
        then
        self.waitBit = 20;
        end
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        if (attacker2.id == "maskaught")
            then
            --if (self.loberaTimeVar >= 130) then self.loberaTimeVar = 0; end
            if (self.swordAmount > 0)
                then
                if (self.loberaTimeVar % 5 == 0 and self.waitBit <= 0)
                    then

                    if (self.attackStraight == -1) then self.attackStraight = 2; end
                    --if (self.loberaTimeVar == 60) then self.loberaTimeVar = 0; end
                    Assets.playSound("darksummon")
                    self.loberaReady = true;
                    self:spawnLobera(attacker2, 1);
                    self:spawnLobera(attacker2, -1);

                    
                    -- attacker2:setAnimation("raise");
                    end
                if (attacker2.sprite.anim == "raise" and attacker2.sprite.frame == 1)
                    then
                
                    end
                end

            end
        end
    -- wave lobera above
     if (self.shouldAttack > 0 and self.loberaReady == true)
        then
        Assets.playSound("darkstrike")
        self.loberaReady = false;
        
        end
    super.update(self)
    

end

return lobera_2
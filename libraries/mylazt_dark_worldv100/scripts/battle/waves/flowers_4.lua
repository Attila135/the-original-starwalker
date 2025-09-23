local flowers_4, super = Class(Wave)
local angleChange = 1
local timeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function flowers_4:onDamage(soul)
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

function flowers_4:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function flowers_4:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 16.0;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.randomPawNum = love.math.random(0, 360)
    self.attackAmount = 7
    self.timeVar = 0;
    self.angleChange = love.math.random(10, 50);
    self.angleSign = 1;
    self.swingDirection = 1;
    --self.spinSpeeder = 0
    self.spinSpeeder = Utils.pick({13, 12, -13, -12})
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    self.initialX = attacker2.x
    self.initialY = attacker2.y
    -- attacker2:StartSwirl()
    end
    
    
    self.shootVar = 0;
    self.chainTime = 0;
    self.chainAngle = 0;

    self.specialSpawnCount = 0;


    --maybe--self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.timeVar = self.timeVar + 1;
    if (self.timeVar < 305 and self.timeVar > 100)
    then
        self.shootVar = self.shootVar + 1;
        if (self.shootVar == 5 or 
            self.shootVar == 15 or 
            self.shootVar == 25 or
            self.shootVar == 35 or 
            self.shootVar == 45
        )
            then
            self:spawnBullet("bouquet_regular", Game.battle.arena.x, Game.battle.arena.y, 0, 0.075 * self.angleSign, 150, 10 + self.angleChange); -- love.math.random(10, 30)
            end
            -- if (self.shootVar % 10 == 0 and self.shootVar >= 60) then self:spawnLobera(); end
        if (self.shootVar == 80) then self.shootVar = 0; self.angleSign = Utils.randomSign(); self.angleChange = love.math.random(10, 50); end
    end
    -- Kristal.Console:log(self.timeVar)
    if (self.timeVar == 5 or
        self.timeVar == 200
    )
            then
            self:spawnLoberaChain(1);
            end
    if (self.timeVar == 350)
        then
        self:spawnLoberaChain(2);
        end
    
-- FIXER END BELOW
    end)
-- FIXER MULT END
end
function flowers_4:spawnLobera()
local swingColor = Utils.pick({"cyan", "orange"});
self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, 0, 0.015 * self.swingDirection, 200, 10, swingColor );
self.swingDirection = self.swingDirection * -1;
end

function flowers_4:spawnLoberaChain(chainType)
local chainDirection = 1; -- Utils.randomSign();
self.chainTime = 0;
self.chainAngle = 0;
if (chainType == 1)
    then
    local swingColor = Utils.pick({
            {"cyan", "cyan", "orange", "orange", "cyan", "cyan"},
            {"orange", "orange", "cyan", "cyan", "orange", "orange"},
            {"orange", "cyan", "orange", "orange", "cyan", "orange"},
            });
    for i = 0,5,1 
        do 
        --local swingColor = Utils.pick({"cyan", "orange"});
        self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, math.rad(self.chainAngle), 0.0, 230, 30 + self.chainTime, swingColor[i + 1] );
        self.chainTime = self.chainTime + 10;
        self.chainAngle = self.chainAngle + 5 * chainDirection;
        end
    end
if (chainType == 2)
    then
    local ravenSpeed = 16;
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -20, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    --nvm--self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -60, 50, 0, math.rad(180), ravenSpeed, 1.5, false);
    for i = 0,5,1 
        do 
        local swingColor = {"orange", "orange", "orange", "cyan", "orange", "cyan"};
        self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, math.rad(self.chainAngle), 0.0, 230, 30 + self.chainTime, swingColor[i + 1]);
        self.chainTime = self.chainTime + 10;
        self.chainAngle = self.chainAngle + 5 * chainDirection;
        end
    end
end

function flowers_4:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)


    super.update(self)
end

return flowers_4
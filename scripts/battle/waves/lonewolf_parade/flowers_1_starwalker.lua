local flowers_1, super = Class(Wave)
local angleChange = 1
local timeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function flowers_1:onDamage(soul)
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

function flowers_1:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function flowers_1:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 13.3;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.randomPawNum = love.math.random(0, 360)
    self.attackAmount = 7
    self.timeVar = 0;
    self.angleChange = 0;
    --self.spinSpeeder = 0
    self.spinSpeeder = Utils.pick({13, 12, -13, -12})
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    self.initialX = attacker2.x
    self.initialY = attacker2.y
    -- attacker2:StartSwirl()
    self.flowerAngle = love.math.random(0, 10);
    self.flowerChange = 5;
    self.flowerCount = 1;
    end
    self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.timeVar = self.timeVar + 1
    if (self.timeVar == 5 or 
        self.timeVar == 20 or 
        self.timeVar == 35 or 
        self.timeVar == 60 or 
        self.timeVar == 65 or 
        self.timeVar == 70 or 
        self.timeVar == 120 or 
        self.timeVar == 130 or
        self.timeVar == 170 or 
        self.timeVar == 180 or 
        self.timeVar == 190 or 
        self.timeVar == 220 or
        self.timeVar == 260 or 
        self.timeVar == 300 or
        self.timeVar == 320
    )
        then
        if (self.flowerAngle < 0) then self.flowerChange = 10; end
        local flowerType = "bouquet_regular";
        if (self.flowerCount % 3 == 0) then flowerType = "bouquet_aimline"; end
        self:spawnBullet(flowerType, Game.battle.arena.x, Game.battle.arena.y, 0, 0.075 * Utils.randomSign(), 150, self.flowerAngle); --love.math.random(10, 30)
        self.flowerAngle = self.flowerAngle + self.flowerChange;
        if (self.flowerAngle > 50) then self.flowerChange = -15; end
        self.flowerCount = self.flowerCount + 1;
        
        end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function flowers_1:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    
    super.update(self)
end

return flowers_1
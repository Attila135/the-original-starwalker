local flowers_break, super = Class(Wave)
local angleChange = 1
local timeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function flowers_break:onDamage(soul)
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

function flowers_break:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function flowers_break:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 9.3;
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
    self.shootVar = 0;
    self.chainTime = 0;
    self.chainAngle = 0;
    self.flowerAmount = 0;
    end
    --maybe--self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
self.timeVar = self.timeVar + 1;
    if (self.timeVar % 10 == 0 and self.timeVar <= 150)
    then
        self:spawnBullet("bouquet_fail", Game.battle.arena.x, Game.battle.arena.y, 0, 0.045 * self.angleSign, 150, 200 - self.flowerAmount * 2); -- love.math.random(10, 30)
        self.flowerAmount = self.flowerAmount + 1;
    end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end




function flowers_break:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    
    -- Kristal.Console:log(self.timeVar)
  
    super.update(self)
end

return flowers_break
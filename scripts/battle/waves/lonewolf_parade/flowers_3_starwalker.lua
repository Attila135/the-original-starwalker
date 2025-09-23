local flowers_3, super = Class(Wave)
local angleChange = 1
local timeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function flowers_3:onDamage(soul)
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

function flowers_3:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function flowers_3:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 12.3;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.randomPawNum = love.math.random(0, 360)
    self.attackAmount = 7
    self.timeVar = 0;
    self.angleChange = 0;
    self.swingDirection = 1;
    --self.spinSpeeder = 0
    self.spinSpeeder = Utils.pick({13, 12, -13, -12})
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    self.initialX = attacker2.x
    self.initialY = attacker2.y
    -- attacker2:StartSwirl()
    end
    
end

function flowers_3:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    self.timeVar = self.timeVar + 1
    if (self.timeVar == 5 or 
        self.timeVar == 60 or 
        self.timeVar == 120 or 
        --self.timeVar == 130 or
        self.timeVar == 180
    )
        then
        self:spawnBullet("bouquet_spinner", Game.battle.arena.x, Game.battle.arena.y, 0, 0.075 * Utils.randomSign(), 150, love.math.random(10, 30));
        end

    if (self.timeVar == 10 or 
        self.timeVar == 30 or 

        self.timeVar == 55 or 
        self.timeVar == 70 or 

        self.timeVar == 120 or 
        self.timeVar == 130 or
        self.timeVar == 140 or

        self.timeVar == 190 or 
        self.timeVar == 200 or 
        self.timeVar == 210 or 

        self.timeVar == 270 or 
        self.timeVar == 280 or
        self.timeVar == 290 or
        self.timeVar == 300
    )
        then
        local swingColor = Utils.pick({"cyan", "orange"});
        if (self.timeVar == 10) then swingColor = "cyan" end;
        if (self.timeVar == 30) then swingColor = "orange" end;

        if (self.timeVar == 55) then swingColor = "cyan" end;
        if (self.timeVar == 70) then swingColor = "orange" end;

        if (self.timeVar == 120) then swingColor = "orange" end;
        if (self.timeVar == 130) then swingColor = "cyan" end;
        if (self.timeVar == 140) then swingColor = "orange" end;

        if (self.timeVar == 190) then swingColor = "cyan" end;
        if (self.timeVar == 200) then swingColor = "orange" end;
        if (self.timeVar == 210) then swingColor = "cyan" end;

        if (self.timeVar == 270) then swingColor = "orange" end;
        if (self.timeVar == 280) then swingColor = "cyan" end;
        if (self.timeVar == 290) then swingColor = "orange" end;
        if (self.timeVar == 300) then swingColor = "cyan" end;

        self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, 0, 0.015 * self.swingDirection, 200, 20, swingColor );
        self.swingDirection = self.swingDirection * -1;
        end
    super.update(self)
end

return flowers_3
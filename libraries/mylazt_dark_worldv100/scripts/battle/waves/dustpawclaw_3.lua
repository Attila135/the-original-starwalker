local dustpawclaw_3, super = Class(Wave)
local angleChange = 1
local timeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function dustpawclaw_3:onDamage(soul)
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

function dustpawclaw_3:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function dustpawclaw_3:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 8.9
    Assets.playSound("wolf_bthan");
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.randomPawNum = love.math.random(0, 360)
    self.attackAmount = 8
    self.timeVar = 0
    self.angleChange = 0;
    self.angleAdd = math.rad(Utils.pick({-25, 25}));
    --self.spinSpeeder = 0
    self.spinSpeeder = 13 * Utils.sign(self.angleAdd);
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    self.initialX = attacker2.x
    self.initialY = attacker2.y
    -- attacker2:StartSwirl()
    end
    
    self.initPawclaws = false;

    self.willDark = true;
    self.timer:every(1/30, function()
-- FIXER MULT BEGIN
        --Kristal.Console:log("test");
        self.timeVar = self.timeVar + 1
    
    if (self.timeVar == 30 or self.timeVar == 48 or self.timeVar == 70 or self.timeVar == 88 or self.timeVar == 112 or self.timeVar == 130 or self.timeVar == 158 or self.timeVar == 180 or self.timeVar == 198 or self.timeVar == 210) 
    then 
    self.attackAmount = 12
    if (self.timeVar == 48 or self.timeVar == 88 or self.timeVar == 130 or self.timeVar == 158 or self.timeVar == 210) then self.attackAmount = 15; self.willDark = false; end
    --self.spinSpeeder = Utils.pick({13, 12, -13, -12})
    -- Kristal.Console:log(tostring(self.spinSpeeder))
    --self.randomPawNum = self.randomPawNum + love.math.random(3.14/2, 3.14) * Utils.pick({-1, 1})
    -- self.randomPawNum = 1
    -- self.randomPawX = self.randomPawNum * 160
    -- self.randomPawY = Game.battle.soul.y
    -- self:spawnBullet("dustpawclaw", Game.battle.arena.x + self.randomPawX, self.randomPawY, Utils.angle(Game.battle.arena.x + self.randomPawX, self.randomPawY, Game.battle.soul.x, Game.battle.soul.y), 1.2, Game.battle.soul.x, Game.battle.soul.y)
    -- 
    -- self.randomPawNum = -1
    -- self.randomPawX = self.randomPawNum * 160
    -- self.randomPawY = Game.battle.soul.y
    -- self:spawnBullet("dustpawclaw", Game.battle.arena.x + self.randomPawX, self.randomPawY, Utils.angle(Game.battle.arena.x + self.randomPawX, self.randomPawY, Game.battle.soul.x, Game.battle.soul.y), 1.2, Game.battle.soul.x, Game.battle.soul.y)

    end
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers) do
    -- attacker.x = Utils.ease(self.initialX, self.initialX + self.randomX, self.timeVar / 40, "in-out-quad")
    -- attacker.y = Utils.ease(self.initialY, self.initialY + self.randomY, self.timeVar / 40, "in-out-quad")
    if (self.initPawclaws == false)
        then -- when reached destination
        self.initPawclaws = true;
        -- attacker:EndSwirl()
        self.timer:every(0.1, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()
        --self.angleChange = self.angleChange + math.rad(10);
        -- Loop through all attackers
        for i = 0, 20,1 
            do 
            for _, attacker in ipairs(attackers) do

                -- Get the attacker's center position
                --if self.angleChange >= 0.50
                --then
                --self.angleChange = self.angleChange -1
                --end
                if (self.attackAmount > 0)
                    then
                    self.angleChange = self.angleChange + self.angleAdd;
                    self.attackAmount = self.attackAmount - 1
                    local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

                    -- Get the angle between the bullet position and the soul's position
                    -- local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
                

                    local shouldDark = true;
                    if (self.attackAmount <= 5) then self.willDark = true; end
                    --self.randomPawNum = self.randomPawNum + 0.4
                    --self.randomPawX = math.cos(self.randomPawNum) * 160
                    --self.randomPawY = math.sin(self.randomPawNum) * 160
                    self:spawnBullet("dustpawclaw", Game.battle.arena.x + math.cos(self.angleChange) * 160, Game.battle.arena.y + math.sin(self.angleChange) * 160, self.angleChange, 1.2, Game.battle.arena.x, Game.battle.arena.y, self.spinSpeeder, self.willDark)

                    --self.randomPawNum = self.randomPawNum + 0.4
                    --nvm--self.angleChange = self.angleChange + math.rad(40);
                    --nvm----self.randomPawX = math.cos(self.randomPawNum) * 160
                    --nvm----self.randomPawY = math.sin(self.randomPawNum) * 160
                    --nvm--self:spawnBullet("dustpawclaw", Game.battle.arena.x + math.cos(self.angleChange) * 160, Game.battle.arena.y + math.sin(self.angleChange) * 160, self.angleChange, 1.2, Game.battle.arena.x, Game.battle.arena.y, self.spinSpeeder, shouldDark)
                

                    -- self:spawnBullet("pawclaw", Game.battle.arena.x + self.randomPawX, Game.battle.arena.y + self.randomPawY, Utils.angle(Game.battle.arena.x + self.randomPawX, Game.battle.arena.y + self.randomPawY, Game.battle.soul.x, Game.battle.soul.y), 1.2, Game.battle.soul.x, Game.battle.soul.y)

                    -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                    -- self:spawnBullet("dustclaw", x, y, 0, 8, Game.battle.soul.x, Game.battle.soul.y)
                    -- self:spawnBullet("pawclaw", x, y + 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 2, Game.battle.soul.x, Game.battle.soul.y + 50)
                    -- self:spawnBullet("pawclaw", x, y, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 2, Game.battle.soul.x, Game.battle.soul.y)
                    -- self:spawnBullet("pawclaw", x, y - 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 2, Game.battle.soul.x, Game.battle.soul.y - 50)
                    -- self:spawnBullet("smallbullet", x, y, 2, 8)
                    -- self:spawnBullet("smallbullet", x, y, 3, 8)
                    end
            end
        end
        self.willDark = true;
    end)
        end
    end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function dustpawclaw_3:update()
    super.update(self)
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    



end

return dustpawclaw_3
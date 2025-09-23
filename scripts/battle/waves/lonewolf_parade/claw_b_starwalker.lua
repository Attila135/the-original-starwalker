local claw_b, super = Class(Wave)
local angleChange = 1
local clawTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function claw_b:onDamage(soul)
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

function claw_b:ClawMoveTo(posX, posY)
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

function claw_b:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function claw_b:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 10.6;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.attackAmount = 3
    self.clawTimeVar = -5
    self.angleChange = 0
    self.moveVar = 0;
    -- local attackers2 = self:getAttackers()
    -- for _, attacker2 in ipairs(attackers2)
    --     do
    --     self.initialX = attacker2.x
    --     self.initialY = attacker2.y
    --     self.desX = attacker2.x + 60;-- + love.math.random(0, 50)
    --     self.desY = attacker2.y;
    --     if (attacker2.onAir == false) then attacker2:StartSwirl(6) end
    --     if (attacker2.sprite.anim == "swirled") then self.time = 8.6; end
    --     end
    self.throwMoveLevel = 20;
    self.oppositeY = 1;
    self.swingDirection = 1;
    self.timeVar = 0;
    self.swingAmount = 0;
    --maybe--self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
self.timeVar = self.timeVar + 1;
    if (self.timeVar % 20 == 0 and ((self.timeVar < 250 and self.time > 10) or (self.timeVar < 190 and self.time <= 10)) )
    then
        local loberaColor = Utils.pick({"cyan", "orange"});
        if (self.swingAmount % 2 == 0) then loberaColor = "orange"; else loberaColor = "cyan"; end
        self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, 0, 0.020 * self.swingDirection, 200, 20, loberaColor );
        self.swingDirection = self.swingDirection * -1;
        self.swingAmount = self.swingAmount + 1;
    end
    self.clawTimeVar = self.clawTimeVar + 1
    self.moveVar = self.moveVar + 1;
    if (self.timeVar == -110)
        then
        local ravenSpeed = 16;
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -20, 50, 0, math.rad(180), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -60, 50, 0, math.rad(180), ravenSpeed, 1, false);
        end
    if (self.timeVar == -180)
        then
        local ravenSpeed = 16;
        self:spawnBullet("raven", Game.battle.arena.x - 20, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 40, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 60, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 0, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 20, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 40, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x + 60, Game.battle.arena.y - 100, 0, -50, math.rad(90), ravenSpeed, 1, false);

        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 60, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 40, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 20, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 0, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + -20, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + -40, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + -60, -50, 0, math.rad(0), ravenSpeed, 1, false);
        end
    if (self.timeVar == -220)
        then
        local ravenSpeed = 16;
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 60, -50, 0, math.rad(0), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 40, -50, 0, math.rad(0), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 20, -50, 0, math.rad(0), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + 0, -50, 0, math.rad(0), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + -20, -50, 0, math.rad(0), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + -40, -50, 0, math.rad(0), ravenSpeed, 1, false);
        self:spawnBullet("raven", Game.battle.arena.x - 120, Game.battle.arena.y + -60, -50, 0, math.rad(0), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -20, 50, 0, math.rad(180), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -40, 50, 0, math.rad(180), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + -60, 50, 0, math.rad(180), ravenSpeed, 1, false);
        --self:spawnBullet("raven", Game.battle.arena.x + 120, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, 1, false);
        end
    if (self.timeVar < 110 or 1 == 1)
        then
            local attackers = self:getAttackers()
            for _, attacker in ipairs(attackers)
            do

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
                    local spawnBullet1 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
                    spawnBullet1.originMaskaught = attacker; changeY = changeY + changeAmount;
            
            

                    -- local spawnBullet3 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
                    -- spawnBullet3.originMaskaught = attacker; changeY = changeY + changeAmount;
                    -- 
                    -- local spawnBullet4 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
                    -- spawnBullet4.originMaskaught = attacker; changeY = changeY + changeAmount;
                    -- 
                    -- local spawnBullet5 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
                    -- spawnBullet5.originMaskaught = attacker;

                    local spawnBullet2 = self:spawnBullet("dustclaw", targetX, 500, Utils.angle(targetX, 500, targetX, Game.battle.soul.y), 4, targetX, Game.battle.soul.y)
                    spawnBullet2.originMaskaught = attacker;
                    self.oppositeY = self.oppositeY * -1;
                    end
            if (1 == 1) 
                then -- when reached destination
        
                -- if (attacker.swirlLifetime > 0) then attacker:EndSwirl() end
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
                    self.clawTimeVar == 60
                    ))
                    then

                    local otherX = 50;
                    y = y + love.math.random(-20, 20);
            
                    if (self.clawTimeVar == 20)
                        then 
                        self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y - 40)
                        self:spawnBullet("dustclaw", x, y + 25, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 25), 5, Game.battle.soul.x, Game.battle.soul.y + 25)
                        self:spawnBullet("dustclaw", x, y + 75, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 75), 5, Game.battle.soul.x, Game.battle.soul.y + 75)

                        -- self:spawnBullet("dustclaw", otherX, otherY + 25, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y + 25), 5, Game.battle.soul.x, Game.battle.soul.y + 25)
                        -- self:spawnBullet("dustclaw", otherX, otherY + 75, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y + 75), 5, Game.battle.soul.x, Game.battle.soul.y + 75)
                        end
                        if (self.clawTimeVar == 40)
                        then
                        self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.soul.y)
                        self:spawnBullet("dustclaw", x, y - 25, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 25), 5, Game.battle.soul.x, Game.battle.soul.y - 25)
                        self:spawnBullet("dustclaw", x, y - 75, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 75), 5, Game.battle.soul.x, Game.battle.soul.y - 75)
                
                        -- self:spawnBullet("dustclaw", otherX, otherY - 25, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y - 25), 5, Game.battle.soul.x, Game.battle.soul.y - 25)
                        -- self:spawnBullet("dustclaw", otherX, otherY - 75, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y - 75), 5, Game.battle.soul.x, Game.battle.soul.y - 75)
                        end
                        if (self.clawTimeVar == -60)
                        then
                        self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y + 40)
                        end
            
            
                    local spawnBullet1 = self:spawnBullet("dustclaw", x, y + 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 50), 4, Game.battle.soul.x, Game.battle.soul.y + 50)
                    self:spawnBullet("dustclaw", x, y, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 4, Game.battle.soul.x, Game.battle.soul.y)
                    self:spawnBullet("dustclaw", x, y - 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 50), 4, Game.battle.soul.x, Game.battle.soul.y - 50)
                    spawnBullet1.originMaskaught = attacker;

                    -- self:spawnBullet("dustclaw", otherX, otherY + 50, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y + 50), 4, Game.battle.soul.x, Game.battle.soul.y + 50)
                    -- self:spawnBullet("dustclaw", otherX, otherY, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y), 4, Game.battle.soul.x, Game.battle.soul.y)
                    -- self:spawnBullet("dustclaw", otherX, otherY - 50, Utils.angle(otherX, otherY, Game.battle.soul.x, Game.battle.soul.y - 50), 4, Game.battle.soul.x, Game.battle.soul.y - 50)
            
                    end
                end
            end
            -- claw attack above
        end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function claw_b:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    super.update(self)
    -- claw attack below
    

end

return claw_b
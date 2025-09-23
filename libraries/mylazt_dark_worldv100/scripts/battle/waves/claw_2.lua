local claw_2, super = Class(Wave)
local angleChange = 1
local clawTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function claw_2:onDamage(soul)
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

function claw_2:ClawMoveTo(posX, posY)
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

function claw_2:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function claw_2:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 10.6;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.attackAmount = 3
    self.clawTimeVar = -5
    self.angleChange = 0
    self.moveVar = 0;
    self.swingDirection = 1;
    self.timeVar = 0;
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        self.initialX = attacker2.x
        self.initialY = attacker2.y
        self.desX = attacker2.x + 60;-- + love.math.random(0, 50)
        self.desY = attacker2.y;
        if (attacker2.onAir == false) then attacker2:StartSwirl(6) end
        if (attacker2.sprite.anim == "swirled") then self.time = 8.6; end
        end
    self.throwMoveLevel = 20;
    self.oppositeY = 1;
end

function claw_2:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)

    self.timeVar = self.timeVar + 1;

    --if (self.timeVar == 10 or 
    --    self.timeVar == 10 or 
    --    self.timeVar == 30 or 
    --    self.timeVar == 30 or 
    --    self.timeVar == 55 or 
    --    self.timeVar == 70 or 
    --    self.timeVar == 120 or 
    --    self.timeVar == 140 or
    --    self.timeVar == 160 or
    --    self.timeVar == 190 or 
    --    self.timeVar == 210 or
    --    self.timeVar == 220 or
    --    self.timeVar == 230
    --)
    --    then
    --    local swingColor = Utils.pick({"cyan", "orange"});
    --    if (self.timeVar == 10) then swingColor = "cyan" end;
    --    if (self.timeVar == 30) then swingColor = "orange" end;
    --    if (self.timeVar == 55) then swingColor = "cyan" end;
    --    if (self.timeVar == 70) then swingColor = "orange" end;
    --
    --    if (self.timeVar == 120) then swingColor = "orange" end;
    --    if (self.timeVar == 140) then swingColor = "cyan" end;
    --    if (self.timeVar == 160) then swingColor = "orange" end;
    --
    --    if (self.timeVar == 190) then swingColor = "cyan" end;
    --    if (self.timeVar == 210) then swingColor = "orange" end;
    --    if (self.timeVar == 220) then swingColor = "cyan" end;
    --
    --    if (self.timeVar == 230) then swingColor = "cyan" end;
    --
    --    self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, 0, 0.015 * self.swingDirection, 200, 35, swingColor );
    --    self.swingDirection = self.swingDirection * -1;
    --    end
    -- Kristal.Console:log(self.timeVar);
    if (self.timeVar % 40 == 0 and ((self.timeVar < 250 and self.time > 10) or (self.timeVar < 190 and self.time <= 10)) )
    then
        self:spawnBullet("bouquet_lobera", Game.battle.arena.x, Game.battle.arena.y, 0, 0.020 * self.swingDirection, 200, 20, Utils.pick({"cyan", "orange"}) );
        self.swingDirection = self.swingDirection * -1;
    end

    -- claw attack below
    self.clawTimeVar = self.clawTimeVar + 1
    

    self.moveVar = self.moveVar + 1;
    super.update(self)
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers)
    do

    attacker.x = Utils.ease(self.initialX, self.desX, self.moveVar / self.throwMoveLevel, "in-out-quad")
    attacker.y = Utils.ease(self.initialY, self.desY, self.moveVar / self.throwMoveLevel, "in-out-quad")
    local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
    if (self.clawTimeVar > 60) then self.clawTimeVar = 0; end
    if (attacker.scale_x == 2 and
            (
            self.clawTimeVar == 20 or
            self.clawTimeVar == 40 or
            self.clawTimeVar == 60
            ))
            then
            local changeAmount = 40 * self.oppositeY;
            local changeY = changeAmount;
            local targetX = Game.battle.soul.x;
                -- local spawnBullet1 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
                -- spawnBullet1.originMaskaught = attacker; changeY = changeY + changeAmount;
                -- local spawnBullet2 = self:spawnBullet("dustclaw", targetX, 500, Utils.angle(targetX, 500, targetX, Game.battle.soul.y), 4, targetX, Game.battle.soul.y)
                -- spawnBullet2.originMaskaught = attacker;
            

            -- local spawnBullet3 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            -- spawnBullet3.originMaskaught = attacker; changeY = changeY + changeAmount;
            -- 
            -- local spawnBullet4 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            -- spawnBullet4.originMaskaught = attacker; changeY = changeY + changeAmount;
            -- 
            -- local spawnBullet5 = self:spawnBullet("dustclaw", targetX - changeY, -100, Utils.angle(targetX - changeY, -100, targetX - changeY, Game.battle.soul.y), 4, targetX - changeY, Game.battle.soul.y)
            -- spawnBullet5.originMaskaught = attacker;

            
            self.oppositeY = self.oppositeY * -1;
            end
    if (Utils.dist(attacker.x, attacker.y, self.desX, self.desY) < 10) 
        then -- when reached destination
        
        if (attacker.swirlLifetime > 0) then attacker:EndSwirl() end
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

            
            if (self.clawTimeVar == 20)
                then 
                self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y - 40)
                self:spawnBullet("dustclaw", x, y + 25, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 25), 5, Game.battle.soul.x, Game.battle.soul.y + 25)
                self:spawnBullet("dustclaw", x, y + 75, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 75), 5, Game.battle.soul.x, Game.battle.soul.y + 75)
                end
                if (self.clawTimeVar == 40)
                then
                self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.soul.y)
                self:spawnBullet("dustclaw", x, y - 25, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 25), 5, Game.battle.soul.x, Game.battle.soul.y - 25)
                self:spawnBullet("dustclaw", x, y - 75, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 75), 5, Game.battle.soul.x, Game.battle.soul.y - 75)
                end
                if (self.clawTimeVar == -60)
                then
                self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y + 40)
                end
            
            
            local spawnBullet1 = self:spawnBullet("dustclaw", x, y + 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 50), 4, Game.battle.soul.x, Game.battle.soul.y + 50)
            local spawnBullet2 = self:spawnBullet("dustclaw", x, y, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 4, Game.battle.soul.x, Game.battle.soul.y)
            local spawnBullet3 = self:spawnBullet("dustclaw", x, y - 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 50), 4, Game.battle.soul.x, Game.battle.soul.y - 50)
            spawnBullet1.originMaskaught = attacker;
            spawnBullet2.originMaskaught = attacker;
            spawnBullet3.originMaskaught = attacker;
            end
        end
    end
    -- claw attack above

end

return claw_2
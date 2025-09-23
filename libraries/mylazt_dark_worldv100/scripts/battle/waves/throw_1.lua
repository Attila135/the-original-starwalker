local throw_1, super = Class(Wave)
local angleChange = 1
local throwTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function throw_1:onDamage(soul)
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

function throw_1:ThrowMoveTo(posX, posY)
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

function throw_1:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function throw_1:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 12.0;
    
    self.desX = 0;
    self.desY = 0;
    self.attackAmount = 3
    self.throwTimeVar = 0
    self.moveVar = 0;
    self.angleChange = 0
    self.throwMoveLevel = 40;
    self.hookX = 0;
    self.hookY = 0;
    self.gotPosition = false;
    self.differentY = love.math.random(-166, 166);
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        self.initialX = attacker2.x
        self.initialY = attacker2.y
        self.desX = attacker2.x + 60;-- + love.math.random(0, 50)
        self.desY = attacker2.y;
        if (attacker2.onAir == false) then attacker2:StartSwirl(0.77) end;
        end
    
end

function throw_1:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    self.throwTimeVar = self.throwTimeVar + 1 * DTMULT;
   
    
    local attackers = self:getAttackers()
    for _, attacker in ipairs(attackers)
    do
        

        
            
        if (1 == 1)
            then
            -- self.throwMoveLevel = 100;
            -- self:ThrowMoveTo(attacker.x, Game.battle.arena.y + (100 * Utils.sign(Game.battle.arena.y - attacker.y)));
            end
        if (self.gotPosition == false)
            then
            self.moveVar = self.moveVar + 1 * DTMULT;
            attacker.x = Utils.ease(self.initialX, self.desX, self.moveVar / self.throwMoveLevel, "in-out-quad")
            attacker.y = Utils.ease(self.initialY, self.desY, self.moveVar / self.throwMoveLevel, "in-out-quad")
            else
            -- if (attacker.y ~= 0 and Game.battle.soul.y ~= 0 and math.abs(Game.battle.soul.y - attacker.y) > 15) then attacker.y = attacker.y + (Utils.sign(Game.battle.soul.y - attacker.y) * ((Game.battle.soul.y / attacker.y) * 1)); end
            
            -- attacker.y = self.initialY + math.sin(self.moveVar / 60) * 120;
            end
        if (attacker.swirlLifetime > 0 and self.throwTimeVar == 5) 
            then -- when reached destination
            -- self.initialX = attacker.x;
            -- self.initialY = attacker.y;
            -- self.gotPosition = true;
            attacker:EndSwirl()
            end
        if (self.throwTimeVar == 3)
            then
            -- spawn pillars below
                for i = 0, 28, 1
                    do
                    local lengthX = 0;
                    local lengthY = 0;
                    local speedX = 0;
                    local speedY = 0;
                    local timeX = 1;
                    local timeY = 1;
                    lengthX = 250; lengthY = 200; speedX = 5; timeX = -20 - i; timeY = self.differentY + 160 - 10 * i;
                    local spinType = "spin"; if (i % 8 == 0 and i < 20) then spinType = "laser"; end
                    local spinPillar = self:spawnBullet("spinpillar", attacker.x - 30, attacker.y - 30, lengthX, lengthY, speedX, speedY, timeX, timeY, spinType, 30 + i * 10, 50, math.rad(i * 5 * 0));
            
                    --spinPillar.layer = 1; -- instead of -1 or 0
                    spinPillar.originMaskaught = attacker;
                
                    --nvm--local pillarConnector = self:spawnBullet("connector", -100, -100, 0)
                    --nvm--pillarConnector.originMaskaught = attacker;
                    --nvm--pillarConnector.attachedThing = spinPillar;
                    --nvm--spinPillar.childConnector = pillarConnector;
                    --nvm--pillarConnector.alpha = 0;
                    -- loberaSword.childConnector = loberaConnector;
                    end
                -- spawn pillars above
                -- spawn pillars below
                for i = 0, -1, 1
                    do
                    local lengthX = 0;
                    local lengthY = 0;
                    local speedX = 0;
                    local speedY = 0;
                    local timeX = 1;
                    local timeY = 1;
                    lengthX = 250; lengthY = 200; speedX = 6; timeX = 2 * i; timeY = 20 * i;
                    local spinPillar = self:spawnBullet("spinpillar", attacker.x - 30, attacker.y - 30, lengthX, lengthY, speedX, speedY, timeX, timeY, "spin");
            
                    --spinPillar.layer = 1; -- instead of -1 or 0
                    spinPillar.originMaskaught = attacker;
                
                    --nvm--local pillarConnector = self:spawnBullet("connector", -100, -100, 0)
                    --nvm--pillarConnector.originMaskaught = attacker;
                    --nvm--pillarConnector.attachedThing = spinPillar;
                    --nvm--spinPillar.childConnector = pillarConnector;
                    --nvm--pillarConnector.alpha = 0;
                    -- loberaSword.childConnector = loberaConnector;
                    end
                -- spawn pillars above
                local spinPillar = self:spawnBullet("blockpillar", attacker.x - 10, Game.battle.arena.y);
            end
        if (self.throwTimeVar == 11) -- attacker.sprite.anim == "swirled")
            then
            Assets.playSound("darkthrow")
            
            -- self.throwMoveLevel = 50;
            attacker:shake(4);
            attacker:setAnimation("throw");
            end
    end

    super.update(self)

end

return throw_1
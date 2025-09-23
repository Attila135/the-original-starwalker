local claw_1, super = Class(Wave)
local angleChange = 1
local clawTimeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function claw_1:onDamage(soul)
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

function claw_1:ClawMoveTo(posX, posY)
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

function claw_1:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function claw_1:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 12.1;
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.attackAmount = 3
    self.clawTimeVar = -5
    self.angleChange = 0
    self.moveVar = 0;
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2)
        do
        self.initialX = attacker2.x
        self.initialY = attacker2.y
        self.desX = attacker2.x + 60;-- + love.math.random(0, 50)
        self.desY = attacker2.y;
        if (attacker2.onAir == false) then attacker2:StartSwirl(6) end
        end
    self.throwMoveLevel = 20;
    self.lifetime = 0;
    self.laserMoment = 0;
    self.laserX = 0;
end

function claw_1:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    self.lifetime = self.lifetime + 1;
    if (self.laserMoment > 0)
        then
        self.laserMoment = self.laserMoment - 1;
        local separateX = 10;
        if (self.laserMoment == 14) then self:spawnBullet("laserwarning", self.laserX, Game.battle.soul.y, math.rad(90), nil); end
        if (self.laserMoment == 10) then self:spawnBullet("laserwarning", self.laserX + separateX * 1, Game.battle.soul.y, math.rad(90), nil); separateX = separateX * -1; end
        if (self.laserMoment == 10) then self:spawnBullet("laserwarning", self.laserX + separateX * 1, Game.battle.soul.y, math.rad(90), nil); separateX = separateX * -1; end
        if (self.laserMoment == 6) then self:spawnBullet("laserwarning", self.laserX + separateX * 2, Game.battle.soul.y, math.rad(90), nil); separateX = separateX * -1; end
        if (self.laserMoment == 6) then self:spawnBullet("laserwarning", self.laserX + separateX * 2, Game.battle.soul.y, math.rad(90), nil); separateX = separateX * -1; end
        if (self.laserMoment == 2) then self:spawnBullet("laserwarning", self.laserX + separateX * 3, Game.battle.soul.y, math.rad(90), nil); separateX = separateX * -1; end
        if (self.laserMoment == 2) then self:spawnBullet("laserwarning", self.laserX + separateX * 3, Game.battle.soul.y, math.rad(90), nil); separateX = separateX * -1; end
        end
    if (self.lifetime % 40 == 0)
        then
        --self.laserMoment = 20;
        self.laserX = Game.battle.soul.x;
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
    if (self.clawTimeVar > 60) then self.clawTimeVar = 0; end
    if (Utils.dist(attacker.x, attacker.y, self.desX, self.desY) < 10) 
        then -- when reached destination
        if (attacker.swirlLifetime > 0) then attacker:EndSwirl() end
        if (attacker.scale_x == 2 and
            (
            self.clawTimeVar == 20 or
            self.clawTimeVar == 40 or
            self.clawTimeVar == 60
            ))
            then
            local moveX = 0;
            local moveY = 0;
            if (self.clawTimeVar == 20) then self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y - 60) end
            if (self.clawTimeVar == 40) then self:ClawMoveTo(Game.battle.arena.x + 260, Game.battle.arena.y + 60) end
            if (self.clawTimeVar == 60) then self:ClawMoveTo(Game.battle.arena.x + 240, Game.battle.soul.y) end
            
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
            local spawnBullet1 = self:spawnBullet("dustclaw", x, y + 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y + 50), 3, Game.battle.soul.x, Game.battle.soul.y + 50)
            local spawnBullet2 = self:spawnBullet("dustclaw", x, y, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y), 3, Game.battle.soul.x, Game.battle.soul.y)
            local spawnBullet3 = self:spawnBullet("dustclaw", x, y - 50, Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y - 50), 3, Game.battle.soul.x, Game.battle.soul.y - 50)
            spawnBullet1.originMaskaught = attacker;
            spawnBullet2.originMaskaught = attacker;
            spawnBullet3.originMaskaught = attacker;
            end
        end
    end
    -- claw attack above

end

return claw_1
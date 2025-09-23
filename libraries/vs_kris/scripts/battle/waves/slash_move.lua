local Aiming, super = Class(Wave)

function Aiming:onStart()

    self.move = 2

    self.time = 10

    -- Every 0.5 seconds...
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setSprite("battle/attackready_1")
    end
    Assets.playSound("noise")
        

self.timer:script(function(wait)
    self.move = 0
    wait(0.3)
    self.move = 2
    wait(0.7)
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setAnimation("battle/attack", nil, false)

        local attackers = self:getAttackers()

    -- Loop through all attackers
    for _, attacker in ipairs(attackers) do

        -- Get the attacker's center position
        local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

        -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("slash", x, y, angle, 12)
        bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        bullet:setScale(0.5)
    end
        wait(1)
        Assets.playSound("shakerbreaker")
        enemy.sprite:setSprite("battle/attackready_1")
    end

    self.move = 1
    wait(0.5)
    self.move = 2
    wait(0.7)
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setAnimation("battle/attack", nil, false)

        local attackers = self:getAttackers()

    -- Loop through all attackers
    for _, attacker in ipairs(attackers) do

        -- Get the attacker's center position
        local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

        -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("slash", x, y, angle, 12)
        bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        bullet:setScale(0.5)
    end
        wait(1)
        Assets.playSound("shakerbreaker")
        enemy.sprite:setSprite("battle/attackready_1")
    end

    self.move = 0
    wait(0.1)

    self.move = 2
    wait(0.7)
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setAnimation("battle/attack", nil, false)

        local attackers = self:getAttackers()

    -- Loop through all attackers
    for _, attacker in ipairs(attackers) do

        -- Get the attacker's center position
        local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

        -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("slash", x, y, angle, 12)
        bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        bullet:setScale(0.5)
    end
        wait(1)
        Assets.playSound("shakerbreaker")
        enemy.sprite:setSprite("battle/attackready_1")
    end

    self.move = 0
    wait(0.3)

    self.move = 2
    wait(0.7)
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setAnimation("battle/attack", nil, false)

        local attackers = self:getAttackers()

    -- Loop through all attackers
    for _, attacker in ipairs(attackers) do

        -- Get the attacker's center position
        local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

        -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("slash", x, y, angle, 12)
        bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        bullet:setScale(0.5)
    end
        wait(1)
        Assets.playSound("shakerbreaker")
        enemy.sprite:setSprite("battle/attackready_1")
    end

    self.move = 0
    wait(0.3)

    self.move = 2
    wait(0.7)
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setAnimation("battle/attack", nil, false)

        local attackers = self:getAttackers()

    -- Loop through all attackers
    for _, attacker in ipairs(attackers) do

        -- Get the attacker's center position
        local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

        -- Get the angle between the bullet position and the soul's position
        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

        -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("slash", x, y, angle, 12)
        bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        bullet:setScale(0.5)
    end
        wait(1)
        enemy.sprite:resetSprite()
    end
end)
end

function Aiming:update()
    for k,enemy in ipairs(self:getAttackers()) do
    
    if self.move == 0 then
        enemy.y = enemy.y - 5
    elseif self.move == 1 then
        enemy.y = enemy.y + 5
    elseif self.move == 2 then
        enemy.y = enemy.y + 0
    end
    end
    -- Code here gets called every frame

    super.update(self)
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setAnimation("battle/idle", nil, true)
        enemy.y = 277
	end
end

return Aiming
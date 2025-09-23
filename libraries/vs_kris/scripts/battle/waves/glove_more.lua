local Aiming, super = Class(Wave)

function Aiming:onStart()
    self.time = 15
    
    self.aim = 0
    self.arena = Game.battle.arena

    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setSprite("battle/attackready_1")
    end
    Assets.playSound("noise")
    self.timer:every(3/1.7, function()
        self.timer:script(function(wait)
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
                Assets.playSound("noise")
                enemy.sprite:setSprite("battle/attackready_1")
            end
    end)
end)

self.timer:every(2/2, function()
    local min_x, min_y = 0, 0
    local max_x, max_y = 640, 480
    
    local spawn_x, spawn_y = math.random(min_x, max_x), math.random(min_y, max_y)
    
    local box = Game.battle.arena
    
    while (spawn_x >= box:getLeft() and spawn_x <= box:getRight()) and (spawn_y >= box:getTop() and spawn_y <= box:getBottom()) do
    spawn_x, spawn_y = math.random(min_x, max_x), math.random(min_y, max_y)
    end
    self.timer:script(function(wait)
        self.aim = 1
        self.glove = self:spawnBullet("glove", spawn_x, spawn_y)
        self.glove:setScale(0.5)
        local x, y = self.glove:getRelativePos(self.glove.width/2, self.glove.height/2)
        self.angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self.timer:after(0.5, function()
        self.glove:fadeOutAndRemove(0.5)
    end)
    
    end)
end)
end

function Aiming:update()
    super.update(self)
    if self.aim == 1 then
        local x, y = self.glove:getRelativePos(self.glove.width/2, self.glove.height/2)
        self.glove.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
    end

    for k,enemy in ipairs(self:getAttackers()) do
        if enemy.y > 213 then
            enemy.y = enemy.y - 10
        end
    end
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setAnimation("battle/idle", nil, true)
        enemy.y = 277
	end
end

return Aiming
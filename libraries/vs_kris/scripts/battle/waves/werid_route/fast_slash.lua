local Aiming, super = Class(Wave)

function Aiming:onStart()

    self.move = 2

    self.time = 15

    -- Every 0.5 seconds...
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setSprite("battle/attackready_1")
    end
    Assets.playSound("boost")
        

    self.timer:every(0.8, function()
        Assets.playSound("shakerbreaker")
    for k,enemy in ipairs(self:getAttackers()) do
        if enemy.y < 130 then
            self.move = 1
        elseif enemy.y > 330 then
            self.move = 0
        else
            self.move = math.random(0,1)
        end
        self.timer:after(math.random(0.1,0.3), function()
            self.move = 2
        end)
    end
    end)
    self.timer:every(1, function()
    
    self.timer:script(function(wait)
    
        for k,enemy in ipairs(self:getAttackers()) do
    
            self.timer:after(0.4, function()
            local attackers = self:getAttackers()
            enemy.sprite:setAnimation("battle/attack", nil, false)
        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do
    
            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
    
            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            local bullet = self:spawnBullet("red_slash_hard", x, y, angle, 37)
            bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
            bullet:setScale(0.5)
        end
        end)
        self.timer:after(1, function()
            enemy.sprite:setSprite("battle/attackready_1")
        end)
        end
    end)
    end)
end

function Aiming:update()
    for k,enemy in ipairs(self:getAttackers()) do
    
        if self.move == 0 then
            if enemy.y > 130 then
            enemy.y = enemy.y - 5
            end
        elseif self.move == 1 then
            if enemy.y < 330 then
            enemy.y = enemy.y + 5
            end
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
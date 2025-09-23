local Aiming, super = Class(Wave)

function Aiming:onStart()

    self.time = 10

    -- Every 0.5 seconds...
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
end

function Aiming:update()
    for k,enemy in ipairs(self:getAttackers()) do
        if enemy.y > 213 then
            enemy.y = enemy.y - 10
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
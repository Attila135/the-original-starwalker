local Aiming, super = Class(Wave)
local angleChange = 1

function Aiming:onStart()
    -- Every 0.5 seconds...
    self.timer:every(1/10, function()
        local attackers = self:getAttackers()
        for _, attacker in ipairs(attackers) do
        attacker.x = attacker.x - 1
        end
    end)
    self.timer:every(1/3, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do

            -- Get the attacker's center position
            angleChange = angleChange + 0.15
            if angleChange >= 0.50
            then
            angleChange = angleChange -1
            end
            
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("smallbullet", x, y, 0, 8)
            self:spawnBullet("smallbullet", x, y, 1, 8)
            self:spawnBullet("smallbullet", x, y, 2, 8)
            self:spawnBullet("smallbullet", x, y, 3, 8)
        end
    end)
end

function Aiming:update()
    -- Code here gets called every frame

    super.update(self)
end

return Aiming
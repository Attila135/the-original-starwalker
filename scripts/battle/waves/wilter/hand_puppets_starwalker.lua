local Aiming, super = Class(Wave)

function Aiming:onStart()
self.time = 8
	local toriel = self:spawnBullet("smallbullet", 120, 200, math.rad(0), 0)
	toriel.sprite:setSprite("bullets/toriel")
	toriel.sprite:setOrigin(0.5, 0.5)
	local asgore = self:spawnBullet("smallbullet", 520, 200, math.rad(0), 0)
	asgore.sprite:setSprite("bullets/asgore")
	asgore.sprite:setOrigin(0.5, 0.5)

    -- Every 0.5 seconds...
    self.timer:every(1/2, function()

            -- Get the attacker's center position
            local x, y = toriel:getRelativePos(toriel.width/2, toriel.height/2)

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            local fire = self:spawnBullet("smallbullet", x, y, angle, 8)
	    fire.sprite:setAnimation({"bullets/fire", 0.1, true})
		fire:setHitbox(2, 2, 13, 14)
		
	
	end)
    self.timer:after(2, function()
            -- Get the attacker's center position
            local x2, y2 = asgore:getRelativePos(toriel.width/2, toriel.height/2)

            -- Get the angle between the bullet position and the soul's position

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            local trident = self:spawnBullet("smallbullet", x2 + 50, y2, math.rad(180), 5)
	    trident.sprite:setSprite("bullets/trident")
		trident.sprite:setOrigin(0.5, 0.5)
		trident:setHitbox(0, 20, 230, 10)
		trident.x = x2
		trident.y = y2
	    self.timer:every(0.05 * DTMULT, function()
		trident.rotation = trident.rotation + math.rad(-5)
	
		end)
	end)
	self.double = #Game.battle.waves==2
    self.timer:every(self.double and 1.75 or 0.75, function()
        local x, y
        repeat
            x = Utils.random(30, SCREEN_WIDTH-30)
        until (x<Game.battle.arena.left or x>Game.battle.arena.right)
        repeat
            y = Utils.random(30, SCREEN_HEIGHT-30)
        until (y<Game.battle.arena.top or y>Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("secret/iceshock", x, y)
    end)
end

function Aiming:update()
    -- Code here gets called every frame

    super.update(self)
end

return Aiming
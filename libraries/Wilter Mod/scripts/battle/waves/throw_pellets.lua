local Basic, super = Class(Wave)
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 16
end

function Basic:onStart()
    local soul = Game.battle.soul

    -- Every 0.33 seconds...
    self.timer:everyInstant(3, function()
        local wilter = self:getAttackers()[1]

        Assets.stopAndPlaySound("wilt_cough")

        self.timer:after(0.5, function ()

      	    local VineSound = 0

	        local nBullets = love.math.random(4,6)
	        local nBulletsSpawned = 0
            local x, y = 450, 100
	        while nBulletsSpawned < nBullets do
                local pellet = self:spawnBullet("pellet", x, y, math.rad(180), 0)
	            pellet.spawned = 0
				pellet.physics.speed_x = -love.math.random(0, 5.5)
	            pellet.physics.speed_y = -15*Game:getFlag("bul_speed")
	            self.timer:every(0.01, function()
		            pellet.physics.speed_y = pellet.physics.speed_y + 0.2*Game:getFlag("bul_speed")
					if pellet.y < -10 then
						pellet.physics.speed_y = 1
						pellet.physics.speed_x = 0
						pellet.x = love.math.random(Game.battle.arena:getLeft()+20, Game.battle.arena:getRight()+20)
					end
		            if pellet.y > 235 and pellet.spawned == 0 then
			            if VineSound == 0 then
				            VineSound = 1
                            Assets.playSound("impact")
                            self.timer:after(0.7, function ()
                                Assets.playSound("grab")
                            end)
			            end
        		        local pellet2 = self:spawnBulletTo(Game.battle.mask, "thrown_vine", pellet.x, 243, math.rad(180), 0)
			            pellet.spawned = 1
			            pellet:remove()
		            end
	            end)
	            nBulletsSpawned = nBulletsSpawned + 1
	        end
        end)
    end)
end

return Basic

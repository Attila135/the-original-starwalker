local Aiming, super = Class(Wave)

function Aiming:onStart()
    -- Every 0.5 seconds...
    self.time = 20
    self.aim = false
    
    self.timer:every(2, function()
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setSprite("battle/alt_attack_ready_1")
        warn = self:spawnBullet("warning", 320, Game.battle.soul.y, 0, 0)
        self.aim = true
        self.timer:after(0.5, function()
            self.aim = false
        end)
        self.timer:after(1, function()
        enemy.sprite:setAnimation("battle/alt_attack", nil, false)
        slice = self:spawnBullet("slice", 320, warn.y, 0, 0)
        slice:fadeOutAndRemove(0.5)
        warn:remove()
        end)
    end
    end)
        
    self.timer:every(0.6, function()
        self.timer:script(function(wait)
            local min_x, min_y = 0, 0
            local max_x, max_y = 640, 480
            
            local spawn_x, spawn_y = math.random(min_x, max_x), math.random(min_y, max_y)
            
            local box = Game.battle.arena
            
            while (spawn_x >= box:getLeft() and spawn_x <= box:getRight()) and (spawn_y >= box:getTop() and spawn_y <= box:getBottom()) do
            spawn_x, spawn_y = math.random(min_x, max_x), math.random(min_y, max_y)
            end
            local angle = Utils.angle(spawn_x, spawn_y, Game.battle.soul.x, Game.battle.soul.y)

            fakebullet = self:spawnBullet("knife", spawn_x, spawn_y, angle, 0)
            fakebullet:setScale(0.5)
            fakebullet.rotation = Utils.angle(spawn_x, spawn_y, Game.battle.soul.x, Game.battle.soul.y)
            wait(0.5)
            realbullet = self:spawnBullet("knife", fakebullet.x, fakebullet.y, angle, 8)
            realbullet:setScale(0.5)
            realbullet.rotation = fakebullet.rotation
            fakebullet:remove()
            
    end)
    end)
end

function Aiming:update()
    -- Code here gets called every frame
    if self.aim == true then
        warn.y = Game.battle.soul.y
    end
    super.update(self)
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setAnimation("battle/idle", nil, true)
	end
end


return Aiming
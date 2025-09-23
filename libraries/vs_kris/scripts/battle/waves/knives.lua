local Aiming, super = Class(Wave)

function Aiming:update()
    speed = speed + 1
end

function Aiming:onStart()
    -- Every 0.5 seconds...
    self.time = 10
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
    super.update(self)
end

return Aiming
local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)
    --self:setArenaSize(284,284)
end

function Aiming:onStart()
timer = 0
Attack_Progress = 0
self.aim = 0

    self.time = 35
    self.timer:after(5, function()
        Attack_Progress = 1
    end)
    self.timer:after(6, function()
    for k,enemy in ipairs(self:getAttackers()) do
        --enemy.sprite:setAnimation("battle/act_ready", nil, true)
        end
    end)
    self.timer:after(10, function()
        for k,enemy in ipairs(self:getAttackers()) do
            --enemy.sprite:setSprite("battle/actend_01")
            end
        Attack_Progress = 2
    end)
    self.timer:after(20, function()
        for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:shake(4)
        --enemy.sprite:setSprite("battle/actend_01")
        end
        Attack_Progress = 4
    end)
    self.timer:after(27, function()
        for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:shake(4)
        --enemy.sprite:setSprite("battle/actend_02")
        end
    end)
    -- Every 0.5 seconds...
    for k,enemy in ipairs(self:getAttackers()) do
        --enemy.sprite:setSprite("battle/attackready_1")
    end
    Assets.playSound("noise")
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
    timer = timer + 1
    if Attack_Progress == 0 then
        if timer %42 == 0 then

        self.timer:script(function(wait)
            for k,enemy in ipairs(self:getAttackers()) do
                --enemy.sprite:setAnimation("battle/attack", nil, false)
    
                local attackers = self:getAttackers()
    
            -- Loop through all attackers
            for _, attacker in ipairs(attackers) do
    
                -- Get the attacker's center position
                local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
    
                -- Get the angle between the bullet position and the soul's position
                local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
    
                -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                local random_bullet = math.random(1,2)
                if random_bullet == 1 then
                -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                local bullet = self:spawnBullet("slash", x, y, angle, 12)
                bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
                bullet:setScale(0.5)
                elseif random_bullet == 2 then
                local bullet = self:spawnBullet("red_slash", x, y, angle, 27)
                bullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
                bullet:setScale(0.5)
                end
            end
                wait(0.5)
                Assets.playSound("noise")
                --enemy.sprite:setSprite("battle/attackready_1")
            end
    end)
        end
    
    elseif Attack_Progress == 1 then
        if timer %30 == 0 then
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
                    self.timer:after(0.3, function()
                    self.glove:fadeOutAndRemove(0.5)
                end)
                
                end)
        end
    
    elseif Attack_Progress == 2 then
        if timer %30 == 0 then
        dir = math.random(1,4)
            if dir == 1 then
                for i = -1, 2 do
                    local offset = i * 15
                    local Xture = self:spawnBullet("bullets/knife", Game.battle.arena.left - 20, Game.battle.arena.top - 100)
                    Xture.physics.direction = math.atan2(172 - Xture.y, 320 - Xture.x) + math.rad(offset)
                    Xture.physics.speed = 10
                    local x, y = Game.battle.arena.left - 20, Game.battle.arena.top - 100
                    Xture.rotation = Utils.angle(x, y, 320, 172) + math.rad(offset)
                    Xture:setScale(0.5)
                end
            elseif dir == 2 then
                for i = -1, 2 do
                    local offset = i * 15
                    local Xture = self:spawnBullet("bullets/knife", Game.battle.arena.right + 20, Game.battle.arena.top - 100)
                    Xture.physics.direction = math.atan2(172 - Xture.y, 320 - Xture.x) + math.rad(offset)
                    Xture.physics.speed = 10
                    local x, y = Game.battle.arena.right, Game.battle.arena.top - 100
                    Xture.rotation = Utils.angle(x, y, 320, 172) + math.rad(offset)
                    Xture:setScale(0.5)
                end
            elseif dir == 3 then
                for i = -1, 2 do
                    local offset = i * 15
                    local Xture = self:spawnBullet("bullets/knife", Game.battle.arena.left - 20, Game.battle.arena.bottom + 100)
                    Xture.physics.direction = math.atan2(172 - Xture.y, 320 - Xture.x) + math.rad(offset)
                    Xture.physics.speed = 10
                    local x, y = Game.battle.arena.left - 20, Game.battle.arena.top - 100
                    Xture.rotation = -Utils.angle(x, y, 320, 172) + math.rad(offset)
                    Xture:setScale(0.5)
                end
            elseif dir == 4 then
                for i = -1, 2 do
                    local offset = i * 15
                    local Xture = self:spawnBullet("bullets/knife", Game.battle.arena.right + 20, Game.battle.arena.bottom + 100)
                    Xture.physics.direction = math.atan2(172 - Xture.y, 320 - Xture.x) + math.rad(offset)
                    Xture.physics.speed = 10
                    local x, y = Game.battle.arena.right, Game.battle.arena.top - 100
                    Xture.rotation = -Utils.angle(x, y, 320, 172) + math.rad(offset)
                    Xture:setScale(0.5)
                end
            end
    end
    
    elseif Attack_Progress == 3 then
        if timer %30 == 0 then
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
    end
    elseif Attack_Progress == 4 then
        if timer %36 == 0 then
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
            wait(0.4)
            realbullet = self:spawnBullet("knife", fakebullet.x, fakebullet.y, angle, 8)
            realbullet:setScale(0.5)
            realbullet.rotation = fakebullet.rotation
            fakebullet:remove()
            
    end)
    end
    end

    if self.aim == 1 then
        local x, y = self.glove:getRelativePos(self.glove.width/2, self.glove.height/2)
        self.glove.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
    end

    super.update(self)
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
        enemy.y = 277
	end
end

return Aiming
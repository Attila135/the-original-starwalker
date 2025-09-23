local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)
    self:setArenaSize(284,284)
end

function Aiming:onStart()

    self.move = 2

    self.time = 20

    -- Every 0.5 seconds...
    for k,enemy in ipairs(self:getAttackers()) do
        enemy.sprite:setSprite("battle/attackready_1")
    end
    Assets.playSound("noise")
self.timer:every(4, function()
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
end)
self.timer:every(1.5, function()
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
    end)
    self.timer:after(1, function()
        enemy.sprite:setSprite("battle/attackready_1")
    end)
    end
end)
end)

self.timer:every(0.7, function()
    self.timer:script(function(wait)
        local x, y = math.random(Game.battle.arena:getLeft()-200,Game.battle.arena:getRight()+200), math.random(Game.battle.arena:getBottom()-200,Game.battle.arena:getTop()+200)

        local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

        fakebullet = self:spawnBullet("knife", x, y, angle, 0)
        fakebullet:setScale(0.5)
        fakebullet.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        wait(0.3)
        realbullet = self:spawnBullet("knife", fakebullet.x, fakebullet.y, angle, 8)
        realbullet:setScale(0.5)
        realbullet.rotation = fakebullet.rotation
        fakebullet:remove()
        
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
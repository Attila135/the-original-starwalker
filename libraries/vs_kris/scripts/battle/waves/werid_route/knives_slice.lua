local Aiming, super = Class(Wave)

function Aiming:onStart()
    -- Every 0.5 seconds...
    self.time = 20
    self.aim = false
    
    self.noelle = Sprite("bullets/noelle/idle", 588, 159)
    self.noelle:setAnimation({"bullets/noelle/idle", 0.2, true})
        self.noelle:setOrigin(0.5, 0.5)
        self.noelle.scale_y = 2
        self.noelle.scale_x = 2
        self.noelle.alpha = 0
        self.noelle.layer=BATTLE_LAYERS["top"]+15
        Game.battle:addChild(self.noelle)

        self.timer:after(14, function()
            self.noelle:fadeOutAndRemove(1)
        end)

    self.timer:every(2.5, function()
        ice = self:spawnBullet("ice_shock", x, y, angle, 0)
        ice:setScale(20)
    end)

    self.timer:every(1.5, function()
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
        
    self.timer:every(1.3, function()
        self.timer:script(function(wait)
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
    end)
end

function Aiming:update()
    if self.noelle.alpha < 0.5 and time ~= 1 then
        self.noelle.alpha = self.noelle.alpha + 0.01
    end
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
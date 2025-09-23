local Aiming, super = Class(Wave)

function Aiming:onStart()
    self.time = 15
    
    self.aim = 0
    self.arena = Game.battle.arena

        for k,enemy in ipairs(self:getAttackers()) do
            enemy.sprite:setAnimation("battle/act_ready", nil, true)
            self.susie = Sprite("bullets/susie/idle", 588, 159)
            self.susie:setAnimation({"bullets/susie/idle", 0.2, true})
            self.susie:setOrigin(0.5, 0.5)
            self.susie.scale_y = 2
            self.susie.scale_x = 2
            self.susie.alpha = 0
            self.susie.layer=BATTLE_LAYERS["top"]+15
            Game.battle:addChild(self.susie)
        end

        self.timer:after(14, function()
            self.susie:fadeOutAndRemove(1)
        end)
        --local x, y = math.random(self.arena.width), math.random(self.arena.height)

        self.timer:every(1.3, function()
            self.timer:script(function(wait)
                local min_x, min_y = 0, 0
            local max_x, max_y = 640, 480
            
            local spawn_x, spawn_y = math.random(min_x, max_x), math.random(min_y, max_y)
            
            local box = Game.battle.arena
            
            while (spawn_x >= box:getLeft() and spawn_x <= box:getRight()) and (spawn_y >= box:getTop() and spawn_y <= box:getBottom()) do
            spawn_x, spawn_y = math.random(min_x, max_x), math.random(min_y, max_y)
            end    
                local angle = Utils.angle(spawn_x, spawn_y, Game.battle.soul.x, Game.battle.soul.y)
    
                fakebullet = self:spawnBullet("dragon_fly", spawn_x, spawn_y, angle, 0)
                fakebullet:setScale(1)
                fakebullet.rotation = Utils.angle(spawn_x, spawn_y, Game.battle.soul.x, Game.battle.soul.y)
                wait(0.8)
                realbullet = self:spawnBullet("dragon_fly", fakebullet.x, fakebullet.y, angle, 12)
                realbullet.sprite:setAnimation({"bullets/susie/homing", 1/8, true})
                realbullet:setScale(1)
                realbullet.rotation = fakebullet.rotation
                fakebullet:remove()
                
        end)
        end)

        self.timer:every(2/2, function()
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
                self.timer:after(0.5, function()
                self.glove:fadeOutAndRemove(0.5)
            end)
            
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
    super.update(self)
    if self.susie.alpha < 0.5 and time ~= 1 then
        self.susie.alpha = self.susie.alpha + 0.01
    end
    if self.aim == 1 then
        local x, y = self.glove:getRelativePos(self.glove.width/2, self.glove.height/2)
        self.glove.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
    end
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		--enemy.sprite:setAnimation("battle/idle", nil, true)
	end
end

return Aiming
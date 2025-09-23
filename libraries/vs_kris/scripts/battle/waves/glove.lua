local Aiming, super = Class(Wave)

function Aiming:onStart()
    self.time = 15
    
    self.aim = 0
    self.arena = Game.battle.arena

        for k,enemy in ipairs(self:getAttackers()) do
            enemy.sprite:setAnimation("battle/act_ready", nil, true)
        end

        --local x, y = math.random(self.arena.width), math.random(self.arena.height)

        
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
end

function Aiming:update()
    super.update(self)
    if self.aim == 1 then
        local x, y = self.glove:getRelativePos(self.glove.width/2, self.glove.height/2)
        self.glove.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
    elseif self.aim == 2 then
        local x, y = self.glove:getRelativePos(self.glove.width/2, self.glove.height/2)
        self.Xture_glove1.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self.Xture_glove2.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
        self.Xture_glove3.rotation = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
    end
end

function Aiming:onEnd()
	for k,enemy in ipairs(self:getAttackers()) do
		enemy.sprite:setAnimation("battle/idle", nil, true)
	end
end

return Aiming
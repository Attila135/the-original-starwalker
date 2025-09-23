local PawClaw, super = Class(Bullet)
local targetRotation = 0
local timeVar2 = 0
local desX2 = 0
local desY2 = 0
local activeAim = false
local isDying = false


-- function PawClaw:onCollide(soul)
-- super.onCollide(self, soul)
-- if (self.damage > 0)
--     then
--             -- Kristal.Console:log("fakecollidee!")
--             local targets = Game.battle:getPartyFromTarget(self:getTarget())
--             for _, target in ipairs(targets) do
--             -- target.x = target.x + 5
--             target.isCursed = true
--         
--             end
--     end
-- end

-- function PawClaw:onDamage()
-- super.onDamage(self)
-- Kristal.Console:log("Cursed real!")
-- if Game:getConfig("targetSystem") then
-- 			local target = self:getTarget()
-- 
-- 			Kristal.Console:log("Cursed real!")
-- 		end
-- end

function PawClaw:init(x, y, dir, speed, desX, desY, spinSpeed)
    -- Last argument = sprite path
    self.desX2 = desX
    self.desY2 = desY
    self.activeAim = true
    self.timeVar2 = 0
    self.isDying = false
    self.tp = 0.8
    super.init(self, x, y, "bullets/pawclaw_closed")
    self.targetRotation = Utils.angle(self.x, self.y, self.desX2, self.desY2)
    self.spinSpeed = spinSpeed
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.rotation = dir
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    -- self.damage = 0
    -- self.tp = 0
    self.destroy_on_hit = false
    self.damage = 90
    self.alpha = 0
    self.scale_x = 1
    self.scale_y = 1
    
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(2, 2)
end

function PawClaw:update()
    -- For more complicated bullet behaviours, code here gets called every update
    
        if (self.isDying == false)
            then
        
            if (self.spinSpeed ~= 0)
            then
            self.x = self.x + (math.cos(self.rotation + 3.14/2) * 1) * self.spinSpeed
            self.y = self.y + (math.sin(self.rotation + 3.14/2) * 1) * self.spinSpeed
            self.rotation = Utils.angle(self.x, self.y, Game.battle.arena.x, Game.battle.arena.y)
            end
            if self.alpha < 1 then self.alpha = self.alpha + 0.06 else self.isDying = true end
            else
            if (self.physics.speed < 8)
                then
                self.physics.speed = self.physics.speed * 1.70
                end
            self.alpha = self.alpha - 0.05
            if (self.sprite.scale_x >= -1.8)
            then
            self.sprite:setScaleOrigin(0.5, 0.5)
            self.sprite:setScale(self.sprite.scale_x - 0.4, self.sprite.scale_y)
            -- self.scale_x = self.scale_x - 0.2
            -- if (self.scale_x == 0) then self.scale_x = -0.2 end
            else
            -- self.sprite:setSprite("bullets/pawclaw_closed", 0, false)
            end
            if (self.alpha <= 0.18) then self.damage = 0 end
            if (self.alpha <= 0.4) then self.tp = 0 self.alpha = self.alpha - 0.01  end
            end
    
    
        super.update(self)
        self.timeVar2 = self.timeVar2 + 1
        if (self.rotation ~= self.targetRotation)
        then
        --self.targetRotation = Utils.angle(self.x, self.y, self.desX2, self.desY2)
        -- self.rotation = Utils.approachAngle(self.rotation, self.targetRotation, Utils.ease(0, 10, self.timeVar2 / 60, "in-out-quad"))

        end
        self.physics.direction = self.rotation

end

return PawClaw
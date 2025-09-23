local LifePillar, super = Class(Bullet)

function LifePillar:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/lifepillar_1")
    
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.originSword = nil;
    self.alpha = 0;
end

function LifePillar:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.originSword ~= nil)
        then
        if (Utils.round(self.originSword.x)%100 < 100) then self.sprite:setSprite("bullets/lifepillar_4", 0, false) end
        if (Utils.round(self.originSword.x)%100 < 75) then self.sprite:setSprite("bullets/lifepillar_3", 0, false) end
        if (Utils.round(self.originSword.x)%100 < 50) then self.sprite:setSprite("bullets/lifepillar_2", 0, false) end
        if (Utils.round(self.originSword.x)%100 < 25) then self.sprite:setSprite("bullets/lifepillar_1", 0, false) end
            
        self.alpha = self.originSword.alpha;
        else
        end
    super.update(self)
end

return LifePillar
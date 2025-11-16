local Blooming, super = Class(Bullet)

function Blooming:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/bloom")
    self.alpha = 0
    self.collidable = false
    local timer = Timer()

    self:setHitbox(0, 0, self.width, self.height)
    
    self:addChild(timer)
    self.graphics = {
        fade_to = 1,
        fade = 0.07,
    } 
    self.sprite:pause()
    timer:script(function(wait)
        wait(0.3*Game:getFlag("bul_speed"))
        self.sprite:play(1/5, false)
        wait(0.5)
        self.collidable = true
        wait(0.9)
    self:fadeOutAndRemove(0.2)
    end)
end

function Blooming:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return Blooming
local ClefNote, super = Class(Bullet)

function ClefNote:onDamage(soul)
if (self.damage ~= 0)
    then
    super.onDamage(self, soul) 
    self.damage = 0;
    self.tp = 0;
    end

end

function ClefNote:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/clefnote")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    
    self.scale_x = 0.5
    self.scale_y = 0.5
    self.sprite:setScaleOrigin(0.5, 0.5);
    self.sprite:setScale(2, 2);
    self.alpha = 0;
    self.damage = 90
    self.destroy_on_hit = false
    --self.inv_timer = 0.0;
end

function ClefNote:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.alpha < 1)
        then
        if (self.x ~= 0 and self.x > 40) then self.alpha = (220 - self.x) / 80; end
        end

    if (self.x < 70)
        then
        self.alpha = 1 - ((80 - self.x) / 70);
        if (self.alpha <= 0) then self:remove(); end
        end

    super.update(self)
end

return ClefNote
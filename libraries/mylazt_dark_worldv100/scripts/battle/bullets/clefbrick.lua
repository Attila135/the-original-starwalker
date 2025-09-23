local clefbrick, super = Class(Bullet)

function clefbrick:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/clefbrick")
    
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    
    --self.scale_x = 0.5
    --self.scale_y = 0.5
    --self:setScaleOrigin(0.5, 0.5);
    self:setScale(2, 40);
    self.alpha = 0;
    self.damage = 80;
    self.destroy_on_hit = false
    --self.tp = 0;
    self.inv_timer = 0.4;

end

function clefbrick:update()
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

return clefbrick
local loberapierce, super = Class(Bullet)

function loberapierce:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/loberapierce_rightwards")

    self.isBreak = true;
    self.breakType = "lobera";

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    if (self.physics.direction < math.rad(90))
        then
        self.sprite:setAnimation({"bullets/loberapierce_leftwards", 0.05, false, frames = {4}});
        else
        self.sprite:setAnimation({"bullets/loberapierce_rightwards", 0.05, false, frames = {4}});
        end
    self.rotation = dir;
    self.destroy_on_hit = false;
    self.damage = 50;
    self:setScale(2, 1.2);
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(1, 2)
    self.alpha = 0;
    self.inv_timer = 0.3;
    self.battle_fade = false;
end

function loberapierce:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.alpha < 1 and self.damage > 0) then self.alpha = self.alpha + 0.1 * DTMULT end
    if (self.physics.speed < 20) then self.physics.speed = self.physics.speed + 0.20 * DTMULT; end
    -- if (self.alpha > 1.4) then self.physics.direction = self.physics.direction + math.rad(0.2); end
    --self.rotation = self.physics.direction;
    super.update(self)
end

return loberapierce
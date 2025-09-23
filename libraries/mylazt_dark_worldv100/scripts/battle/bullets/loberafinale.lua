local loberafinale, super = Class(Bullet)

function loberafinale:init(x, y, ownerPaw, moveX, moveY)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/loberafinale")

    self.moveX = moveX;
    self.moveY = moveY;
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    -- self.physics.direction = dir;
    -- Speed the bullet moves (pixels per frame at 30FPS)
    -- self.physics.speed = speed;
    self:setScale(3, 3);
    self.ownerPaw = ownerPaw;
    -- self.sprite:setScaleOrigin(0.5, 0.5);
    -- self.sprite:setScale(1, 2);
    self.destroy_on_hit = false;
    -- self:shake(20);
    self.alpha = 0.3;
    self.timeVar = 0;
    self.damage = 50;
end

function loberafinale:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.timeVar < 1) 
        then
        self.alpha = self.alpha + 0.01 * DTMULT;
        self.timeVar = self.timeVar + 0.01 * DTMULT;
        if (self.timeVar > 0.4) then self.timeVar = self.timeVar - 0.002 * DTMULT; end
        if (self.timeVar > 0.7) then self.timeVar = self.timeVar - 0.0045 * DTMULT; end
        end
    if (self.ownerPaw ~= nil)
        then
        self.x = self.ownerPaw.x + (self.moveX * self.timeVar);
        self.y = self.ownerPaw.y - 100 + (self.moveY * self.timeVar);
        if (self.ownerPaw.spinBox.shouldKill == true) then self:remove(); end
        end
    super.update(self)
end

return loberafinale
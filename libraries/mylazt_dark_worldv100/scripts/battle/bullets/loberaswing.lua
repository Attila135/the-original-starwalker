local loberaswing, super = Class(Bullet)


function loberaswing:onDamage(soul)

local doDamage = false;
if (soul:isMoving() == true and self.loberaColor == "cyan" and self.canHit > 0)
    then
    doDamage = true;
    end

if (soul:isMoving() == false and self.loberaColor == "orange" and self.canHit > 0)
    then
    doDamage = true;
    end

if (doDamage == true) then super.onDamage(self, soul) end

end

function loberaswing:init(x, y, dir, loberaColor)
    -- Last argument = sprite path
    self.loberaColor = loberaColor;
    super.init(self, x, y, "bullets/loberaswing_" .. self.loberaColor)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    self.rotation = dir;
    self.canHit = 2;
    self.alpha = 0.4;
    Assets.playSound("darkslice")
    self.sprite:play(0.13, false)
    self.destroy_on_hit = false;
    self.tp = 0;
    self.damage = 80;
    self:setScale(2.5, 2.5);
    self.inv_timer = 0.1;
    self.loberaLife = 0.6;
end

function loberaswing:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.loberaLife = self.loberaLife - 0.10 * DTMULT;
    self.canHit = self.canHit - 1 * DTMULT;
    if (self.loberaLife <= 0)
        then
        self:remove();
        end
    super.update(self)
end

return loberaswing
local BlockPillar, super = Class(Bullet)

function BlockPillar:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/blockpillar")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.color = {0, 0.75, 0};
    self.alpha = 0;
    self.layer = 180;
    self.intendX = x;
    self.intendY = y;
    self.addHeight = 300;
    self.x = self.intendX;
    self.y = self.intendY - self.addHeight;
    self.timeVar = 0;
    self.reachedDes = false;
    self.remove_offscreen = false;
end

function BlockPillar:update()
    self.timeVar = self.timeVar + 1 * DTMULT;
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.alpha < 1) then self.alpha = self.alpha + 0.02 * DTMULT; end
    

    self.y = Utils.ease(self.intendY - self.addHeight, self.intendY, self.timeVar / 50, "in-quad")
    if (self.y == self.intendY and self.reachedDes == false)
        then
        self:shake(4);
        self.reachedDes = true;
        Assets.playSound("darkshake")
        end

    super.update(self)
end

return BlockPillar
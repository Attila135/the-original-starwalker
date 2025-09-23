local grazerbullet, super = Class(Bullet)

function grazerbullet:init(ownerThing, setSize)
    -- Last argument = sprite path
    super.init(self, -1000, -1000, "bullets/smallbullet")
    self.ownerThing = ownerThing;
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.damage = 0;
    self.alpha = 0.0;
    self.tp = 1;
    self.destroy_on_hit = false;
    self:setScale(setSize, setSize)
end

function grazerbullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.ownerThing ~= nil and self.ownerThing.destroyGraze == nil)
        then
        self.x = self.ownerThing.x;
        self.y = self.ownerThing.y;
        else
        self:remove();
        end
    super.update(self)
end

return grazerbullet
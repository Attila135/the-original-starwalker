local laserwarning, super = Class(Bullet)

function laserwarning:init(x, y, rotation, ownerPillar)
    -- Last argument = sprite path
    super.init(self, x, y, "tornline")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self:setOrigin(0.5, 0.5);
    self:setRotationOrigin(0.5, 0.5);
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.lineRotation = rotation;
    self.damage = 0;
    self.tp = 0;
    self.destroy_on_hit = false;
    self.sprite.wrap_texture_x = true;
    -- self:shake(5);
    self:setLayer(1000);
    self.ownerPillar = ownerPillar;
    self.laserLife = 30;
    -- self:setScale(40, 1);
    self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.laserLife = self.laserLife - 1;
-- FIXER END BELOW
    end)
-- FIXER MULT END
end

function laserwarning:draw()
    local laserWidth = 600;
    love.graphics.setLineWidth(1);
    love.graphics.setColor({0.3, 0.3, 0.3, 0.7});
    if (self.laserLife < 12)
        then 
            if (self.laserLife % 8 <= 3)
            then
            love.graphics.setColor({1.0, 1.0, 0.0, 0.8}); else love.graphics.setColor({1.0, 0.0, 0.0, 0.8});
            end
        end
    love.graphics.line(math.cos(self.lineRotation) * laserWidth * -1, math.sin(self.lineRotation) * laserWidth * -1, math.cos(self.lineRotation) * laserWidth * 1, math.sin(self.lineRotation) * laserWidth * 1);

    --super.draw(self)
end
function laserwarning:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.ownerPillar ~= nil)
    then
        self.x = self.ownerPillar.x;
        self.y = self.ownerPillar.y;
    end
    
    if (self.laserLife <= 0) 
    then 
        self.wave:spawnBullet("laserhazard", self.x, self.y, self.lineRotation);
        self:remove();
    end
    super.update(self)
end

return laserwarning
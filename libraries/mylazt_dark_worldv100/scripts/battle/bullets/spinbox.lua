local spinbox, super = Class(Bullet)

function spinbox:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/spinbox")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.shouldSound = false;
    self.shouldKill = false;
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.timeVar = 0;
    self.damage = 0;
    self.tp = 0;
    self.alpha = 1;
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.xScale = 0.5;
    self.yScale = 0.5;
    self.color = Game.battle.arena.color;
    self.destroy_on_hit = false;
    self:setLayer(142)
    --Kristal.Console:log("newphased");
end

function spinbox:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.shouldSound == true) then Assets.playSound("darkclaw"); self.shouldSound = false; end
    self.rotation = self.rotation + math.rad(10) * DTMULT;
    self.timeVar = self.timeVar + 1 * DTMULT;
    if (self.xScale < 10)
    then
        self.xScale = self.xScale + 0.07 * DTMULT;
        self.yScale = self.yScale + 0.05 * DTMULT;
    end
    if (self.alpha < 1) then self.alpha = self.alpha + 0.01 * DTMULT; self.y = self.y - 1 * DTMULT; end
    self.sprite:setScale(self.xScale, self.yScale);
    if (self.shouldKill == true) then self.alpha = -10; end

    super.update(self)
end

return spinbox
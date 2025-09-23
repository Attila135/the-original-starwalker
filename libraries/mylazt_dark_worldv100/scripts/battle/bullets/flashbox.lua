local flashbox, super = Class(Bullet)

function flashbox:init(x, y, spinBox)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/flashbox")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.shouldSound = false;
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.timeVar = 0;
    self.damage = 0;
    self.tp = 0;
    self.alpha = -0.1;
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.xScale = 10.5;
    self.yScale = 10.5;
    -- self.color = Game.battle.arena.color;
    self.destroy_on_hit = false;
    self:setLayer(999)
    self.sprite:setScale(self.xScale, self.yScale);
    self.isLeaving = false;
    self.spinBox = spinBox;
    --Kristal.Console:log("newphased");
end

function flashbox:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if (self.isLeaving == false)
        then
        if (self.alpha < 1.03)
            then 
            self.alpha = self.alpha + 0.005 * DTMULT; 
            if (self.alpha > 0.5) then self.alpha = self.alpha + 0.005 * DTMULT;  end
            else 
            self.isLeaving = true;
            self.spinBox.shouldKill = true;
            end
        else -- is leaving
        self.alpha = self.alpha - 0.04 * DTMULT;
        if (self.alpha < -0.1) 
        then
        self.wave.time = 0;
        end
        end
    super.update(self)
end

return flashbox
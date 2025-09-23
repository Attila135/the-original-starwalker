local Clef, super = Class(Bullet)

function Clef:init(x, y, dir, speed, type, spinSpeed, spinDistance, spinSpeed2, spinDistance2, activeTimer)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/trebleclef")

    

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.alpha = 0;
    self.lineTimer = 0;
    self.activeTimer = activeTimer;
    self.didShake = false;
    self.shakeNumber = 0;
    self.realX = x;
    self.realY = y;
    self.addX = 0;
    self.addY = 0;
    self.spinSpeed = spinSpeed;
    self.spinDistance = spinDistance;
    self.spinSpeed2 = spinSpeed2;
    self.spinDistance2 = spinDistance2;
    self.lineBaseY = 10;
    self.lineBaseX = -5;
    self.lineSpacer = 6;
    self.lineAlpha = 0.4;
    self.lineMax = 52;
    self.layer = 499;

    self.damage = 80;
    self.destroy_on_hit = false;

    if (type == 2) then self.sprite:setSprite("bullets/bassclef", 0, false); self.lineBaseY = self.lineBaseY - 11; end

    self.Line1Sprite = Sprite("clefline")
    self.Line1Sprite:setScaleOrigin(0, 0.5)
    self.Line1Sprite.lineWidth = 0;
    self.Line1Sprite:setScale(self.Line1Sprite.lineWidth, 1);
    self:addChild(self.Line1Sprite)
    self.Line1Sprite.x = self.lineBaseX;
    self.Line1Sprite.y = self.Line1Sprite.y + self.lineBaseY + self.lineSpacer * 0;
    self.Line1Sprite.layer = self.sprite.layer - 1
    self.Line1Sprite.alpha = self.lineAlpha;

    self.Line2Sprite = Sprite("clefline");
    self.Line2Sprite:setScaleOrigin(0, 0.5);
    self.Line2Sprite.lineWidth = 0;
    self.Line2Sprite:setScale(self.Line2Sprite.lineWidth, 1);
    self:addChild(self.Line2Sprite);
    self.Line2Sprite.x = self.lineBaseX;
    self.Line2Sprite.y = self.Line2Sprite.y + self.lineBaseY + self.lineSpacer * 1;
    self.Line2Sprite.layer = self.sprite.layer - 1;
    self.Line2Sprite.alpha = self.lineAlpha;

    self.Line3Sprite = Sprite("clefline");
    self.Line3Sprite:setScaleOrigin(0, 0.5);
    self.Line3Sprite.lineWidth = 0;
    self.Line3Sprite:setScale(self.Line3Sprite.lineWidth, 1);
    self:addChild(self.Line3Sprite);
    self.Line3Sprite.x = self.lineBaseX;
    self.Line3Sprite.y = self.Line3Sprite.y + self.lineBaseY + self.lineSpacer * 2;
    self.Line3Sprite.layer = self.sprite.layer - 1;
    self.Line3Sprite.alpha = self.lineAlpha;

    self.Line4Sprite = Sprite("clefline");
    self.Line4Sprite:setScaleOrigin(0, 0.5);
    self.Line4Sprite.lineWidth = 0;
    self.Line4Sprite:setScale(self.Line4Sprite.lineWidth, 1);
    self:addChild(self.Line4Sprite);
    self.Line4Sprite.x = self.lineBaseX;
    self.Line4Sprite.y = self.Line4Sprite.y + self.lineBaseY + self.lineSpacer * 3;
    self.Line4Sprite.layer = self.sprite.layer - 1;
    self.Line4Sprite.alpha = self.lineAlpha;

    self.Line5Sprite = Sprite("clefline");
    self.Line5Sprite:setScaleOrigin(0, 0.5);
    self.Line5Sprite.lineWidth = 0;
    self.Line5Sprite:setScale(self.Line5Sprite.lineWidth, 1);
    self:addChild(self.Line5Sprite);
    self.Line5Sprite.x = self.lineBaseX;
    self.Line5Sprite.y = self.Line5Sprite.y + self.lineBaseY + self.lineSpacer * 4;
    self.Line5Sprite.layer = self.sprite.layer - 1;
    self.Line5Sprite.alpha = self.lineAlpha;

    self.Line6Sprite = Sprite("clefline");
    self.Line6Sprite:setScaleOrigin(0, 0);
    self.Line6Sprite.lineWidth = 0;
    self.Line6Sprite:setScale(0.25, self.Line6Sprite.y + self.lineSpacer * 4);
    self:addChild(self.Line6Sprite);
    self.Line6Sprite.x = self.lineBaseX;
    self.Line6Sprite.y = self.Line6Sprite.y + self.lineBaseY + self.lineSpacer * 0;
    self.Line6Sprite.layer = self.sprite.layer - 1;
    self.Line6Sprite.alpha = self.lineAlpha;
    self:shake(5);



end
function Clef:draw()
    super.draw(self);
    -- love.graphics.line(self.x, self.y, self.x + 1, self.y + 1)
end

function Clef:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.lineTimer = self.lineTimer + 1 * DTMULT;

    self.Line1Sprite.lineWidth = Utils.ease(self.Line1Sprite.lineWidth, self.lineMax, self.lineTimer / 40, "in-out-quad")
    self.Line1Sprite:setScale(self.Line1Sprite.lineWidth, 1);

    self.Line2Sprite.lineWidth = Utils.ease(self.Line2Sprite.lineWidth, self.lineMax, self.lineTimer / 40, "in-out-quad");
    self.Line2Sprite:setScale(self.Line2Sprite.lineWidth, 1);

    self.Line3Sprite.lineWidth = Utils.ease(self.Line3Sprite.lineWidth, self.lineMax, self.lineTimer / 40, "in-out-quad");
    self.Line3Sprite:setScale(self.Line3Sprite.lineWidth, 1);

    self.Line4Sprite.lineWidth = Utils.ease(self.Line4Sprite.lineWidth, self.lineMax, self.lineTimer / 40, "in-out-quad");
    self.Line4Sprite:setScale(self.Line4Sprite.lineWidth, 1);

    self.Line5Sprite.lineWidth = Utils.ease(self.Line5Sprite.lineWidth, self.lineMax, self.lineTimer / 40, "in-out-quad");
    self.Line5Sprite:setScale(self.Line5Sprite.lineWidth, 1);

    self.addY = math.sin(self.activeTimer * self.spinSpeed / 20) * self.spinDistance;
    self.addX = math.sin(self.activeTimer * self.spinSpeed2 / 20) * self.spinDistance2;

    if (self.alpha < 1)
        then
            self.shakeNumber = self.shakeNumber + 1 * DTMULT;
            self.alpha = self.alpha + 0.05 * DTMULT;
            
        else
        self.activeTimer = self.activeTimer + 1 * DTMULT;
        end
    self.x = self.realX + self.addX;
    self.y = self.realY + self.addY;
    super.update(self)
end

return Clef
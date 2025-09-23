local Unveiledfallthing, super = Class(Object)




function Unveiledfallthing:init(x, y, heightspawn)
    super:init(self, x, y - heightspawn)

    self.goalX = x;
    self.goalY = y;

    self.lineLifetime = 0;
    --self:setLayer(self.layer - 0.01);
    self.sprite = Sprite("unveiled_fallthing");
    self:addChild(self.sprite);
    self.alpha = 0;
    self.sprite.alpha = 0;
    --self:setLayer(-20);
    --self:setOrigin(0.5, 0);
    --self:setRotationOrigin(0.5, 0);
    -- Kristal.Console:log("voicer spawned")
    
    self.theTime = 1.0;

    --self.otherX = love.math.random(-100, 100) / 100;
    --self.otherY = love.math.random(-5, -9);
    self.hasShaken = false;
    self.siner = 0;

    self.timer = Timer();
    self:addChild(self.timer);
    self.timer:tween(self.theTime, self, {y = self.goalY, alpha = 1.0}, 'out-quad');
    self.timer:after(self.theTime + 0.1,
            function() 
            --Assets.playSound("Grab")
            self.y = self.goalY;
            end);

    -- Kristal.Console:log("initiated")
end

function Unveiledfallthing:update()
    super:update(self)
   -- use DTMULT
   self.siner = self.siner + 1 * DTMULT / 20;
   self.sprite.alpha = self.alpha;
   if (self.parent ~= nil and self.parent.removeChildFences ~= nil and self.parent.removeChildFences == true)
    then
    self:remove();
    end
   --self.x = math.cos(self.siner) * 5 * self.randomX;
   --self.y = math.sin(self.siner) * 5 * self.randomX / 2;
   --if (self.lineLifetime <= 34)
   --    then
   --    self.lineLifetime = self.lineLifetime + 1 * DTMULT;
   --    self.otherX = self.otherX + 1.1 * DTMULT;
   --    self.otherY = self.otherY - 6.1 * DTMULT;
   --    else
   --    if (self.hasShaken == false) 
   --     then
   --     self.hasShaken = true;
   --     self:shake(5);
   --     end
   --    end
end



return Unveiledfallthing

local FenceDrop, super = Class(Object)




function FenceDrop:init(x, y, heightspawn, landtime, fType)
    super.init(self, x, y - heightspawn)

    self.goalX = x;
    self.goalY = y;

    self.lineLifetime = 0;
    --self:setLayer(self.layer - 0.01);
    self.sprite = Sprite(fType); 
    self:addChild(self.sprite);
    --self:setLayer(-20);
    --self:setOrigin(0.5, 0);
    --self:setRotationOrigin(0.5, 0);
    -- Kristal.Console:log("voicer spawned")
    
    self.theTime = landtime;

    --self.otherX = love.math.random(-100, 100) / 100;
    --self.otherY = love.math.random(-5, -9);
    self.hasShaken = false;
    self.siner = 0;

    self.timer = Timer();
    self:addChild(self.timer);
    self.timer:tween(self.theTime, self, {y = self.goalY}, 'out-quad');
    self.timer:after(self.theTime + 0.1,
            function() 
            --Assets.playSound("Grab")
            Assets.playSound("darkshake", 0.5);
            self:shake(4);
            self.y = self.goalY;
            end);

    -- Kristal.Console:log("initiated")
end

function FenceDrop:update()
    super.update(self)
   -- use DTMULT
   self.siner = self.siner + 1 * DTMULT / 20;
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

function FenceDrop:draw()

    --Draw.setColor(0.63, 0.38, 0.76)
    --love.graphics.setLineWidth(1);
    --love.graphics.line(self.parent.sprite.width / 2, self.parent.sprite.height / 2, self.otherX, self.otherY);
    super.draw(self)
   
    
    -- self.x = self.x + 5
end

return FenceDrop

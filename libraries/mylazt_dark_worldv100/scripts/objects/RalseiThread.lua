local RalseiThread, super = Class(Object)




function RalseiThread:init(x, y, rotation)
    super:init(self, x, y)

    self.lineLifetime = 0;
    self:setLayer(self.layer - 0.01);
    self.sprite = Sprite("ralseithreads"); 
    self:addChild(self.sprite);
    --self:setLayer(-20);
    --self:setOrigin(0.5, 0);
    --self:setRotationOrigin(0.5, 0);
    -- Kristal.Console:log("voicer spawned")
    
    self.rotation = rotation;

    --self.otherX = love.math.random(-100, 100) / 100;
    --self.otherY = love.math.random(-5, -9);
    self.hasShaken = false;
    self.siner = 0;


    -- Kristal.Console:log("initiated")
end

function RalseiThread:update()
    super:update(self)
   -- use DTMULT
   self.siner = self.siner + 1 * DTMULT / 20;

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

function RalseiThread:draw()

    --Draw.setColor(0.63, 0.38, 0.76)
    --love.graphics.setLineWidth(1);
    --love.graphics.line(self.parent.sprite.width / 2, self.parent.sprite.height / 2, self.otherX, self.otherY);
    super:draw(self)
   
    
    -- self.x = self.x + 5
end

return RalseiThread

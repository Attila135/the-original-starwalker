local EmergeLine, super = Class(Object)




function EmergeLine:init()
    super:init(self, 0, 0)

    self.lineLifetime = 0;
    self:setLayer(self.layer - 0.01);
    -- Kristal.Console:log("voicer spawned")
    
    self.otherX = love.math.random(-100, 100) / 100;
    self.otherY = love.math.random(-5, -9);
    self.hasShaken = false;
    self.siner = 0;

    self.randomX = love.math.random(20, 50) / 100;

    -- Kristal.Console:log("initiated")
end

function EmergeLine:update()
    super:update(self)
   -- use DTMULT
   self.siner = self.siner + 1 * DTMULT / 20;
   self.x = math.cos(self.siner) * 5 * self.randomX;
   self.y = math.sin(self.siner) * 5 * self.randomX / 2;
   if (self.lineLifetime <= 34)
       then
       self.lineLifetime = self.lineLifetime + 1 * DTMULT;
       self.otherX = self.otherX + 1.1 * DTMULT;
       self.otherY = self.otherY - 6.1 * DTMULT;
       else
       if (self.hasShaken == false) 
        then
        self.hasShaken = true;
        self:shake(5);
        end
       end
end

function EmergeLine:draw()

    Draw.setColor(0.63, 0.38, 0.76)
    love.graphics.setLineWidth(1);
    love.graphics.line(self.parent.sprite.width / 2, self.parent.sprite.height / 2, self.otherX, self.otherY);
    super:draw(self)
   
    
    -- self.x = self.x + 5
end

return EmergeLine

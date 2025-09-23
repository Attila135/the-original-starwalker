local LeashLine, super = Class(Object)
local segmentIdleSprite = Assets.getTexture("leashsegmentidle")
local segmentDamageSprite = Assets.getTexture("leashsegmentdamage")



function LeashLine:init(firstX, firstY, secondX, secondY, firstGX, firstGY, secondGX, secondGY, focusThing)
    super:init(self, 0, 0)

    self.lineLifetime = 0;
    self:setLayer(self.layer - 0.01);
    --Kristal.Console:log("growl")
    
    
    
    self.x = firstX;
    self.y = firstY;
    self.addMainX = firstX;
    self.addMainY = firstY;

    self.otherX = secondX;
    self.otherY = secondY;
    self.hasShaken = false;
    self.siner = 0;

    self.downPoint = 0.1;
    self.downAmount = 20;

    self.curveAmount = 6;
    self.extraY = 0;


    --self.curveAmount = 0;
    --self.downAmount = 0;


    self.idleMult = 1;
    self.startDownAmount = self.downAmount;
    --self.inherit_color = false;

    self:setLayer(300);
    self:setScale(2);

    self.focusThing = focusThing;
    if (self.focusThing ~= nil)
        then
        --self:setLayer(self.focusThing:getLayer() + 100);
        --Kristal.Console:log(self.layer)
        self:setLayer(0);
        end

    self.timer = Timer()
    self:addChild(self.timer)

    local hasPerson = false;
    local leashDelay = 1;

    if (self.focusThing.hasLeash ~= nil) then hasPerson = true; leashDelay = 0; end

    

    self.timer:tween(leashDelay, self, {x = firstGX, y = firstGY, otherX = secondGX, otherY = secondGY, addMainX = firstGX, addMainY = firstGY}, 'out-quad');

    if (hasPerson == false)
    then
    self.timer:after(1,
            function() 
            --Assets.playSound("Grab")
            Assets.playSound("grab");
            self.focusThing:shake(10);
            end);
    end
    --self.randomX = love.math.random(20, 50) / 100;
    --Kristal.Console:log("" .. self.color_mask)
    --self.inherit_color = true;
    -- Kristal.Console:log("initiated")
end

function LeashLine:update()
    super:update(self)
    
   -- use DTMULT


   self.siner = self.siner + 1 * DTMULT / 20 * self.idleMult;
   self.downAmount = self.startDownAmount + math.cos(self.siner) * 1.5;

   if (self.focusThing ~= nil)
        then
        self.x = self.focusThing.x + self.addMainX;
        self.y = self.focusThing.y + self.addMainY;
        else
        
        end
    --Kristal.Console:log("" .. self.y)
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

function LeashLine:draw()

    
    local leashOffsetX = 0;
    local offsetX = 0;
    local offsetY = 0;
    local shakeIntensity = 1;
    local theSprite = segmentIdleSprite;
    local leashX = 0;
    if (self.focusThing ~= nil and self.focusThing.sprite.maskaughtHead ~= nil)
    then
        if (self.focusThing.hasLeash ~= nil) then leashOffsetX = 15; end
        if (self.focusThing.hurt_timer > 0) then theSprite = segmentDamageSprite; end
        --offsetX = self.focusThing.sprite.width / 2;
        leashX = leashX + self.focusThing.sprite.maskaughtHead.x - 24;
        offsetY = 0 - self.focusThing.sprite.height / 2 - 10 + leashOffsetX;
    else
    offsetY = offsetY - 20;
    end
    
    shakeIntensity = self.focusThing.sprite.graphics.shake_x;
    offsetX = shakeIntensity;

    offsetX = offsetX + self.addMainX;
    offsetY = offsetY + self.addMainY;
    offsetY = offsetY + self.extraY;
    local targetAngle = Utils.angle(offsetX, offsetY, self.otherX, self.otherY);
    --noline--Draw.setColor(0.57, 0.81, 0.47)
    --noline--love.graphics.setLineWidth(3);
    --noline------local lineApart = 5;
    --noline--love.graphics.line(offsetX, offsetY, self.otherX, self.otherY);


    --Draw.setColor(1, 1, 1)
    
    local segmentsLengthTotal = Utils.dist(offsetX, offsetY, self.otherX, self.otherY)

    local segmentAmount = (segmentsLengthTotal / 6);
    local segmentsLengthX = self.otherX / segmentAmount;
    local segmentsLengthY = self.otherY / segmentAmount;
    for i = segmentAmount, 0, -1 
    do
        local segmentAddX = 5;
        local segmentAddY = -4;
        local segmentOffX = 0;
        local segmentOffY = 0;
        local segmentAngle = targetAngle;
        local segmentNumber = i;

        segmentAngle = segmentAngle + math.cos(self.siner + segmentNumber) * 0.1 * (shakeIntensity * 0.2);
        segmentOffX = segmentOffX + math.cos(self.siner + segmentNumber) * 0.3;
        segmentOffY = segmentOffY + math.cos(self.siner + segmentNumber) * 0.8;
        
        segmentOffX = segmentOffX + math.sin(segmentAngle) * segmentAddX;
        segmentOffY = segmentOffY + math.cos(segmentAngle) * segmentAddY;

        --segmentOffY = segmentOffY + 5;



        --segmentOffY = segmentOffY + ( math.max( math.abs(( (segmentNumber + forgiveAmount) / (segmentAmount) ) - self.downPoint), 0) * self.downAmount);
        segmentOffY = segmentOffY + math.abs((segmentNumber / segmentAmount) * (segmentNumber / self.curveAmount) - self.downPoint) * (self.downAmount * -1) + self.downAmount / 2 - 5;

        love.graphics.draw(theSprite, offsetX + (segmentsLengthX * segmentNumber) + segmentOffX + leashX, offsetY + (segmentsLengthY * segmentNumber) + segmentOffY, segmentAngle, 1, 1)
    end 

    super:draw(self)
   
    
    -- self.x = self.x + 5
end

return LeashLine

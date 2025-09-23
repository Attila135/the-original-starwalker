local PurpleShatter, super = Class(Object)




function PurpleShatter:init(x, y, shatterCount, shatterDirection, getOwner)
    super:init(self, x, y)

    self.theOwner = getOwner;
    self.theOwner:addChild(self);
    self:setLayer(self.layer + 1);
    self.sprite = Sprite("purpleshatter"); 
    self:addChild(self.sprite);
    self.alpha = 1;
    --Kristal.Console:log("shatter spawned")
    self:setOrigin(0.5, 0.5);
    self.sprite:setOrigin(0.5, 0.5);
    
    
    

    self.rotation = math.rad(Utils.random(360));
    self.addRotation = math.rad(Utils.pick({10, -10, 5, -5}));
    self.physics.direction = math.rad(Utils.random(60) + 75) * -1;
    self.physics.speed = 1.0;
    self.physics.gravity = 0.02;
    
    for i = 1, shatterCount
            do
            local newShatter = PurpleShatter(x + math.cos(shatterDirection) * 40 * i, y + math.sin(shatterDirection) * 40 * i, 0, 0, self.theOwner)
            self.theOwner:addChild(newShatter);
            end



    -- Kristal.Console:log("initiated")
end

function PurpleShatter:update()
    super:update(self)
    self.sprite.alpha = self.sprite.alpha - (0.01 * DTMULT);
    self.rotation = self.rotation + (self.addRotation * DTMULT);
    if (self.sprite.alpha <= 0) then self:remove(); end
end


return PurpleShatter

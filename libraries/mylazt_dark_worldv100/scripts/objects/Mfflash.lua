local Mfflash, super = Class(Object)




function Mfflash:init(x, y)
    super.init(self, x, y)

    self.lineLifetime = 0;
    self.sprite = Sprite("spr_mff")
    self.sprite:setOrigin(0.5, 0.5)
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setScale(2, 2);
    self:addChild(self.sprite);
    self.sprite:setAnimation({"spr_mff", 0.15, false, frames = {1, 2}, callback = function(spritething) self:fadeOutAndRemove(0.5); end })
    -- Kristal.Console:log("voicer spawned")
    
    self.otherX = love.math.random(-100, 100) / 100;
    self.otherY = love.math.random(-5, -9);
    self.hasShaken = false;
    self.siner = 0;
    self:setLayer(9999);
    self:shake(-5, -5);

    self.randomX = love.math.random(20, 50) / 100;

    -- Kristal.Console:log("initiated")
end

function Mfflash:update()
    self.sprite.alpha = self.alpha;
    super.update(self)
  
end

function Mfflash:draw()

    super.draw(self)
   
    
    -- self.x = self.x + 5
end

return Mfflash

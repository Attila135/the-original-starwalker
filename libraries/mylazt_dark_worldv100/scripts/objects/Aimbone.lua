local Aimbone, super = Class(Object)

local boneReady = Assets.getTexture("npcs/bonethrow_aim_1")

function Aimbone:init(x, y, mainBone)
    --super.init(self, spawnX, spawnY)
    super.init(self, x, y)
    self.spawnX = spawnX;
    self.spawnY = spawnY;
    self.mainBone = mainBone;
    --self.sprite = Sprite("npcs/bonethrow_idle");
    self.sprite = Sprite("npcs/bonethrow_aim_1");
    --self.sprite:setAnimation({"quiz", 1.0, true});
    self:addChild(self.sprite);


    self.sprite:setAnimation({"npcs/bonethrow_aim", 0.1, true, frames = {1, 2}});

    --self.sprite:setOrigin(1, 0.5);
    --self:setOrigin(0.5, 0.5);
    --self:setScaleOrigin(0.5, 0.5);
    --self:setScale(2, 2);
    --Kristal.Console:log("tbathtub spawned")
    self.lifetime = 0;
    self.textSiner = 0;
    self.desY = 230;
    self.timer = Timer()
    self:addChild(self.timer)
    self:setScale(2, 2);
    -- Kristal.Console:log("initiated")
    self.moveX = 0;
    self.moveY = 0;
    self.player = nil;
    self.afterImageTime = 0;
    self.stepsTaken = 0;
    self.tubSounded = false;
    self.spawnedProperly = false;
    self.middleWidth = self.sprite.width / 2;
    self.bathStartX = 0;
    self.bathStartY = 0;
    self.collider = Hitbox(self, 0, 0, 10, 10);

    self.solid = false;
    self.fetchPerson = nil;

    self.fetchX = self.sprite.width;
    self.fetchY = self.sprite.height - 20;
    self.startLayer = 0;
    self.fetchReady = false;
    self.doSpinning = false;
    self.physics.friction = 0.1;
    self.sprite.alpha = 0;

    --self:setLayer(1000);
end



function Aimbone:update()
    super.update(self)
    self.textSiner = self.textSiner + 1 * DTMULT;
    if (self.mainBone.fetchPerson ~= nil)
        then
        if (self.sprite.alpha < 1) then self.sprite.alpha = self.sprite.alpha + 0.05 * DTMULT; end
        else
        if (self.sprite.alpha > 0) then self.sprite.alpha = self.sprite.alpha - 0.10 * DTMULT; end
        end

end

function Aimbone:draw()
    super.draw(self)
    --love.graphics.draw(boneSprite, 0, 0, 0, 1, 1)
    --love.graphics.draw(boneReady, -10, -10, 0, 2, 2)
    --self.collider:draw()
        -- self.x = self.x + 5
--    love.graphics.printf({{1.0, 1.0, 1.0, 1.0}, "var: " .. Utils.dump(self.doSpinning)}, 0, 0, 100, "center", 0, 1.0, 1.0, 0.0, 0.0)
end

return Aimbone

local Loneparade, super = Class(Object)

local moveSpeed = 1.0; -- voids didnt exist in 2.5 maybe?


-- weaker -- local pillarX = 0
-- weaker -- local pillarY = -1
-- weaker -- local pillarSpeed = 2-- * moveSpeed
-- weaker -- local pillarSprite = Assets.getTexture("pillar")
-- weaker -- local pillarSpriteWidth = 34
-- weaker -- 
-- weaker -- local roadX = 0
-- weaker -- local roadY = 0
-- weaker -- local roadSpeed = 4 * moveSpeed
-- weaker -- local roadSprite = Assets.getTexture("none")
-- weaker -- local roadSpriteWidth = 640
-- weaker -- 
-- weaker -- local fenceX = 640 -- mid fence
-- weaker -- local fenceY = 34
-- weaker -- local fenceSpeed = 4 * moveSpeed
-- weaker -- local fenceSprite = Assets.getTexture("fence")
-- weaker -- local fenceSpriteWidth = 40
-- weaker -- 
-- weaker -- local fence2X = 640 -- top fence
-- weaker -- local fence2Y = 27
-- weaker -- local fence2Speed = 3 * moveSpeed
-- weaker -- local fence2Sprite = Assets.getTexture("fence2")
-- weaker -- local fence2SpriteWidth = 40
-- weaker -- 
-- weaker -- local fence3X = 640 -- bottom fence
-- weaker -- local fence3Y = 27
-- weaker -- local fence3Speed = 4 * moveSpeed
-- weaker -- local fence3Sprite = Assets.getTexture("fence")
-- weaker -- local fence3SpriteWidth = 40

local floatSprite = Assets.getTexture("float")

local floatHalfWidth = 300 / 2 / 2;
local floatHalfHeight = 400 / 2 / 2;

local floatSprite2 = Assets.getTexture("float")
local floatSprite2OffsetX = 0
local floatSprite2Alpha = 0
local maskaughtFlightLifetime = 0
local maskaughtGroundLifetime = 0

local paradeLifetime = 0
local maskaughtAnim = ""
local pfloat = Sprite("float")

local addParadeX = 700;


function Loneparade:init(x, y)
    super.init(self, x, y)
    self.floatSpriteOffsetX = 0;
    self.floatSprite2OffsetX = 0;
    self.floatSprite2Alpha = 1;
    self.maskaughtFlightLifetime = 0
    self.maskaughtGroundLifetime = 0
    self.moveMult = 1;
    self.moveMult2 = 1;

    self.timer = Timer();
    self:addChild(self.timer);

    self:setScale(2, 2);

    self.spritePillar = Sprite("pillar");
    self:addChild(self.spritePillar);
    self.spritePillar:setLayer(self.layer + 0.02);
    self.spritePillar.wrap_texture_x = true;
    

    self.spriteRoad = Sprite("none");
    self:addChild(self.spriteRoad);
    self.spriteRoad:setLayer(self.layer + 0.01);
    self.spriteRoad.wrap_texture_x = true;
    

    self.spriteFenceTop = Sprite("fencetop");
    self.spriteFenceTop.y = (28) / 2;
    self:addChild(self.spriteFenceTop);
    self.spriteFenceTop:setLayer(self.layer + 0.03);
    self.spriteFenceTop.wrap_texture_x = true;
    self.spriteFenceTop.alpha = 0.0;

    self.spriteFenceMid = Sprite("fencemid");
    self.spriteFenceMid.y = (34 / 2);
    self:addChild(self.spriteFenceMid);
    self.spriteFenceMid:setLayer(self.layer + 0.04);
    self.spriteFenceMid.wrap_texture_x = true;
    self.spriteFenceMid.alpha = 0.0;
    

    self.spriteFenceBot = Sprite("fencemid");
    self.spriteFenceBot.y = (28 / 2) + (264 / 2);
    self:addChild(self.spriteFenceBot);
    self.spriteFenceBot:setLayer(self.layer + 0.04);
    self.spriteFenceBot.wrap_texture_x = true;
    self.spriteFenceBot.alpha = 0.0;
    


    self.spriteFloat = Sprite("float");
    self.spriteFloat.y = -10 + 35;
    self:addChild(self.spriteFloat);
    self.spriteFloat:setLayer(self.layer + 2);
    self.spriteFloat.wrap_texture_x = false;
    

    self.floatX = -190; -- safe is 40
    

    self.alpha = 0;

    self.removeChildFences = false;

    --self.spritePillar:setScale(2, 2);

    --nvm-- pfloat = Sprite("float2")
    --nvm-- pfloat.layer = -100
    --nvm-- Game.battle:addChild(pfloat)
    --nvm-- 
    --nvm-- local mask = Sprite("floatmask")
    --nvm-- pfloat:addChild(mask)
    --nvm-- pfloat.mask = mask
    --nvm-- pfloat.mask.layer = -10
    --nvm-- pfloat.mask.visible = false
    --nvm-- pfloat.mask.origin_x = 0
    --nvm-- pfloat.mask.origin_y = 0
    --nvm-- pfloat.mask.x = 0
    --nvm-- pfloat.mask.y = 0
    --nvm-- 
    --nvm-- local bg = Sprite("otherdraw")
    --nvm-- pfloat:addChild(bg)
    --nvm-- pfloat.bg = bg
    --nvm-- pfloat.bg.layer = -1
    --nvm-- pfloat.bg.scale_x = 0.1
    --nvm-- pfloat.bg.scale_y = 0.1
    --nvm-- pfloat.bg.origin_x = 0.5
    --nvm-- pfloat.bg.origin_y = 0.5
    --nvm-- pfloat.bg.x = 0
    --nvm-- pfloat.bg.y = 0
    --nvm-- pfloat.bg.wrap_texture_x = true
    --nvm-- pfloat.bg.wrap_texture_y = true
    --nvm-- pfloat.bg.mask_fx = bg:addFX(MaskFX(mask))
    
    
    -- Kristal.Console:log("initiated")
end

function Loneparade:startMove()
    self.spritePillar.physics.speed = -0.5;
    self.spriteRoad.physics.speed = -2.0;
    self.spriteFenceTop.physics.speed = -1.2;
    self.spriteFenceMid.physics.speed = -2.0;
    self.spriteFenceBot.physics.speed = -2.0;
    self.spriteFloat.physics.speed = 0;
end

function Loneparade:stopMove()
    self.spritePillar.physics.friction = self.spritePillar.physics.speed / -10;
    self.spriteRoad.physics.friction = self.spriteRoad.physics.speed / -10;
    self.spriteFenceTop.physics.friction = self.spriteFenceTop.physics.speed / -10;
    self.spriteFenceMid.physics.friction = self.spriteFenceMid.physics.speed / -10;
    self.spriteFenceBot.physics.friction = self.spriteFenceBot.physics.speed / -10;
    self.spriteFloat.physics.friction = self.spriteFloat.physics.speed / -10;
end

function Loneparade:update()
    super.update(self)

    self.spriteFloat.alpha = self.alpha;
    --self.spriteFenceBot.alpha = self.alpha;
    --self.spriteFenceMid.alpha = self.alpha;
    --self.spriteFenceTop.alpha = self.alpha;
    self.spritePillar.alpha = self.alpha;
    self.spriteRoad.alpha = self.alpha;
   -- weaker -- roadX = roadX - (roadSpeed * self.moveMult * self.moveMult2 * DTMULT) - addParadeX;
   -- weaker -- fenceX = fenceX - (fenceSpeed * self.moveMult * self.moveMult2 * DTMULT) - addParadeX;
   -- weaker -- fence2X = fence2X - (fence2Speed * self.moveMult * self.moveMult2 * DTMULT) - addParadeX;
   -- weaker -- fence3X = fence3X - (fence3Speed * self.moveMult * self.moveMult2 * DTMULT) - addParadeX;
   -- weaker -- pillarX = pillarX - (pillarSpeed * self.moveMult * self.moveMult2 * DTMULT);
    if (addParadeX ~= 0) then addParadeX = 0; end
    paradeLifetime = paradeLifetime + 1 * DTMULT;
    self.spriteFloat.x = -10 + (math.cos(paradeLifetime / 20) * 2) + self.floatX;
    -- Kristal.Console:log("updating")
end

function Loneparade:spawnFences()

    
    for i = 0,18,1 
    do
        local newFence = FenceDrop(0 + (i * 20), self.spriteFenceTop.y, 540 + (i * 30), 0.2 + (i * 0.08), "fencetop");
        newFence:setLayer(self.spriteFloat.layer + 5);
        self:addChild(newFence);
    end 
    self.timer:after(0.7,
            function() 
                for i = 0,18,1 
                do
                    local newFence = FenceDrop(0 + (i * 20), self.spriteFenceMid.y, 540 + (i * 30), 0.4 + (i * 0.08), "fencemid");
                    newFence:setLayer(self.spriteFloat.layer + 5);
                    self:addChild(newFence);
                end 
                self.timer:after(1.0,
                    function() 
                    for i = 0,18,1 
                    do
                        local newFence = FenceDrop(0 + (i * 20), self.spriteFenceBot.y, -540 - (i * 30), 0.5 + (i * 0.08), "fencebot");
                        newFence:setLayer(self.spriteFloat.layer + 50);
                        self:addChild(newFence);
                    end 

                    end);
                end);


    



end

function Loneparade:changeFences()
    self.removeChildFences = true;
    self.spriteFenceTop.alpha = 1.0;
    self.spriteFenceMid.alpha = 1.0;
    self.spriteFenceBot.alpha = 1.0;
end

function Loneparade:draw()

    

    
    --ughh too much-- -- Kristal.Console:log("drawing")
    --ughh too much-- --doesn't even use enemy float anymore-- local maskaughts = Game.battle:getActiveEnemies()
    --ughh too much-- --doesn't even use enemy float anymore-- local targetMaskaught = nil;
    --ughh too much-- --doesn't even use enemy float anymore-- for _, maskaught in ipairs(maskaughts)
    --ughh too much-- --doesn't even use enemy float anymore--     do
    --ughh too much-- --doesn't even use enemy float anymore--     -- Kristal.Console:log(tostring(maskaught.sprite.anim))
    --ughh too much-- --doesn't even use enemy float anymore--     self.maskaughtAnim = maskaught.sprite.anim
    --ughh too much-- --doesn't even use enemy float anymore--     targetMaskaught = maskaught;
    --ughh too much-- --doesn't even use enemy float anymore--     end
    --ughh too much-- --doesn't even use enemy float anymore-- if (targetMaskaught ~= nil)
    --ughh too much-- --doesn't even use enemy float anymore--     then
    --ughh too much-- --doesn't even use enemy float anymore--     if (targetMaskaught.unveiled == true)
    --ughh too much-- --doesn't even use enemy float anymore--         then
    --ughh too much-- --doesn't even use enemy float anymore--         self.moveMult = Utils.approach(self.moveMult, 0, 0.01);
    --ughh too much-- --doesn't even use enemy float anymore--         if (targetMaskaught.paradefloatMoveX ~= 0)
    --ughh too much-- --doesn't even use enemy float anymore--             then
    --ughh too much-- --doesn't even use enemy float anymore--             self.floatSpriteOffsetX = self.floatSpriteOffsetX + targetMaskaught.paradefloatMoveX;
    --ughh too much-- --doesn't even use enemy float anymore--             end
    --ughh too much-- --doesn't even use enemy float anymore--         end
    --ughh too much-- --doesn't even use enemy float anymore--     end
    --ughh too much--     -- if (targetMaskaught.sprite.detachCount ~= nil and targetMaskaught.sprite.detachCount > 0) then self.moveMult2 = 0; else self.moveMult2 = 1; end
    --ughh too much--     -- original -- if (self.maskaughtAnim ~= "idle" and self.maskaughtAnim ~= "unswirlquick" and self.maskaughtAnim ~= "raise" and self.maskaughtAnim ~= "spared" and self.maskaughtAnim ~= "unveilstay" and targetMaskaught.actor ~= "MaskaughtBattle") 
    --ughh too much-- -- nvm --if (self.maskaughtAnim ~= "unswirlquick" and self.maskaughtAnim ~= "unveilstay" and targetMaskaught.actor ~= "MaskaughtBattle") -- float still disappears on 100% mercy??
    --ughh too much-- -- nvm --    then
    --ughh too much-- -- nvm --    if (targetMaskaught ~= nil) then targetMaskaught.onAir = true; end;
    --ughh too much-- -- nvm --    self.maskaughtGroundLifetime = 0
    --ughh too much-- -- nvm --    self.maskaughtFlightLifetime = self.maskaughtFlightLifetime + 1
    --ughh too much-- -- nvm --    self.floatSprite2OffsetX = Utils.ease(self.floatSprite2OffsetX, 30, self.maskaughtFlightLifetime / 50, "in-out-quad")
    --ughh too much-- -- nvm --    self.floatSprite2Alpha = Utils.ease(self.floatSprite2Alpha, 0, self.maskaughtFlightLifetime / 50, "in-out-quad")
    --ughh too much-- -- nvm --    else
    --ughh too much-- -- nvm --    if (targetMaskaught ~= nil) then targetMaskaught.onAir = false; end;
    --ughh too much-- -- nvm --    self.maskaughtGroundLifetime = self.maskaughtGroundLifetime + 1
    --ughh too much-- -- nvm --    self.maskaughtFlightLifetime = 0
    --ughh too much-- -- nvm --    self.floatSprite2OffsetX = Utils.ease(30, 0, self.maskaughtGroundLifetime / 25, "in-out-quad")
    --ughh too much-- -- nvm --    self.floatSprite2Alpha = Utils.ease(0, 1, self.maskaughtGroundLifetime / 25, "in-out-quad")
    --ughh too much-- -- nvm --    end
    --ughh too much-- if (roadX <= -roadSpriteWidth - roadSpeed  * self.moveMult ) then roadX = roadX + roadSpriteWidth end
    --ughh too much--             -- local spritename = Assets.getTexture("none") -- relative to sprite 
    --ughh too much-- love.graphics.draw(roadSprite, roadX, roadY, 0, 2, 2)
    --ughh too much-- love.graphics.draw(roadSprite, roadX + roadSpriteWidth, roadY, 0, 2
    --ughh too much-- , 2)
    --ughh too much-- 
    --ughh too much-- 
    --ughh too much-- --nvm-- pfloat.alpha = self.floatSprite2Alpha
    --ughh too much-- --nvm-- pfloat.bg.alpha = pfloat.alpha
    --ughh too much-- --nvm-- pfloat.mask.alpha = pfloat.alpha
    --ughh too much-- --nvm-- pfloat.x = Utils.round(440 + self.floatSprite2OffsetX + math.cos((paradeLifetime + 120) / 30) * 5);
    --ughh too much-- --nvm-- pfloat.y = 100
    --ughh too much-- --nvm-- pfloat.bg.x = pfloat.bg.x + 2
    --ughh too much-- --nvm-- pfloat.bg.y = pfloat.bg.y + 1
    --ughh too much-- -- love.graphics.draw(floatSprite2, 440 + self.floatSprite2OffsetX + math.cos((paradeLifetime + 120) / 30) * 5, 100, 0, 1, 1)
    --ughh too much-- 
    --ughh too much-- --weaker--if (pillarX <= -pillarSpriteWidth - pillarSpeed  * self.moveMult ) then pillarX = pillarX + pillarSpriteWidth end
    --ughh too much-- --weaker--for i = 0,20,1 
    --ughh too much-- --weaker--do
    --ughh too much-- --weaker--love.graphics.draw(pillarSprite, pillarX + (pillarSpriteWidth * i), pillarY, 0, 2, 2)
    --ughh too much-- --weaker--end 
    --ughh too much-- love.graphics.draw(pillarSprite, pillarX + (pillarSpriteWidth * 1), pillarY, 0, 2, 2)
    --ughh too much-- 
    --ughh too much-- if (fence2X <= -fence2SpriteWidth - fence2Speed  * self.moveMult ) then fence2X = fence2X + fence2SpriteWidth end
    --ughh too much-- for i = 0,18,1 
    --ughh too much-- do
    --ughh too much-- love.graphics.draw(fence2Sprite, fence2X + (fence2SpriteWidth * i), fence2Y, 0, 2, 2)
    --ughh too much-- end 
    --ughh too much-- 
    --ughh too much-- if (fenceX <= -fenceSpriteWidth - fenceSpeed  * self.moveMult ) then fenceX = fenceX + fenceSpriteWidth end
    --ughh too much-- for i = 0,18,1 
    --ughh too much-- do
    --ughh too much-- love.graphics.draw(fenceSprite, fenceX + (fenceSpriteWidth * i), fenceY, 0, 2, 2)
    --ughh too much-- -- love.graphics.draw(fence3Sprite, fenceX + (fenceSpriteWidth * i), fenceY + 256, 0, 1, 1)
    --ughh too much-- end 
    --ughh too much-- 
    --ughh too much-- if (fence3X <= -fence3SpriteWidth - fence3Speed  * self.moveMult ) then fence3X = fence3X + fence3SpriteWidth end
    --ughh too much-- for i = 0,18,1 
    --ughh too much-- do
    --ughh too much-- love.graphics.draw(fence3Sprite, fence3X + (fence3SpriteWidth * i), fence3Y + 263, 0, 2, 2)
    --ughh too much-- end 
    --ughh too much-- 
    --ughh too much-- 
    --ughh too much-- love.graphics.draw(floatSprite, 50 + math.cos(paradeLifetime / 30) * 5 + self.floatSpriteOffsetX - floatHalfWidth, 80 - floatHalfHeight, 0, 2, 2)




    super.draw(self)
    
    
    -- self.x = self.x + 5
end

return Loneparade

local MaskaughtCombatActor, super = Class(ActorSprite)


function MaskaughtCombatActor:init(actor)
    super:init(self, actor)
    -- self.x = actor.x;

    self.addMainX = 20;
    self.addMainY = 10;

    self.shieldSprite = Sprite("dustshield");
    self.shieldSprite:setAnimation({"dustshield", 0.2, true});
    self:addChild(self.shieldSprite);
    self.shieldSprite.x = -20;
    self.shieldSprite.y = -10;
    self.shieldSprite.alpha = 0;

    self.maskaughtHead = self:SpawnPart("enemies/MaskaughtCombat/head", "head"); 
    self.maskaughtBody = self:SpawnPart("enemies/MaskaughtCombat/body", "body"); 
 
    self.schoolNote = "'My right is actually your left. Isn't that confusing?'"

    self.maskaughtArmleft = self:SpawnPart("enemies/MaskaughtCombat/armface", "armfront"); 
    self.maskaughtArmright = self:SpawnPart("enemies/MaskaughtCombat/armdog", "armback"); 

    self.maskaughtTail = self:SpawnPart("enemies/MaskaughtCombat/tail", "tail"); 

    

    self.maskaughtLegleft = self:SpawnPart("enemies/MaskaughtCombat/legfront", "legfront"); 
    self.maskaughtLegright = self:SpawnPart("enemies/MaskaughtCombat/legback", "legback"); 
    --self.maskaughtCollar = self:SpawnPart("enemies/MaskaughtCombat/legback", "legback"); 
    self.maskaughtAnimState = "IDLE";
    
    self.animTime = 0;

    self.detachCount = 0;
    
    self.raiseTime = 0;
    self.raiseDuration = 0;
    self.pillarTime = 0;

    self.speedMultiplier = 0.5;
    self.addHeadY = 0;
    
    
    self.maskaughtParts = 
    {
        self.maskaughtHead,
        self.maskaughtBody,
        self.maskaughtArmleft,
        self.maskaughtArmright,
        self.maskaughtTail,
        self.maskaughtLegleft,
        self.maskaughtLegright
    };
    
    

    self.timer = Timer();
    self:addChild(self.timer);
    self.timer:every(1/30 * self.speedMultiplier, function()
-----------------------------------------------------------------------------------   
--Kristal.Console:log(self.detachCount);
-- selfreminder: set to startX/startY if you want to put part to original spot
local attachSpeed = 30;
local attachFancy = "in-quad";
if (self.theMaskaught == nil) then self.theMaskaught = Game.battle:getEnemyBattler("maskaught"); end
if (self.theMaskaught ~= nil and self.theMaskaught.dustCount > 0 and Game.battle.state ~= "DEFENDING")
        then
        if (self.shieldSprite.alpha <= 0) then self.shieldSprite:shake(0, 20); end
        if (self.shieldSprite.alpha < 1) then self.shieldSprite.alpha = self.shieldSprite.alpha + 0.02; end
        else
        if (self.shieldSprite.alpha >= 1) then self.shieldSprite:shake(0, 20); end
        if (self.shieldSprite.alpha > 0) then self.shieldSprite.alpha = self.shieldSprite.alpha - 0.02; end
        end
for _, mPart in ipairs(self.maskaughtParts)
    do
    self.animTime = self.animTime + 1 * self.speedMultiplier; -- this is still running
    if (mPart.moveX < 0)
        then
        if (mPart.moveXTracker >= -80)
            then -- moves towards left when hit
            
            mPart.x = mPart.x + mPart.moveX;
            mPart.moveXTracker = mPart.moveXTracker + mPart.moveX;
            mPart.y = mPart.y + mPart.moveY;
            mPart.rotation = mPart.rotation + mPart.moveRotation;
            -- mPart:shake(5);
            else -- left far enough
            if (mPart.isHurting == true)
                then
                mPart.hurtRotation = mPart.rotation;
                mPart.hurtX = mPart.x;
                mPart.hurtY = mPart.y;
                mPart.hurtRotationOriginX = mPart.rotation_origin_x;
                mPart.hurtRotationOriginY = mPart.rotation_origin_y;
                mPart.hurtOriginX = mPart.origin_x;
                mPart.hurtOriginY = mPart.origin_y;
                -- mPart:shake(5);
                mPart.isHurting = false;
                end
             mPart.attachTime = mPart.attachTime + 1 * self.speedMultiplier;
             mPart.rotation = Utils.ease(mPart.hurtRotation, 0, mPart.attachTime / attachSpeed, attachFancy);
             mPart:setRotationOrigin(Utils.ease(mPart.hurtRotationOriginX, mPart.startOrigin_x, mPart.attachTime / attachSpeed, attachFancy), Utils.ease(mPart.hurtRotationOriginY, mPart.startOrigin_y, mPart.attachTime / attachSpeed, attachFancy));
             mPart:setOrigin(Utils.ease(mPart.hurtOriginX, mPart.startOrigin_x, mPart.attachTime / attachSpeed, attachFancy), Utils.ease(mPart.hurtOriginY, mPart.startOrigin_y, mPart.attachTime / attachSpeed, attachFancy));
             mPart.x = Utils.ease(mPart.hurtX, mPart.startX, mPart.attachTime / attachSpeed, attachFancy);
             mPart.y = Utils.ease(mPart.hurtY, mPart.startY, mPart.attachTime / attachSpeed, attachFancy);
             if (mPart.x == mPart.startX)
                 then
                 self:ResetPart(mPart);
                 mPart:shake(3);
                 Assets.playSound("darkgrabweakest");
                 self.detachCount = self.detachCount - 1;
                 if (self.detachCount <= 0) then self:SetState("IDLE"); end
                 end
             end
        end
    if (self.detachCount > 0)
        then
            if (mPart.partLabel == "head")
                then
                mPart:setSprite("enemies/MaskaughtCombat/headblink", 0);
                else

                end
        else -- if not detached
            if (mPart.partLabel == "head" and (self.theMaskaught == nil or (self.theMaskaught ~= nil and self.theMaskaught.unveiled == false))  )
                then
                if (Game.battle.state == "DEFENDINGBEGIN")
                    then
                    --mPart:setSprite("enemies/MaskaughtCombat/headforward", true);
                    mPart:setAnimation({"enemies/MaskaughtCombat/headforward", 0.1, false, frames = {1, 1, 2, 3} })
                    end
                if (Game.battle.state == "DEFENDINGEND")
                    then
                    mPart:setAnimation({"enemies/MaskaughtCombat/headforward", 0.1, false, frames = {3, 3, 2, 1} })
                    --mPart:setSprite("enemies/MaskaughtCombat/head", 0);
                    end
                end
        end
    if (self.maskaughtAnimState == "IDLE")
        then
        self.x = 1 * math.sin(self.animTime / 50);
        if (mPart.partLabel == "body")
            then
            mPart.rotation = math.rad(12) * math.sin(self.animTime / 50 * 2);
            self.maskaughtHead.x = mPart.x + (math.sin(mPart.rotation) * 4);
            self.maskaughtHead.y = self.maskaughtHead.startY + (math.sin(mPart.rotation) * -2) + self.addHeadY;
            end

        if (mPart.partLabel == "armfront")
            then
            mPart.rotation = math.rad(8) * math.sin(self.animTime / 70); -- used to be 15 degrees
            if (self.raiseTime == 0 and self.maskaughtArmleft.startSprite ~= "enemies/MaskaughtCombat/armraise_3") then self:PartSet(self.maskaughtArmleft, "enemies/MaskaughtCombat/armraise_1"); end
            if (self.raiseTime > 0 and self.raiseDuration > 0)
                then -- for lobera attacks
                self.raiseTime = self.raiseTime - 1 * self.speedMultiplier;
                if (self.raiseTime <= self.raiseDuration) then self:PartSet(self.maskaughtArmleft, "enemies/MaskaughtCombat/armraise_1"); end
                if (self.raiseTime <= 3) then self:PartSet(self.maskaughtArmleft, "enemies/MaskaughtCombat/armraise_2"); end
                if (self.raiseTime == 0) then self:PartSet(self.maskaughtArmleft, "enemies/MaskaughtCombat/armraise_3"); end
                else -- if not in lobera attack
                if (self.raiseDuration <= 0) then self:PartSet(self.maskaughtArmleft, "enemies/MaskaughtCombat/armface"); end
                end
            end

        if (mPart.partLabel == "armback")
            then
            mPart.rotation = math.rad(5) + math.rad(-5) * math.sin(self.animTime / 50);
            if (self.raiseDuration > 0)
                then
                self:PartSet(self.maskaughtArmright, "enemies/MaskaughtCombat/armhide");
                else
                self:PartSet(self.maskaughtArmright, "enemies/MaskaughtCombat/armdog");
                end
            if (self.pillarTime > 0)
                then
                self.pillarTime = self.pillarTime - 1 * self.speedMultiplier;
                self:PartSet(self.maskaughtArmright, "enemies/MaskaughtCombat/armdown");
                end
            end

        if (mPart.partLabel == "tail")
            then
            mPart.rotation = math.rad(20) * math.sin(self.animTime / 50 / 2);
            mPart.x = self.maskaughtBody.x + mPart.firstX;
            end

        local legSpeed = 50;
        local legCos = math.cos(self.animTime / legSpeed);
        local legCos2 = legCos * -1;
        local legSinFront = math.sin(self.animTime / legSpeed);
        local legSinBack = legSinFront * -1;
        local legDistance = 3;
        if (mPart.partLabel == "legfront")
            then
            --mPart.rotation = math.rad(25) * legSinFront;
            mPart.x = self.maskaughtBody.x + legDistance * legSinFront + mPart.firstX;
            if (1 == 1)
                then
                if (-1 < legCos and legCos < 0.5) then mPart:setSprite("enemies/MaskaughtCombat/legnormal", 0, false); end
                if (0 < legCos and legCos < 0.5) then mPart:setSprite("enemies/MaskaughtCombat/legback", 0, false); end
                if (0.5 < legCos and legCos < 1) then mPart:setSprite("enemies/MaskaughtCombat/legbacker", 0, false); end
                end
            end
        if (mPart.partLabel == "legback")
            then
            if (1 == 1)
                then
                --mPart.rotation = math.rad(20) * legSinBack;
                mPart.x = self.maskaughtBody.x + legDistance * legSinBack + mPart.firstX;
                if (-1 < legCos2 and legCos2 < 0.5) then mPart:setSprite("enemies/MaskaughtCombat/legnormal", 0, false); end
                if (0 < legCos2 and legCos2 < 0.5) then mPart:setSprite("enemies/MaskaughtCombat/legback", 0, false); end
                if (0.5 < legCos2 and legCos2 < 1) then mPart:setSprite("enemies/MaskaughtCombat/legbacker", 0, false); end
                end
            end
        
            
       end

    end

                    -- Kristal.Console:log("sss");
-----------------------------------------------------------------------------------  
                end)

end

function MaskaughtCombatActor:draw()
    
    Draw.setColor(0.63, 0,38, 0.76)
    love.graphics.setLineWidth(1);
    love.graphics.line(self.maskaughtArmleft.x, self.maskaughtArmleft.y, self.maskaughtBody.x, self.maskaughtBody.y);
    love.graphics.line(self.maskaughtArmright.x - 4, self.maskaughtArmright.y, self.maskaughtBody.x, self.maskaughtBody.y);
    love.graphics.line(self.maskaughtLegleft.x, self.maskaughtLegleft.y, self.maskaughtBody.x, self.maskaughtBody.y);
    love.graphics.line(self.maskaughtLegright.x, self.maskaughtLegright.y, self.maskaughtBody.x, self.maskaughtBody.y);
    super.draw(self)
end

function MaskaughtCombatActor:ResetPart(thePart)
    thePart:setSprite(thePart.startSprite, 0);
    thePart.moveX = 0;
    thePart.moveY = 0;
    thePart.moveRotation = 0;
    thePart.moveXTracker = 0;
    thePart.rotation = 0;

    thePart.attachTime = 0;
    thePart.hurtRotation = 0;
    thePart.hurtX = 0;
    thePart.hurtY = 0;
    thePart.hurtOriginX = 0;
    thePart.hurtOriginY = 0;
    thePart.hurtRotationOriginX = 0;
    thePart.hurtRotationOriginY = 0;

    thePart.x = thePart.startX
    thePart.y = thePart.startY;
    thePart:setOrigin(thePart.startOrigin_x, thePart.startOrigin_y);
    thePart:setRotationOrigin(thePart.startOrigin_x, thePart.startOrigin_y);
    
end

function MaskaughtCombatActor:SetState(stateName)
    local newState = (self.maskaughtAnimState == stateName);
    self.maskaughtAnimState = stateName;
    
    if (newState) then self.animTime = 0; end
    -- Kristal.Console:log("setted state " .. self.maskaughtAnimState);
    local doomedPart = Utils.pick({"legfront", "legback"});
    local hasDetached = false;
    for _, mPart in ipairs(self.maskaughtParts)
    do
    if (stateName == "IDLE")
        then -- below is: IDLE
        self:ResetPart(mPart);
        end
    if (stateName == "HURT")
        then -- below is: HURT
        local willDetach = false;
        if (self.maskaughtArmleft.moveX == 0)
            then
            if (mPart.partLabel == "armfront") then willDetach = true; end
            end
        if (self.maskaughtArmright.moveX == 0 and self.maskaughtArmleft.moveX ~= 0)
            then
            if (mPart.partLabel == "armback") then willDetach = true; end
            end
        if (self.maskaughtArmright.moveX ~= 0 and self.maskaughtArmleft.moveX ~= 0)
            then
            if (mPart.partLabel == doomedPart) then willDetach = true; end
            end
        if (willDetach == true and hasDetached == false)
            then
            hasDetached = true;
            mPart.moveX = love.math.random(-6, -6) * self.speedMultiplier;
            mPart.moveY = love.math.random(0.5, 3.0) * Utils.randomSign() * self.speedMultiplier;
            mPart:setRotationOrigin(0.5, 0.5);
            mPart:setOrigin(0.5, 0.5);
            mPart.moveRotation = math.rad(love.math.random(12, 16) * Utils.randomSign() * self.speedMultiplier);
            mPart.isHurting = true;
            self.detachCount = self.detachCount + 1;
            end
        end
    end
    -- Kristal.Console:log("after state " .. self.maskaughtAnimState);
end
function MaskaughtCombatActor:PartInfo(partSprite)

 --   self.maskaughtHead = self:SpawnPart("enemies/MaskaughtCombat/head", "head", 0, 0, 0.5, 0.5, 30, nil); 
 --   self.maskaughtBody = self:SpawnPart("enemies/MaskaughtCombat/body", "body", 0, 15, 0.5, 0.5, 28, nil); 
 --
 --   self.maskaughtArmleft = self:SpawnPart("enemies/MaskaughtCombat/armhigh", "armfront", -4,  -4, 1.0, 0.75, 24, self.maskaughtBody); 
 --   self.maskaughtArmright = self:SpawnPart("enemies/MaskaughtCombat/armcheek", "armback", 8, 0, 1.0, 0.75, 34, self.maskaughtBody); 
 --
 --   self.maskaughtTail = self:SpawnPart("enemies/MaskaughtCombat/tail", "tail", 4, 6, 0.0, 0.5, 20, self.maskaughtBody); 
 --
 --
 --   self.maskaughtLegleft = self:SpawnPart("enemies/MaskaughtCombat/legfront", "legfront", -2, 7, 0.5, 0, 2, self.maskaughtBody); 
 --   self.maskaughtLegright = self:SpawnPart("enemies/MaskaughtCombat/legback", "legback", -2, 7, 0.5, 0, 4, self.maskaughtBody); 

    local returnValue = {addX = 0, addY = 0, originX = 0, originY = 0, addLayer = 0, connectTo = nil};

    if (partSprite == "enemies/MaskaughtCombat/head") then returnValue = {addX = 0, addY = 0, originX = 0.5, originY = 0.5, addLayer = 30, connectTo = nil}; end
    if (partSprite == "enemies/MaskaughtCombat/body") then returnValue = {addX = 0, addY = 16, originX = 0.5, originY = 0.5, addLayer = 28, connectTo = nil}; end

    if (partSprite == "enemies/MaskaughtCombat/armhigh") then returnValue = {addX = -4, addY = -4, originX = 1.0, originY = 0.75, addLayer = 24, connectTo = self.maskaughtBody}; end
    if (partSprite == "enemies/MaskaughtCombat/armface") then returnValue = {addX = -4, addY = -4, originX = 1.0, originY = 0.75, addLayer = 24, connectTo = self.maskaughtBody}; end

    if (partSprite == "enemies/MaskaughtCombat/armraise_1") then returnValue = {addX = -4, addY = -4, originX = 0.5, originY = 0.7, addLayer = 60, connectTo = self.maskaughtBody}; end
    if (partSprite == "enemies/MaskaughtCombat/armraise_2") then returnValue = {addX = -4, addY = -4, originX = 0.5, originY = 0.7, addLayer = 60, connectTo = self.maskaughtBody}; end
    if (partSprite == "enemies/MaskaughtCombat/armraise_3") then returnValue = {addX = -4, addY = -4, originX = 0.5, originY = 0.7, addLayer = 24, connectTo = self.maskaughtBody}; end


    if (partSprite == "enemies/MaskaughtCombat/armcheek") then returnValue = {addX = 10, addY = 0, originX = 1.0, originY = 0.75, addLayer = 34, connectTo = self.maskaughtBody}; end
    if (partSprite == "enemies/MaskaughtCombat/armdog") then returnValue = {addX = 7, addY = 0, originX = 1.0, originY = 0.75, addLayer = 34, connectTo = self.maskaughtBody}; end
    
    if (partSprite == "enemies/MaskaughtCombat/armdown") then returnValue = {addX = 6, addY = 4, originX = 0.6, originY = 0.35, addLayer = 25, connectTo = self.maskaughtBody}; end

    if (partSprite == "enemies/MaskaughtCombat/armhide") then returnValue = {addX = 8, addY = 0, originX = 0.7, originY = 0.75, addLayer = 10, connectTo = self.maskaughtBody}; end

    if (partSprite == "enemies/MaskaughtCombat/tail") then returnValue = {addX = 2, addY = 6, originX = 0.0, originY = 0.5, addLayer = 3, connectTo = self.maskaughtBody}; end

    if (partSprite == "enemies/MaskaughtCombat/legfront") then returnValue = {addX = -3, addY = 8, originX = 0.5, originY = 0.0, addLayer = 2, connectTo = self.maskaughtBody}; end
    if (partSprite == "enemies/MaskaughtCombat/legback") then returnValue = {addX = -3, addY = 8, originX = 0.5, originY = 0, addLayer = 4, connectTo = self.maskaughtBody}; end


    return returnValue
end
function MaskaughtCombatActor:PartSet(thePart, spritePath)
    if (spritePath == thePart.startSprite) then return end
--    if (spritePath == thePart.path) then return end
    -- Kristal.Console:log("sss");
    local partInfo = self:PartInfo(spritePath);
    thePart:setSprite(spritePath, 0);
    thePart:setOrigin(partInfo.originX, partInfo.originY);
    thePart:setScaleOrigin(partInfo.originX, partInfo.originY);
    thePart:setRotationOrigin(partInfo.originX, partInfo.originY);
    thePart:setLayer(partInfo.addLayer);
    thePart.animSpeed = 12;
    thePart.moveX = 0;
    thePart.moveY = 0;
    thePart.moveRotation = 0;
    thePart.startX = thePart.x;
    thePart.startY = thePart.y;
    -- thePart.firstX = firstX;
    -- thePart.firstY = firstY;
    thePart.moveXTracker = 0;
    thePart.startSprite = spritePath;
    thePart.startOrigin_x = partInfo.originX;
    thePart.startOrigin_y = partInfo.originY;
    thePart.startLayer = thePart.layer;
    thePart.isHurting = false;
    thePart.attachTime = 0;
    thePart.hurtRotation = 0;
    thePart.hurtX = 0;
    thePart.hurtY = 0;
    thePart.hurtOriginX = 0;
    thePart.hurtOriginY = 0;
    thePart.hurtRotationOriginX = 0;
    thePart.hurtRotationOriginY = 0;
    --Kristal.Console:log("setted");
end
function MaskaughtCombatActor:SpawnPart(spritePath, theLabel)
    
    local partInfo = self:PartInfo(spritePath);
    -- Kristal.Console:log(Utils.dump(partInfo));
    local firstX = partInfo.addX;
    local firstY = partInfo.addY;
    if (partInfo.connectTo ~= nil)
        then
        partInfo.addX = partInfo.addX + partInfo.connectTo.x - self.addMainX;
        partInfo.addY = partInfo.addY + partInfo.connectTo.y - self.addMainY;
        end
    local newPart = Sprite(spritePath, partInfo.addX + self.addMainX, partInfo.addY + self.addMainY);
    newPart.partLabel = theLabel;
    self:addChild(newPart);
    newPart.startSprite = nil;
    self:PartSet(newPart, spritePath);
    newPart.firstX = firstX;
    newPart.firstY = firstY;
    
    return newPart
end




return MaskaughtCombatActor
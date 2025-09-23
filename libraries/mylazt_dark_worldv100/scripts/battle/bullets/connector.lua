local connector, super = Class(Bullet)

-- function connector:onDamage(soul)
-- -- Kristal.Console:log("touched string")
-- self.isShattered = true;
-- if (self.originSword ~= nil)
--     then
--     self.originSword.isBroken = true;
--     end
-- -- self.shakeTimer = 12;
-- super.onDamage(self, soul)
-- end

function connector:init(x, y, dangerLevel)
    -- Last argument = sprite path
    local connectorSprite = "swordline";
    --if (self.attachedThing ~= nil)
    --    then
    --        if (self.originMaskaught ~= nil)
    --        then
    --        connectorSprite = "offline";
    --        end
    --    end
    super.init(self, x, y, connectorSprite)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.damage = 0;
    self.tp = 0;
    self.destroy_on_hit = false;
    --self.sprite:setScaleOrigin(50, 0.5)
    
            -- self.sprite:setOrigin(0.5, 0);
            -- self:setOrigin(0.5, 0.5);
    
    -- -- self.Line1Sprite.lineWidth = 0;
    -- self.sprite:setScale(0, 10);
    -- self.Line1Sprite.x = self.addX;
    -- self.Line1Sprite.y = self.addY;
    -- Game.battle:addChild(self.Line1Sprite);
    -- self.Line1Sprite.layer = self.layer;
    -- self.Line1Sprite.x = -50;
    -- self.Line1Sprite.y = -50;
    self.originSword = nil;
    -- self.Line1Sprite.layer = self.sprite.layer - 1
    self.alpha = 0.75;
    self.sprite:setScaleOrigin(0, 0.5)
    self:setScaleOrigin(0, 0.5)
    self.isShattered = false;
    self.addX = -1;
    self.addY = -1;
    self.initDone = false;
    self.shatterY = 0;
    self.shakeTimer = 0;
    self.shakeAmount = 6;
    self.shakeX = 0;
    self.shakeY = 0;
    self.originMaskaught = nil;
    self.attachedThing = nil;
    self.layer = 495;
    

    -- self.Line1Sprite.rotation = self.Line1Sprite.rotation - self.rotation + (180 * 0.017453);
    -- self:removeChild(self.Line1Sprite);

    
    

end

function connector:update()
    -- For more complicated bullet behaviours, code here gets called every update
    
    if (self.attachedThing ~= nil)
        then
        if (self.originMaskaught ~= nil)
            then
                if (self.originMaskaught.actor.name == "MaskaughtCombat")
                    then

                    local lineDistance = -45;
                    local influenceX = -30; -- math.cos(self.originSword.rotation) * lineDistance;
                    local influenceY = 0; -- math.sin(self.originSword.rotation) * lineDistance;

                    -- if (self.originMaskaught.sprite.frame == 2) then influenceY = influenceY + 4; end
                    -- if (self.originMaskaught.sprite.frame == 3) then influenceY = influenceY + 10; end
                    
                    self.originMaskaught.sprite.pillarTime = 2;
                    influenceX = self.originMaskaught.x; --Game.battle.arena.x + 190; -- -80 + math.cos(self.originMaskaught.sprite.maskaughtArmleft.rotation);
                    influenceY = Game.battle.arena.y + 0;-- 3 - math.sin(self.originMaskaught.sprite.maskaughtArmleft.rotation);
                    
                    self.addX = self.attachedThing.x;
                    self.addY = self.attachedThing.y;
                    if (self.initDone == false) 
                        then
                        self.x = self.addX + self.shakeX;
                        self.y = self.addY + self.shakeY;
                        self.alpha = 0;
                        end
                    if (self.alpha < 0.5) then self.alpha = self.alpha + 0.05; end
                    self.rotation = Utils.angle(self.attachedThing.x, self.attachedThing.y, influenceX, influenceY);
        
                    self.scale_x = Utils.dist(self.attachedThing.x, self.attachedThing.y, influenceX, influenceY) / 2;
                    self.scale_y = 1;
                    
                    else
                    -- Kristal.Console:log("maskaska");
                    local lineDistance = -45;
                    local influenceX = -30; -- math.cos(self.originSword.rotation) * lineDistance;
                    local influenceY = -30; -- math.sin(self.originSword.rotation) * lineDistance;

                    if (self.originMaskaught.sprite.frame == 2) then influenceY = influenceY + 4; end
                    if (self.originMaskaught.sprite.frame == 3) then influenceY = influenceY + 10; end

                    self.addX = self.attachedThing.x;
                    self.addY = self.attachedThing.y;
                    if (self.initDone == false) 
                        then
                        self.x = self.addX + self.shakeX;
                        self.y = self.addY + self.shakeY;
                        self.alpha = 0;
                        end
                    if (self.alpha < 0.5) then self.alpha = self.alpha + 0.05; end
                    self.rotation = Utils.angle(self.attachedThing.x, self.attachedThing.y, self.originMaskaught.x + influenceX, self.originMaskaught.y + influenceY);
        
                    self.scale_x = Utils.dist(self.attachedThing.x, self.attachedThing.y, self.originMaskaught.x + influenceX, self.originMaskaught.y + influenceY) / 2;
                    self.scale_y = 1;

                    end
            end
        end
    if (self.isShattered == true)
        then
        self.shatterY = self.shatterY + 1;
        self.addY = self.addY + self.shatterY;
        if (self.originSword ~= nil)
            then
            self.originSword.addX = self.originSword.addX - self.shatterY / 2;
            self.originSword.addY = self.originSword.addY + self.shatterY;
            end
        end
    if (self.originSword ~= nil and self.isShattered == false)
        then
        if (self.originSword.stabVar > 5)
            then
            local lineDistance = -45;
            local influenceX = math.cos(self.originSword.rotation) * lineDistance;
            local influenceY = math.sin(self.originSword.rotation) * lineDistance;
            self.addX = self.originSword.x + influenceX;
            self.addY = self.originSword.y + influenceY;
            self.rotation = Utils.angle(self.addX, self.addY, self.originSword.originalX, self.originSword.originalY);
        
            
            -- self:setScale(50, 4);    
        
            -- self:setScaleOrigin(0, 0.5)
            -- self.sprite:setScaleOrigin(0, 0.5)
            -- self.origin_x = 0;
            self.scale_x = Utils.dist(self.addX, self.addY, self.originSword.originalX, self.originSword.originalY) / 2;
            self.scale_y = 1;
            -- self.scale_y = 1;
            -- 
            -- self.sprite:setScaleOrigin(0, 0.5)
            -- -- self.sprite:setScale(2, 2)
            -- -- self.collider:setScaleOrigin(0, 0.5);
            -- -- self:setScale(100, 10);
            -- 
            -- self.sprite:setScale(Utils.dist(self.addX, self.addY, self.originSword.originalX, self.originSword.originalY) / 2 / self.scale_x, 2);
        
            -- self.scale_y = 1
        
            -- self.collider.height = 0;

            -- self.sprite:setScaleOrigin(0, 0.5)
            -- self.sprite:setScale(0, 1);

            -- self.sprite:setScale(0.5, 10);

            -- self.sprite:setScale(10, 10);
            
            -- self:setScale(50, 50);
            -- if (self.collider.collidesWith(Game.battle.soul))
            --     then
            --     Kristal.Console:log("touched string")
            --     end
            if (self.originSword.addX ~= 0 and self.originSword.returnX ~= 0) then self.alpha = 0.75 - (self.originSword.returnX / self.originSword.addX); end
            -- self.Line1Sprite.alpha = 0;
            end
        else
        
        end
    self.x = self.addX + self.shakeX;
    self.y = self.addY + self.shakeY;
    self.initDone = true;
    super.update(self)
end

return connector
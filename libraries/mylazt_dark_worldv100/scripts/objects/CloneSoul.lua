local CloneSoul, super = Class(Soul)

function CloneSoul:init(x, y, aBattle)
    super:init(self, x, y)

	-- Do not modify these variables
    self.mainColor = {0.89, 0.64, 0.36}; -- original {0.37, 0.04, 0.55};
    self.addColor = 0;
    self.color = {self.mainColor[1] + self.addColor, self.mainColor[2] + self.addColor, self.mainColor[3] + self.addColor};
    self.initX = nil;
    self.initY = nil;
    self.teleportX = nil;
    self.teleportY = nil;
    self.teleportSoul = nil;
    self.teleportRotation = 0;
    self.breakParent = Sprite("whiteline");
    self.breakParent.alpha = 0;

    self.theBattle = Game.battle;

    if (aBattle ~= nil)
        then
        self.theBattle = aBattle;
        end

    self.theBattle:addChild(self.breakParent);
    self.breakCollider = Hitbox(self.breakParent, 0, -15, 10, 30);
    self.breakTime = 0;
    --self:setParent(self.theBattle.mask);
    self.breakSoundReady = true;

    self.timer = Timer();
    self:addChild(self.timer);
    self.timer:every(1/60, function()
    -----------------------------------------------------------------------------------   
    if (self.breakTime > 0) then self.breakTime = self.breakTime - 1; else self.breakSoundReady = true; end
    -- breaktime doesn't need DTMULT because it's in a timer, i think.
-----------------------------------------------------------------------------------  
                end)

    
   
end
function CloneSoul:breakCollide()
for _,bullet in ipairs(Game.stage:getObjects(Bullet))
                do
                if (bullet:collidesWith(self.breakCollider) and bullet.isBreak ~= nil and bullet.isBreak == true and (bullet.damage > 0 or (bullet.alwaysBreak ~= nil))  )
                    then -- if teleportsoul colliding with break
                    --self:endTarget(-1);
                    bullet.isBreak = false;
                        if (bullet.breakType == "note")
                        then
                        local fadeThing = Sprite("bullets/breakclefnoter"); 
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x * 2, bullet.scale_y * bullet.sprite.scale_y * 2);
                        fadeThing.alpha = 0.5;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );
                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 1;
                        fadeThing.physics.direction = math.rad(90);

                        fadeThing = Sprite("bullets/breakclefnotel"); 
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x * 2, bullet.scale_y * bullet.sprite.scale_y * 2);
                        fadeThing.alpha = 0.5;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );
                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 1;
                        fadeThing.physics.direction = math.rad(-90);

                        bullet:remove();
                        if (self.breakSoundReady == true) then Assets.playSound("darkbreak"); self.breakSoundReady = false; end
                        end

                        if (bullet.breakType == "lineward")
                        then
                        local fadeThing = Sprite("bullets/break_lineward_r"); 
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x, bullet.scale_y * bullet.sprite.scale_y);
                        fadeThing.alpha = 0.8;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );

                        fadeThing.timer = Timer();
                        fadeThing:addChild(fadeThing.timer);
                        fadeThing.timer:tween(0.4, fadeThing, {rotation = math.rad(-90)}, 'in-out-quad');

                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 2;
                        fadeThing.physics.direction = math.rad(90);

                        fadeThing = Sprite("bullets/break_lineward_l"); 
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x, bullet.scale_y * bullet.sprite.scale_y);
                        fadeThing.alpha = 0.8;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );

                        fadeThing.timer = Timer();
                        fadeThing:addChild(fadeThing.timer);
                        fadeThing.timer:tween(0.4, fadeThing, {rotation = math.rad(90)}, 'in-out-quad');

                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 2;
                        fadeThing.physics.direction = math.rad(-90);

                        bullet:remove();
                        end

                        if (bullet.breakType == "pillar")
                        then
                        local fadeThing = Sprite("bullets/break_pillar_r"); 
                        local randomMult = Utils.pick({-1, 1});
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x, bullet.scale_y * bullet.sprite.scale_y);
                        fadeThing.alpha = 0.8;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );

                        fadeThing.timer = Timer();
                        fadeThing:addChild(fadeThing.timer);
                        fadeThing.timer:tween(0.4, fadeThing, {rotation = math.rad(-20)}, 'in-out-quad');

                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 2 * randomMult;
                        fadeThing.physics.direction = math.rad(45);

                        fadeThing = Sprite("bullets/break_pillar_l"); 
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x, bullet.scale_y * bullet.sprite.scale_y);
                        fadeThing.alpha = 0.8;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );

                        fadeThing.timer = Timer();
                        fadeThing:addChild(fadeThing.timer);
                        fadeThing.timer:tween(0.4, fadeThing, {rotation = math.rad(20)}, 'in-out-quad');

                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 2 * randomMult;
                        fadeThing.physics.direction = math.rad(-45);

                        bullet:remove();
                        end

                        if (bullet.breakType == "paw")
                        then
                        local fadeThing = Sprite("bullets/break_paw_r"); 
                        local randomMult = Utils.pick({-1});
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x, bullet.scale_y * bullet.sprite.scale_y);
                        fadeThing.alpha = 0.4;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );

                        fadeThing.timer = Timer();
                        fadeThing:addChild(fadeThing.timer);
                        fadeThing.rotation = bullet.rotation;
                        --fadeThing.timer:tween(0.4, fadeThing, {rotation = math.rad(-20)}, 'in-out-quad');

                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 2 * randomMult;
                        fadeThing.physics.direction = math.rad(-45) + bullet.rotation;

                        fadeThing = Sprite("bullets/break_paw_l"); 
                        self.theBattle:addChild(fadeThing);

                        fadeThing:setLayer(self.layer - 5);
                        fadeThing:setOrigin(0.5, 0.5);
                        fadeThing:setScale(bullet.scale_x * bullet.sprite.scale_x, bullet.scale_y * bullet.sprite.scale_y);
                        fadeThing.alpha = 0.4;
                        fadeThing:fadeTo(0, 0.5, function(spritething) fadeThing:remove(); end );

                        fadeThing.timer = Timer();
                        fadeThing:addChild(fadeThing.timer);
                        fadeThing.rotation = bullet.rotation;
                        --fadeThing.timer:tween(0.4, fadeThing, {rotation = math.rad(20)}, 'in-out-quad');

                        fadeThing:setScreenPos(bullet:getScreenPos());
                        fadeThing.physics.speed = 2 * randomMult;
                        fadeThing.physics.direction = math.rad(45) + bullet.rotation;

                        bullet:remove();
                        end

                        if (bullet.breakType == "raven")
                        then
            
                        local shard_count = count or 6

                        self.shards = {}
                        for i = 1, shard_count
                        do
                            local x_pos = self.shard_x_table[((i - 1) % #self.shard_x_table) + 1]
                            local y_pos = self.shard_y_table[((i - 1) % #self.shard_y_table) + 1]
                            local shard = Sprite("player/heart_shard", bullet.x + x_pos, bullet.y + y_pos)
                            shard:setColor({0.6, 0.36, 0.72})
                            shard.physics.direction = math.rad(Utils.random(10) + i * 60)
                            shard.physics.speed = 1
                            shard.physics.gravity = 0.05
                            shard.layer = bullet.layer
                            shard:play(5/30)
                            shard:fadeTo(0, 1.0, function(spritething) shard:remove(); end );
                            table.insert(self.shards, shard)
                            self.theBattle:addChild(shard)
                        end

                        bullet.alpha = 0.3;
                        bullet.damage = 0;
                        bullet.tp = 0;
                        --bullet:remove();
                        end

                        if (bullet.breakType == "lobera")
                        then
            
                        local shard_count = count or 6

                        self.shards = {}
                        for i = 1, shard_count
                        do
                            local x_pos = self.shard_x_table[((i - 1) % #self.shard_x_table) + 1]
                            local y_pos = self.shard_y_table[((i - 1) % #self.shard_y_table) + 1]
                            local shard = Sprite("player/heart_shard", bullet.x + x_pos, bullet.y + y_pos)
                            shard:setColor({0.6, 0.36, 0.72})
                            shard.physics.direction = math.rad(Utils.random(10) + i * 60)
                            shard.physics.speed = 1
                            shard.physics.gravity = 0.05
                            shard.layer = bullet.layer
                            shard:play(5/30)
                            shard:fadeTo(0, 1.0, function(spritething) shard:remove(); end );
                            table.insert(self.shards, shard)
                            self.theBattle:addChild(shard)
                        end

                        bullet.alpha = 0.3;
                        bullet.damage = 0;
                        bullet.tp = 0;
                        bullet:shake(5);
                        local signBullet = 1;
                        if (bullet.physics.direction < math.rad(90)) then signBullet = -1; end
                        bullet.rotation = bullet.rotation + math.rad(-8) * signBullet;
                        --bullet:remove();
                        end


                    if (self.breakSoundReady == true) then Assets.playSound("darkbreak"); self.breakSoundReady = false; end



                    Game:giveTension(1);
                    break;
                    end
                end
end
function CloneSoul:onCollide(bullet)
    -- Handles damage
    if (bullet.isBreak ~= nil and self.breakTime > 0)
        then
        else
        bullet:onCollide(self)
        end
end
function CloneSoul:update()
    super:update(self)
    local colorMult = 0.8;
    self.color = {self.mainColor[1] + self.addColor, self.mainColor[2] - self.addColor * colorMult, self.mainColor[3] - self.addColor * colorMult};
    if (self.addColor > 0) then self.addColor = self.addColor - 0.02 * DTMULT; else end
    if (self.theBattle ~= Game.world and self.theBattle.arena ~= nil)
        then
        if (Input.pressed("confirm"))
            then
            if (self.initX == nil and self.addColor <= 0.5) then self:startTarget(); end
            end
        if (self.breakTime > 0)
            then
            self:breakCollide();
            end
        if (self.initX ~= nil)
            then
            local halfSoulWidth = self.width / 2;
            local halfSoulHeight = self.height / 2;
            local halfArenaWidth = self.theBattle.arena.width / 2;
            local halfArenaHeight = self.theBattle.arena.height / 2;
            self.teleportRotation = Utils.angle(self.x, self.y, self.initX, self.initY);
            self.teleportX = self.x + math.cos(self.teleportRotation) * Utils.dist(self.x, self.y, self.initX, self.initY) * 2;
            self.teleportY = self.y + math.sin(self.teleportRotation) * Utils.dist(self.x, self.y, self.initX, self.initY) * 2;
            self.teleportX = Utils.clamp(self.teleportX, self.theBattle.arena.x - halfArenaWidth + halfSoulWidth, self.theBattle.arena.x + halfArenaWidth - halfSoulWidth);
            self.teleportY = Utils.clamp(self.teleportY, self.theBattle.arena.y - halfArenaHeight + halfSoulHeight, self.theBattle.arena.y + halfArenaHeight - halfSoulHeight);
            if (self.teleportSoul ~= nil)
                then
                self.teleportSoul.x = self.teleportX;
                self.teleportSoul.y = self.teleportY;
                for _,bullet in ipairs(Game.stage:getObjects(Bullet))
                    do
                    if (bullet:collidesWith(self.teleportSoul.collider) and bullet.isDark ~= nil and bullet.isDark == true and bullet.damage > 0)
                        then -- if teleportsoul colliding with dark
                        self:endTarget(-1);
                        break;
                        end
                    --if (bullet:collidesWith(self.teleportSoul.collider) and bullet.isBreak ~= nil and bullet.isBreak == true and bullet.damage > 0)
                    --    then -- if teleportsoul colliding with break
                    --    self:endTarget(-1);
                    --    break;
                    --    end
                    end
                end
            end
        if (Input.released("confirm"))
            then
            if (self.initX ~= nil) then self:endTarget(1); end
            end
        end
    self.breakParent.x = self.x;
    self.breakParent.y = self.y;
end

function CloneSoul:startTarget()
    self.initX = self.x;
    self.initY = self.y;
    self.teleportSoul = Sprite("player/thinheart");
    self.theBattle:addChild(self.teleportSoul);
    self.teleportSoul:setLayer(self.layer + 5);
    self.teleportSoul:setOrigin(0.5, 0.5);

    --self.teleportSoul.alpha = 0.7;

    self.teleportSoul.line1 = Sprite("whiteline"); self.theBattle:addChild(self.teleportSoul.line1); self.teleportSoul.line1:setLayer(self.layer - 3);
    self.teleportSoul.line2 = Sprite("whiteline"); self.theBattle:addChild(self.teleportSoul.line2); self.teleportSoul.line2:setLayer(self.layer - 3);
    self.teleportSoul.line3 = Sprite("whiteline"); self.theBattle:addChild(self.teleportSoul.line3); self.teleportSoul.line3:setLayer(self.layer - 3);

    self.teleportSoul.line1.x = -100;
    self.teleportSoul.line2.x = -100;
    self.teleportSoul.line3.x = -100;

    local lineWidth = 40;
    self.teleportSoul.line1:setScale(2, lineWidth);
    self.teleportSoul.line2:setScale(2, lineWidth);
    self.teleportSoul.line3:setScale(2, lineWidth);

    self.teleportSoul.line1:setOrigin(0.5, 0.5);
    self.teleportSoul.line2:setOrigin(0.5, 0.5);
    self.teleportSoul.line3:setOrigin(0.5, 0.5);

    self.teleportSoul.line1.alpha = 0.6;
    self.teleportSoul.line2.alpha = 0.7;
    self.teleportSoul.line3.alpha = 0.9;

    self.teleportSoul.line1.color = self.mainColor;
    self.teleportSoul.line2.color = self.mainColor;
    self.teleportSoul.line3.color = self.mainColor;

    self.teleportSoul.collider = CircleCollider(self.teleportSoul, self.teleportSoul.width / 2, self.teleportSoul.height / 2, 8);

    self.teleportSoul.timer = Timer();
    self.teleportSoul:addChild(self.teleportSoul.timer);
    self.teleportSoul.timer:every(1/60, function()
    -----------------------------------------------------------------------------------   
--Kristal.Console:log(self.detachCount);
                    -- Kristal.Console:log("sss");
    
    if (self.theBattle.soul == nil)
        then
        self.teleportSoul.line1:remove();
        self.teleportSoul.line2:remove();
        self.teleportSoul.line3:remove();
        self.teleportSoul:remove();
        else
        self.teleportSoul.line1.x = self.x + (self.teleportX - self.x) * 0;
        self.teleportSoul.line1.y = self.y + (self.teleportY - self.y) * 0;
        self.teleportSoul.line1.rotation = self.teleportRotation;

        self.teleportSoul.line2.x = self.x + (self.teleportX - self.x) * 0.6;
        self.teleportSoul.line2.y = self.y + (self.teleportY - self.y) * 0.6;
        self.teleportSoul.line2.rotation = self.teleportRotation;

        self.teleportSoul.line3.x = self.x + (self.teleportX - self.x) * 1;
        self.teleportSoul.line3.y = self.y + (self.teleportY - self.y) * 1;
        self.teleportSoul.line3.rotation = self.teleportRotation;

        end
-----------------------------------------------------------------------------------  
                end)
end

function CloneSoul:draw()
super:draw(self);
--love.graphics.rectangle("fill", self.breakCollider.x, self.breakCollider.y, self.breakCollider.width, self.breakCollider.height);
--self.breakCollider = Hitbox(self, self.breakCollider.x, self.breakCollider.y, self.breakCollider.width, self.breakCollider.height);
end

function CloneSoul:spawnFade(x, y, alphaTime)
    local fadeThing = Sprite("player/teleportarrow"); 
    self.theBattle:addChild(fadeThing);
    fadeThing:setLayer(self.layer - 5);
    fadeThing:setOrigin(0.5, 0.5);
    --fadeThing.alpha = alpha;
    fadeThing:fadeTo(0, alphaTime, function(spritething) fadeThing:remove(); end );
    fadeThing.color = self.mainColor;
    fadeThing.x = x;
    fadeThing.y = y;
    fadeThing.rotation = self.breakParent.rotation + math.rad(45);
end
function CloneSoul:endTarget(successLevel)

    if (self.teleportSoul ~= nil)
        then
        if (successLevel == -1)
            then
            local shard_count = count or 6

            self.shards = {}
            for i = 1, shard_count
                do
                    local x_pos = self.shard_x_table[((i - 1) % #self.shard_x_table) + 1]
                    local y_pos = self.shard_y_table[((i - 1) % #self.shard_y_table) + 1]
                    local shard = Sprite("player/heart_shard", self.teleportSoul.x + x_pos, self.teleportSoul.y + y_pos)
                    shard:setColor({0.6, 0.6, 0.6})
                    shard.physics.direction = math.rad(Utils.random(10) + i * 60)
                    shard.physics.speed = 3
                    shard.physics.gravity = 0.2
                    shard.layer = self.layer
                    shard:play(5/30)
                    shard:fadeTo(0, 1.0, function(spritething) shard:remove(); end );
                    table.insert(self.shards, shard)
                    self.theBattle:addChild(shard)
                end
            Assets.playSound("darksh");
            end
        if (successLevel == 1)
            then
            local fadeAlpha = 1;
            local fadeDistance = 1;
            --self:spawnFade(self.x, self.y, 0.4);

            self.breakParent.rotation = Utils.angle(self.x, self.y, self.teleportX, self.teleportY);

            fadeDistance = 0; fadeAlpha = 0.4; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 0.2; fadeAlpha = 0.45; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 0.4; fadeAlpha = 0.50; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 0.6; fadeAlpha = 0.55; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 0.7; fadeAlpha = 0.56; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 0.8; fadeAlpha = 0.57; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 0.9; fadeAlpha = 0.70; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            fadeDistance = 1.0; fadeAlpha = 0.75; self:spawnFade(self.x + (self.teleportX - self.x) * fadeDistance, self.y + (self.teleportY - self.y) * fadeDistance, fadeAlpha);
            self.breakCollider.width = math.sqrt((((self.teleportX - self.x)^2) + ((self.teleportY - self.y)^2))) * -1;
            self.x = self.teleportX;
            self.y = self.teleportY;
            self.breakParent.x = self.x;
            self.breakParent.y = self.y;
            self.addColor = 0.6;
            self.breakTime = 10;
            self:breakCollide();

            -- self:spawnFade(self.teleportSoul.line2.x, self.teleportSoul.line2.y, 0.6);
            Assets.playSound("darkjump");
            end
        self.teleportSoul.line1:remove();
        self.teleportSoul.line2:remove();
        self.teleportSoul.line3:remove();
        self.teleportSoul:remove();
        self.teleportSoul = nil;
        self.initX = nil;
        self.initY = nil;
        end
end




return CloneSoul
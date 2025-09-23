local raven, super = Class(Bullet)

function raven:onCollide(soul)
super.onCollide(self, soul)
if (self.damage > 0 and self.isDark == true)
    then
            -- Kristal.Console:log("fakecollidee!")
            local targets = Game.battle:getPartyFromTarget(self:getTarget())
            for _, target in ipairs(targets) do
            -- target.x = target.x + 5
            target.isCursed = true
        
            end
    end
end

function raven:init(startX, startY, awayX, awayY, goDirection, goSpeed, goDelay, isDark)
    
    
    -- Last argument = sprite path
    self.isDark = isDark;
    if (self.isDark == false) then self.ravenSprite = "bullets/raven"; self.isBreak = true; self.breakType = "raven"; else self.ravenSprite = "bullets/graven"; end
    --self.ravenSprite = (self.isDark == false) ? "bullets/raven" : "bullets/graven";
    super.init(self, Game.battle.arena.x, Game.battle.arena.y, self.ravenSprite)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    self.ravenAnim = {self.ravenSprite, 0.04, true, frames = {1, 1, 2, 3, 3, 2}};
    self.sprite:setAnimation(self.ravenAnim);
    --self.sprite:setFrame(Utils.pick({1, 3, 5}));
    self.sprite:pause();
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false;
    self.remove_offscreen = false;
    self.damage = 80;
    local offX = 360;
    local offY = 360;
    local randomX = love.math.random(-300, 300);
    local randomY = love.math.random(-160, 160);
    self.moveX = 0;
    self.moveY = 0;
    self.startX = startX;
    self.startY = startY;
    self.goDirection = goDirection;
    self.goSpeed = goSpeed;
    self.goDelay = goDelay;
    self.rotation = self.goDirection - math.rad(180);
    local spriteWidthMultiply = 1;
    if (math.abs(Utils.angleDiff(math.rad(0), self.goDirection)) < math.rad(90)) then spriteWidthMultiply = -1; self.rotation = self.rotation - math.rad(180); end

    --self.scale_x = 1;
    --self.scale_y = 1;
    --self.sprite:setScaleOrigin(0.5, 0.5)
    self:setScale(2 * spriteWidthMultiply, 2);
    if (self.goSpeed ~= 0)
        then
        self.collider = Hitbox(self, self.sprite.width / 2 - 6, self.sprite.height / 2 - 2, 4, 4);
        else
        self.collider = Hitbox(self, self.sprite.width / 2, self.sprite.height / 2, 4, 4);
        end
    

    --self:setRotationOrigin(0.5, 0.5);
    self:setOrigin(0.5, 0.5);

    if (awayX < 0) then self.x = Game.battle.arena.x - offX; end if (awayX > 0) then self.x = Game.battle.arena.x + offX; end
    if (awayY < 0) then self.y = Game.battle.arena.y - offY; end if (awayY > 0) then self.y = Game.battle.arena.y + offY; end
    if (awayX ~= 0) then self.y = self.y + randomY; end -- randomize Y if X is known
    if (awayY ~= 0) then self.x = self.x + randomX; end -- randomize X if Y is known
    -- self.startX = self.startX + love.math.random(-5, 5);
    -- self.startY = self.startY + love.math.random(-5, 5);
    self.timer = Timer()
    self:addChild(self.timer)
    self.initRaven = false;
    self.goDone = false;
    self.ravenTime = 0;
    self.onpauseTime = Utils.pick({3, 5, 8, 12, 15, 18});
    self.inv_timer = 0.3;
    self.waitFade = 10;
    

    --maybe--self.timer = Timer()
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
self.ravenTime = self.ravenTime + 1;
    if (self.ravenTime == self.onpauseTime) then self.sprite:resume(); end
    if (self.goDone == true)
            then
            if (self.waitFade <= 0 and self.goSpeed ~= 0) then self:spawnFade(self.x, self.y, 0.15); end
            if (self.waitFade > 0) then self.waitFade = self.waitFade - 1; end
            end
-- FIXER END BELOW
    end)
-- FIXER MULT END
end


function raven:spawnFade(x, y, alphaTime)
    --too laggy-- local fadeThing = Sprite(self.ravenSprite); 
    --too laggy-- Game.battle:addChild(fadeThing);
    --too laggy-- fadeThing:setLayer(self.layer);
    --too laggy-- fadeThing:setOrigin(0.5, 0.5);
    --too laggy-- fadeThing:setScale(self.sprite.scale_x, 2);
    --too laggy-- fadeThing:setFrame(self.sprite.frame);
    --too laggy-- fadeThing.rotation = self.rotation;
    --too laggy-- fadeThing.alpha = 0.5;
    --too laggy-- fadeThing:fadeTo(0, alphaTime, function(spritething) fadeThing:remove(); end );
    --too laggy-- --fadeThing.color = self.mainColor;
    --too laggy-- fadeThing.x = x;
    --too laggy-- fadeThing.y = y;
end

function raven:remove()
    --Kristal.Console:log("go away birde");
    super.remove(self)
end

function raven:update()
    -- For more complicated bullet behaviours, code here gets called every update
    
    if (self.initRaven == false)
        then
        self.initRaven = true;
        self.timer:tween(self.goDelay, self, {x = self.startX}, 'out-quad');
        self.timer:tween(self.goDelay, self, {y = self.startY}, 'out-quad');
        self.timer:after(self.goDelay - 0.1,
            function() 
            self.timer:tween(0.8, self, {moveX = self.goSpeed}, 'in-out-quad');
            self.timer:tween(0.8, self, {moveY = self.goSpeed}, 'in-out-quad');
            self.goDone = true;  
            self.remove_offscreen = true;

            end);
        -- fadeout the darkbox
        -- darkbox_sprite.timer:every(1/30, function()
        --             darkbox_sprite.alpha = darkbox_sprite.alpha - 0.02;
        --             if (darkbox_sprite.alpha <= 0) then darkbox_sprite.timer:remove(); darkbox_sprite:remove(); return; end
        --             -- Kristal.Console:log("sss");
        --         end, 200)
        -- cutscene:text(" ")

        else
        -- if active raven
        if (self.goDone == true)
            then

            self.x = self.x + math.cos(self.goDirection) * self.moveX * DTMULT;
            self.y = self.y + math.sin(self.goDirection) * self.moveY * DTMULT;
            end
        end
    super.update(self)
end

return raven
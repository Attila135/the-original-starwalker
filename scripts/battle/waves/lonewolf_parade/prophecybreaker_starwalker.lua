local prophecybreaker, super = Class(Wave)
local angleChange = 1
function prophecybreaker:init()
super.init(self);
self:setArenaSize(182, 162)
end
function prophecybreaker:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.timeVar = 0;
    self.firstVar = 0;
    self.time = 999.0;
    self.spinBox = self:spawnBullet("spinbox", Game.battle.arena.x, Game.battle.arena.y);
    self.initialY = Game.battle.arena.y;
    self.upVar = 0;
    self.double = #Game.battle.waves==2
    self.timer:every(self.double and 1.75 or 0.75, function()
        local x, y
        repeat
            x = Utils.random(30, SCREEN_WIDTH-30)
        until (x<Game.battle.arena.left or x>Game.battle.arena.right)
        repeat
            y = Utils.random(30, SCREEN_HEIGHT-30)
        until (y<Game.battle.arena.top or y>Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("secret/iceshock", x, y)
    end)
    --maybe--self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
 if (self.firstVar >= 0) 
        then 
        self.firstVar = self.firstVar + 1;

        if (self.firstVar % 20 == 0 and self.firstVar > 30) then self:spawnBullet("lobera_spinnercore", Game.battle.soul.x, Game.battle.soul.y, math.rad(0), 0); Assets.playSound("darksummon") end
         
        if (self.firstVar < 30) then Game.battle.arena.y = Utils.ease(Game.battle.arena.y, self.initialY + 50, self.firstVar / 2 / 40, "in-out-quad"); end

        if (self.firstVar >= 200)
            then
            self.firstVar = -10;
            self.initialY = Game.battle.arena.y;
            self:beginpaws();
            end
        else
        self.timeVar = self.timeVar + 1;
        if (self.timeVar <= 100) 
            then 
            if (self.timeVar > 30) then self.upVar = self.upVar + 1; end
            Game.battle.arena.y = Utils.ease(Game.battle.arena.y, self.initialY - 50, self.upVar / 2 / 40, "in-out-quad"); 
            end
        
        end
-- FIXER END BELOW
    end)
-- FIXER MULT END
    
end
function prophecybreaker:beginpaws()
local leftPaw = self:spawnBullet("wolfpaw", Game.battle.arena.x - 200, Game.battle.arena.y + 150, true, self.spinBox);
local rightPaw = self:spawnBullet("wolfpaw", Game.battle.arena.x + 200, Game.battle.arena.y + 150, false, self.spinBox);
end
function prophecybreaker:spawnspinnerlobera()

end
function prophecybreaker:update()
    -- Code here gets called every frame
    --if (self.firstVar == 100)
    --    then
    --    local ravenSpeed = 16;
    --    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, 1, false);
    --    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, 1, false);
    --    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), ravenSpeed, 1, false);
    --    self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 60, 50, 0, math.rad(180), ravenSpeed, 1, false);
    --    end
   
    
    super.update(self)
end

return prophecybreaker
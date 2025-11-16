local masktutwave, super = Class(Wave)





function masktutwave:init()
super.init(self);
self.time = -1;
self:setArenaSize(19999, 19999);
--self.has_arena = false;
--self:setArenaOffset(300, 300);
Game.battle.battle_ui:transitionOut() 
Game.battle.tension_bar:hide()
self:setSoulPosition(320, 258);


end


function masktutwave:onStart()
    Assets.playSound("noise");
    Game.battle:swapSoul(CloneSoul());
    Game.battle.arena.mask.alpha = 0.1;

    
   Game.battle.arena:setBackgroundColor(0, 0, 0, 0);
    self:setArenaSize(402, 402)
    --self:setArenaOffset(1, 40);

    local ralsei = Game.world:getCharacter("ralsei");
    local kris = Game.world:getCharacter("kris");
    local krisX, krisY = kris:localToScreenPos(0, 0);
    local ralseiX, ralseiY = ralsei:localToScreenPos(0, 0);
    
    ralseiX = ralseiX + 20;
    ralseiY = ralseiY + 50;
    --Game.battle.arena.mask:addChild(ralsei);
    
    self:setArenaPosition(ralseiX, ralseiY)

    Game.battle:getActiveParty()[1].x = krisX;
    Game.battle:getActiveParty()[1].y = krisY;


    self.timeVar = 0;
    self.threadAmount = 0;
    self.waitVar = 0;
    self.canBetter = true;
    self.canTip = true;

    --maybe--self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    self.timeVar = self.timeVar + 1;
    if (self.timeVar == 5)
        then
        self:spawnBullet("fancy_ralsei", 220, 258, math.rad(0), 0);
        self:spawnBullet("fancy_ralsei", 420, 258, math.rad(0), 0);

        self:spawnBullet("fancy_ralsei", 270, 158, math.rad(0), 0);
        self:spawnBullet("fancy_ralsei", 370, 158, math.rad(0), 0);

        self:spawnBullet("fancy_ralsei", 270, 358, math.rad(0), 0);
        self:spawnBullet("fancy_ralsei", 370, 358, math.rad(0), 0);

        --self:spawnBullet("fancy_ralsei", ralseiX, ralseiY, math.rad(0), 0);
        end
    
-- FIXER END BELOW
    end)
-- FIXER MULT END

    --ralsei.x = 999;
    --ralsei:setLayer(Game.battle.soul.layer - 1);
end


function masktutwave:update()
    -- Code here gets called every frame
    if (self.threadAmount >= 6)
        then
        self.waitVar = self.waitVar + 1 * DTMULT;
            if (self.waitVar > 20)
            then
            self.time = 1;
            end
        end
    if (Game.battle ~= nil and Game.battle.party[1].chara.health < 40 and self.canBetter == true) then Assets.playSound("wolf_bthan"); self.canBetter = false; end
    if (Game.battle ~= nil and Game.battle.party[1].chara.health < 30 and self.canBetter == false) then Game.battle.party[1]:heal(5000); self.canBetter = true; end
    if (self.canTip == true and Game.battle.wave_timer > 4.00)
        then
        self.canTip = false;
        self:spawnBullet("tutorialtip", 190, 30, math.rad(0), 0);
        end

    super.update(self)
end

return masktutwave
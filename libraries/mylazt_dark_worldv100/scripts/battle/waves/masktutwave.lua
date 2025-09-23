local masktutwave, super = Class(Wave)





function masktutwave:init()
super.init(self);
self.time = -1;
self:setArenaSize(19999, 19999);
--self.has_arena = false;
--self:setArenaOffset(300, 300);
Game.battle.battle_ui:transitionOut() 
Game.battle.tension_bar:hide()
self:setSoulPosition(262, 317)


end


function masktutwave:onStart()
    Assets.playSound("noise");
    Game.battle:swapSoul(CloneSoul());
    Game.battle.arena.mask.alpha = 0.1;

    
   Game.battle.arena:setBackgroundColor(0, 0, 0, 0);
    self:setArenaSize(402, 402)
    --self:setArenaOffset(1, 40);

    self.timeVar = 0;
    self.threadAmount = 0;
    self.waitVar = 0;
    self.canBetter = true;
    self.canTip = true;

    --maybe--self.timer = Timer() self:addChild(self.timer)
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
    
-- FIXER END BELOW
    end)
-- FIXER MULT END

    --ralsei.x = 999;
    --ralsei:setLayer(Game.battle.soul.layer - 1);
end


function masktutwave:update()
    -- Code here gets called every frame
    if (self.threadAmount >= 4)
        then
        self.waitVar = self.waitVar + 1 * DTMULT;
            if (self.waitVar > 20)
            then
            Game.battle:setState("DEFENDINGEND");
            end
        end
    if (Game.battle ~= nil and Game.battle.party[1].chara.health < 40 and self.canBetter == true) then Assets.playSound("wolf_bthan"); self.canBetter = false; end
    if (Game.battle ~= nil and Game.battle.party[1].chara.health < 30 and self.canBetter == false) then Game.battle.party[1]:heal(5000); self.canBetter = true; end
    if (self.canTip == true and Game.battle.wave_timer > 4.00)
        then
        self.canTip = false;
        self:spawnBullet("tutorialtip", Game.battle.arena.x, Game.battle.arena.y + 220, math.rad(0), 0);
        end

    super.update(self)
end

return masktutwave
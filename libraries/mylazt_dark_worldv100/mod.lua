function Mod:init()
    print("Prepared "..self.info.name.."!")
    Game.extraDust = 0
    Game.dustForm = false
    Game.extra_inv = 0;
    -- Game.shouldUnswirl = false;
    -- Game.wolfTarget = 1
--    removeHealth()



-- Utils.hook(Soul, "onDamage", function(orig, self, bullet, amount) 
-- orig(self, amount)
-- 
-- -- Kristal.Console:log("hurt list " .. tostring(Game.battle:getPartyFromTarget(Game.battle:getTarget())))
-- if (bullet.id == "dustclaw")
--     then
--     Kristal.Console:log("Cursed!")
--     end
-- return self.thinge2
-- end)
-- -- Utils.hook(Soul, "onDamage", function(orig, self, bullet, amount)
-- -- Kristal.Console:log("customized hurt 2")
-- -- return self.thinge2
-- -- end)

Utils.hook(EnemyBattler, "spare", function(orig, self, pacify) 
if (self.mercy >= 100 and self.unveiled == false)
    then 
    Game.battle.character_actions = {}

Game.battle.selected_character_stack = {}
Game.battle.selected_action_stack = {}

Game.battle.current_actions = {}
Game.battle.short_actions = {}
Game.battle.current_action_index = 1
Game.battle.processed_action = {}
Game.battle.processing_action = false

Game.battle.actions_done_timer = 0

Game.battle.xactions = {}

Game.battle.should_finish_action = false
Game.battle.on_finish_keep_animation = nil
Game.battle.on_finish_action = nil
    self.hasSpareInfo = true;
    self:onDefeat();
    Assets.playSound("spare")
    return; 
    end
orig(self, pacify);
return self.thingemercy
end)
-- 

-------------if (self.mercy >= 100 and self.unveiled == false)
-------------    then
-------------    local targets = Game.battle.party
-------------    for _, target in ipairs(targets)
-------------        do
-------------        if (target.chara.health > 0)
-------------            then
-------------            --Kristal.Console:log("now doing " .. target.chara.id);
-------------            --Game.battle:finishAction(Game.battle:getActionBy(target));
-------------            --Kristal.Console:log("finished action of " .. target.chara.id);
-------------            target:resetSprite()
-------------            --Kristal.Console:log("reset sprite of " .. target.chara.id);
-------------            end
-------------        end
-------------    --Kristal.Console:log("everything done");
-------------    Game.battle.character_actions = {}
-------------
-------------    Game.battle.selected_character_stack = {}
-------------    Game.battle.selected_action_stack = {}
-------------
-------------    Game.battle.current_actions = {}
-------------    Game.battle.short_actions = {}
-------------    Game.battle.current_action_index = 1
-------------    Game.battle.processed_action = {}
-------------    Game.battle.processing_action = false
-------------
-------------    Game.battle.actions_done_timer = 0
-------------
-------------    Game.battle.xactions = {}
-------------
-------------    Game.battle.should_finish_action = false
-------------    Game.battle.on_finish_keep_animation = nil
-------------    Game.battle.on_finish_action = nil
-------------
-------------    Game.battle:startCutscene("maskaught", "maskaught_unveil", self); 
-------------
-------------
-------------    Game.battle.spare_sound:play();
-------------    self.unveiled = true;
-------------    self.dialogue_override = nil;


--
Utils.hook(EnemyBattler, "hurt", function(orig, self, amount, battler, on_defeat, color) 

-- Kristal.Console:log("yeouch")

if ((self.actor.name == "MaskaughtBattle" or self.actor.name == "MaskaughtCombat") and self.dustCount <= 0 )
    then 
    self:TrySetState("HURT");
    Assets.playSound(Utils.pick({"undertale_doghurt", "undertale_catsalad"}));
    end
if (self.dustCount ~= nil and self.dustCount > 0)
    then -- <if dust shielded>
    --Kristal.Console:log("setted")
    
    -- Kristal.Console:log("test " .. tostring(battler.actor.id))

    if (self.dustCount <= 0)
        then
        -- self:setAnimation("unswirlquick")
        else
        
        self:newDust(-1) -- - Game.extraDust)
        -- if (Game.extraDust > 0) then Game.extraDust = Game.extraDust - 1 end
        -- self:setAnimation("unswirlattempt")
        end
    
    
    return false
    else -- <not dust-shielded>
    -- Kristal.Console:log("not swirled")
    orig(self, amount, battler, on_defeat, color)
    end
    return self.thinge3
end)

Utils.hook(PartyBattler, "removeHealth", function(orig, self, amount) 
orig(self, amount)
if (self.isCursed and self.chara.health <= 0)
    then
    self.isCursed = false
    end
return self.thinge
end)

Utils.hook(PartyBattler, "hurt", function(orig, self, amount, exact, color, options) 
    if (Game.battle.maskaughtHits ~= nil) then Game.battle.maskaughtHits = Game.battle.maskaughtHits + 1; end
    
    orig(self, amount, exact, color, options)

    return self.thingespriter
    end)

-- Utils.hook(PartyBattler, "down", function(orig, self) 
--     Kristal.Console:log("downed");
--     Game.extra_inv = 100;
--     orig(self)
-- return self.thinge0010
-- end)



Utils.hook(ActionButton, "select", function(orig, self)

-- Kristal.Console:log(tostring(self.battler.isCursed))
if (self.battler.isCursed and self.type == "fight")
    then
        -- return false
    end
orig(self)
return self.thinge3
end)




-- function EnemyBattler:hurt(amount, battler, on_defeat, color) -- is this needed, for like, nything?
--     self.health = self.health - amount
--     self:statusMessage("damage", amount, color or (battler and {battler.chara:getDamageColor()}))
-- 
--     self.hurt_timer = 1
--     self:onHurt(amount, battler)
-- 
--     self:checkHealth(on_defeat, amount, battler)
-- end 
--


Utils.hook(Text, "init", function(orig, self, text, x, y, w, h, options)
orig(self, text, x, y, w, h, options)
Game.stage.wolfing = false
-- Kristal.Console:log("initiated the textyax!")

local newCommand = function(text, node)
    Game.stage.wolfing = true
    -- Kristal.Console:log(tostring(node.arguments[1]))
    --nvm--if (Game.stage.wolfDuration == nil) 
    --nvm--    then Assets.playSound(node.arguments[1])
    --nvm--    else
    --nvm--    if (Game.stage.wolfDuration < 45)
    --nvm--        then
    --nvm--        Assets.playSound(node.arguments[1])
    --nvm--        end
    --nvm--    end
    Game.stage.wolfDuration = 60
    Assets.playSound(node.arguments[1])
    -- Assets.playSound("dustcurse")
    self.state.typing_sound = ""
end
self:registerCommand("ps", newCommand)



newCommand = function(text, node)
    local maskaught = Game.battle:getEnemyBattler("maskaught");
    if (maskaught ~= nil)
        then
        maskaught:heal(99);
        end
end
self:registerCommand("healmask", newCommand)


local pausemusic = function(text, node)
    if (Game.shop ~= nil)
        then
        Game.shop.music:pause();
        end
end
self:registerCommand("pausemusic", pausemusic)

local pausemusic = function(text, node)
    if (Game.shop ~= nil)
        then
        Game.shop.music:resume();
        end
end
self:registerCommand("resumemusic", pausemusic)

return self.thinge5
end)


-- Kristal.Console:log("mewoed rreset stead")

Utils.hook(Text, "onRemoveFromStage", function(orig, self, stage)

Game.stage.wolfing = false
-- Kristal.Console:log("removed text")

orig(self, stage)
return self.thinge7
end)

--

Utils.hook(BattleUI, "drawState", function(orig, self)

orig(self)
if (Game.battle.state == "ENEMYSELECT" or Game.battle.state == "XACTENEMYSELECT")
    then
    -- Kristal.Console:log("mrrr")
    local enemies = Game.battle:getActiveEnemies()
    local y_offDust = 54
    local dustWidth = 181
    for _, enemy in ipairs(enemies)
        do
        if (enemy.id == "maskaught")
            then
            if (enemy.dustCount > 0)
                then
                love.graphics.print("DUST SHIELD", 438, 90, 0, 1, 0.5)
                love.graphics.setColor(PALETTE["action_health_bg"])
                local dust_x = 420
                local dust_percent = enemy.dustCount / enemy.dustMax
                love.graphics.rectangle("fill", dust_x, 55 + y_offDust, dustWidth, 16)

                love.graphics.setColor({0.55, 0.55, 0.55} )
                love.graphics.rectangle("fill", dust_x, 55 + y_offDust, math.ceil(dust_percent * dustWidth), 16)

                love.graphics.setColor(PALETTE["action_health_text"])
                -- percent form -- love.graphics.print(math.ceil(dust_percent * 100) .. "%", dust_x + 4, 55 + y_offDust, 0, 1, 0.5)
                local addString = "";
                if (enemy.dustCount > 1) then addString = "S"; end
                love.graphics.print(enemy.dustCount .. " HIT" .. addString .. " LEFT", dust_x + 4, 55 + y_offDust, 0, 1, 0.5)
                end
            end
        end
    end
-- Kristal.Console:log("removed text")


return self.thinge8
end)

--

-- Kristal.Console:log("mewoed rreset stead")

Utils.hook(AttackBox, "hit", function(orig, self)


local pDust = math.abs(self:getClose())
if (pDust == 0 and Game.dustForm == true)
then
Game.extraDust = Game.extraDust + 1
-- Kristal.Console:log("exquisite hit")
else
-- Kristal.Console:log("suc hit")
end
-- orig(self)

return orig(self)
end)

--
--

--mayb--Utils.hook(ActorSprite, "setFacing", function(orig, self, facing)
--mayb--if (self.actor.name == "Maskaught")
--mayb--            then
--mayb--            if (self.didChange == nil) then self.didChange = true; self.facing = "right"; self.last_facing = "right"; end
--mayb--            if (facing == "down") then facing = self.last_facing; end
--mayb--            if (facing == "up") then facing = self.last_facing; end
--mayb--            if (Game.world.player ~= nil)
--mayb--                then
--mayb--                local x, y = self:getScreenPos()
--mayb--                local x2, y2 = Game.world.player:getScreenPos()
--mayb--                if (x > x2)
--mayb--                    then
--mayb--                    facing = "left";
--mayb--                    --Kristal.Console:log("left");
--mayb--                    else
--mayb--                    --Kristal.Console:log("right");
--mayb--                    facing = "right";
--mayb--                    end
--mayb--                end
--mayb--            self.facing = facing;
--mayb--            else
--mayb--            return orig(self, facing)
--mayb--            end
--mayb--
--mayb--return self.wolfthinge
--mayb--end)

Utils.hook(ActorSprite, "getDirectionalPath", function(orig, self, sprite)
if (self.actor.name == "Maskaught")
            then
            if (self.didChange == nil) then self.didChange = true; self.facing = "right"; end

            if (Game.world.player ~= nil)
                then
                local x, y = self:getScreenPos()
                local x2, y2 = Game.world.player:getScreenPos()
                if (x > x2)
                    then
                    self.last_facing = "left";
                    --Kristal.Console:log("left");
                    else
                    --Kristal.Console:log("right");
                    self.last_facing = "right";
                    end
                end

            if (self.facing == "down") then self.facing = self.last_facing; end
            if (self.facing == "up") then self.facing = self.last_facing; end
            end
if sprite ~= "" then
        return sprite..self.dir_sep..self.facing
    else
        return self.facing
    end

return self.wolfthinge
end)

-- just make regular foods
-- Utils.hook(World, "heal", function(orig, self, target, amount, text)
-- 
-- Kristal.Console:log("world heal hooked");
-- 
-- if (target:getArmor(1) ~= nil and target:getArmor(1).name == "Permafrost") then amount = amount * 2;
-- elseif (target:getArmor(2) ~= nil and target:getArmor(2).name == "Permafrost") then amount = amount * 2; end
-- 
-- orig(self, target, amount, text)
-- return self.permafrosthealworld
-- end)
-- 
-- Utils.hook(PartyBattler, "heal", function(orig, self, amount, sparkle_color, show_up)
-- 
-- Kristal.Console:log("battler heal hooked");
-- local getTarget = self.chara;
-- 
-- if (getTarget.health > 0)
--     then
--     if (getTarget:getArmor(1) ~= nil and getTarget:getArmor(1).name == "Permafrost") then amount = amount * 2;
--     elseif (getTarget:getArmor(2) ~= nil and getTarget:getArmor(2).name == "Permafrost") then amount = amount * 2; end
--     end
-- 
-- orig(self, amount, sparkle_color, show_up)
-- return self.permafrosthealbattler
-- end)

--Utils.hook(ActorSprite, "update", function(orig, self)
----orig(self)
--local origDirection = self.facing;
--orig(self)
--if (self.actor.name == "Maskaught")
--            then
--            if (Game.world.player ~= nil)
--                then
--                local x, y = self:getScreenPos()
--                local x2, y2 = Game.world.player:getScreenPos()
--                if (x > x2)
--                    then
--                    self.facing = "left";
--                    --Kristal.Console:log("left");
--                    else
--                    --Kristal.Console:log("right");
--                    self.facing = "right";
--                    end
--                end
--            --if (self.didChange == nil) then self.didChange = true; self.facing = "right"; end
--            if (self.facing == "down") then self.facing = self.last_facing; end
--            if (self.facing == "up") then self.facing = self.last_facing; end
--            if (origDirection ~= "down" and origDirection ~= "up") then self.facing = origDirection; self.last_facing = origDirection; end
--            end
--
--return self.thingewolfff
--end)
--




-- / -- Utils.hook(PartyMember, "init", function(orig, self)
-- / -- 
-- / -- orig(self)
-- / -- self.health = 200;
-- / -- Kristal.Console:log("name is " .. self.health)
-- / -- if (self.name ~= "Kris")
-- / --     then
-- / --     Kristal.Console:log("meow")
-- / --     self.stats = {
-- / --             health = 270,
-- / --             attack = 20,
-- / --             defense = 2,
-- / --             magic = 0
-- / --         }
-- / --     end
-- / -- 
-- / -- return self.thinge9;
-- / -- end)

--

-- Utils.hook(Battle, "randomTargetOld", function(orig, self)
-- orig(self)
-- Kristal.Console:log("hooked ")
-- 
-- 
--      for _, enemy in ipairs(self:getActiveEnemies())
--         do
--         Kristal.Console:log("npc is " .. tostring(enemy.id))
--         if (enemy.id == "maskaught")
--             then
--             local returnTarget
--             if (self.party[1].chara.id == "ralsei") then returnTarget = 1 end
--             if (self.party[2].chara.id == "susie") then returnTarget = 2 end
--             if (self.party[3].chara.id == "kris") then returnTarget = 3 end
--             Kristal.Console:log("returntarget " .. tostring(returnTarget))
--             return self.party[returnTarget]
--             end
--         end
-- return thinge10
-- end)


--



-- function ActionButton:select()


   end
local Dummy, super = Class(EnemyBattler)

function Dummy:init()
    super.init(self)

    -- Enemy name
    self.name = "Omega Wilter"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("omeg_wilter")

    self:setAnimation("battle")

    -- Enemy health
    self.max_health = 6400
    self.health = 6400
    -- Enemy attack (determines bullet damage)
    self.attack = 18
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = 0
    self.defeat_type = "fatal"
    self.tired_percentage = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "eye_lines"
    }

    self.auto_spare = true

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "Call's for help's,\nI dare's you!",
        "Have's you's forgotten\nwhat's I taught's you..?",
        "I just want to help you,\nKris.",
        "You's want some's LOVE,\ndon't's you?",
        "It's me's!\nYour's best friend's!"
        
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 18 DF 15\n* Your best friend till the end."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The audience is staring at you...",
        "* Smells like dying plants.",
        "* Wilter stares at the sky,\n* The sky stares back.",
        "* The audience is singing a song.\n* It's for you... "
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = nil

    -- Register act called "Smile"
    self:registerAct("Play Together", "Induce\nMercy", nil, 24)
    if Kristal.Config["debug"] then
        self:registerAct("Instaspare", "Induce\nMercy")
    end
    Game.battle:registerXAction("susie", "WeedKiller", "Hurt Enemy\nand User.", 65)
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Light Shine", "Induce\nMercy", {"susie", "ralsei"}, 75)
    --self:registerAct("Spare RIGHT NOW")

    if Kristal.Config["challenge"] == true then
        self.current_target = "ALL"
    elseif Kristal.Config["challenge"] == false then
        self.current_target = "ANY"
    end
end

function Dummy:onAct(battler, name)

    if Kristal.Config["debug"] then
        if name == "Instaspare" then
            self:addMercy(100)
            return "* Hi"
        end
    end

    if name == "Play Together" then
        -- Give the enemy 100% mercy
        self:addMercy(3)
        -- Change this enemy's dialogue for 1 turn

        -- Act text (since it's a list, multiple textboxes)
        if Game.battle.turn_count % 2 == 1 then
            if Game:getFlag("soul_chargetime") >= 0.5 then
                Game:setFlag("soul_chargetime", Game:getFlag("soul_chargetime") - 0.1)
                Game:setFlag("bul_speed", Game:getFlag("bul_speed") + 0.1)
                return {
                    "* You play a game with Wilter\ndistracting him for a moment.[wait:5]\n* And...",
                    "[sound:cardrive]* Kris and Wilter both got energized![wait:5]\n* Soul recharge time down![wait:5]\n* Incoming attacks get faster!"
                }
            else
                return {
                    "* You play a game with Wilter\ndistracting him for a moment.[wait:5]\n* And...",
                    "[sound:cardrive]* Kris and Wilter both got energized![wait:5]\n* But they're already at the top of their rush!"
                }
            end
        else
            if Game:getFlag("soul_chargetime") < 3 then
                Game:setFlag("soul_chargetime", Game:getFlag("soul_chargetime") + 0.5)
                Game:setFlag("bul_speed", Game:getFlag("bul_speed") - 0.1)
                return {
                    "* You play a game with Wilter\ndistracting him for a moment.[wait:5]\n* And...",
                    "[sound:awkward]* Kris and Wilter both get tired.[wait:5]\n* Soul recharge time goes up.[wait:5]\n* Incoming attacks get slower."
                }
            else
                return {
                    "* You play a game with Wilter\ndistracting him for a moment.[wait:5]\n* And...",
                    "[sound:awkward]* Kris and Wilter both get tired.[wait:5]\n* But they're already at their lowest."
                }
            end
        end

    elseif name == "Light Shine" then
        Game.battle:startActCutscene("wilter", "shine")
    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(2)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            if self.defense > -4 then
                self.defense = self.defense - 2
                return {
                    "* Ralsei said some enlightening words.\n[wait:5]* Wilter's eyes widen for a brief moment.",
                    "* Wilter's Defense went down!"
                }
            else
                self.attack = self.attack + 1
                return {
                    "* Ralsei said some enlightening words.\nWilter's realizes Ralsei is repeating himself.",
                    "* Wilter's Attack went up!"
                }
            end
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            if self.attack > 11 then
                self.attack = self.attack - 2
                return {
                    "* Susie ignored Wilter.[wait:5]\n* He begins to get desparate.",
                    "* Wilter's Attack went down!"
                }
            else
                self.defense = self.defense + 1
                return {
                    "* Susie ignored Wilter[wait:5].\n* He tries to seem like he doesn't care.",
                    "* Wilter's Defense went up!"
                }
            end
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."

            
        end
    elseif name == "WeedKiller" then
        local user = "susie"
        local user_index = Game.battle:getPartyIndex(user)
        local user_battler = Game.battle:getPartyBattler(user)
        local spell = Registry.createSpell("weedkiller")
        local target = self
        local menu_item = {
            data = spell,
            tp = 0,
        }
        Game.battle:pushAction("SPELL", target, menu_item, user_index)
        Game.battle:markAsFinished(nil, {user})
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Dummy:update()
    super.update(self)
    if Kristal.Config["challenge"] == true then
        self.current_target = "ALL"
    elseif Kristal.Config["challenge"] == false then
        self.current_target = "ANY"
    end
end

function Dummy:onDefeat(damage, battler)
    Game.world.fader:fadeOut()
    Game:setFlag("wilter_killed", true)
    Game:setFlag("wilter_spared", false)
    Game:setFlag("wilterdefeated", true)
    self:defeat("VIOLENCED")
end

function Dummy:spare()
    Game.world.fader:fadeOut()
    Game.world.music:stop()
    Game:setFlag("wilter_spared", true)
    Game:setFlag("wilter_killed", false)
    Game:setFlag("wilterdefeated", true)
    self:defeat("SPARED")
end

function Dummy:onTurnEnd()
    Game.battle.timer:after(1, function ()
        if Game:getFlag("tens_pause_used") then
            Game:setFlag("bul_speed", Game:getFlag("bul_speed_prev"))
            Game:setFlag("tens_pause_used", false)
        end
    end)
end

return Dummy
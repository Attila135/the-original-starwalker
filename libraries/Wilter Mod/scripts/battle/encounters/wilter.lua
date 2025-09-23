local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* It's time to wake up and smell the flowers!\n(Use [Z] to dash.)"

    -- Battle music ("battle" is rude buster)
    if not Kristal.Config["challenge"] then
        if not Kristal.Config["battlemusic"] then
            self.music = "she_loves_me_not"
        else
            self.music = "she_loves_me_not_2"
        end
    else
        self.music = "scare_loves_me_not"
    end
    -- Enables the purple grid battle background
    self.background = false

    -- Add the wilter enemy to the encounter
    self.wilter = self:addEnemy("wilter", 476, 268)

    self.no_end_message = true

    self.phase = 1
    self.phase_previous = 1

    --- Uncomment this line to add another! (do not)
    --self:addEnemy("wilter")

    self.turn = 1
    Game:setFlag("speed_turns", 0)
    Game:setFlag("soul_speed", 1)
    Game:setFlag("bul_speed", 1)
    Game:setFlag("bul_speed_prev", 1)
    Game:setFlag("soul_chargetime", 1)

    if Kristal.Config["challenge"] == true then
        for _, member in ipairs(Game.party) do
            member.stats.health = 1
            member.health = 1
            member.max_stats.health = 1
        end
    elseif Kristal.Config["challenge"] == false then
        if Game.party[1] then
            Game.party[1].stats.health = 160
            Game.party[1].health = 160
            Game.party[1].max_stats.health = 160
        end
        if Game.party[2] then
            Game.party[2].stats.health = 190
            Game.party[2].health = 190
            Game.party[2].max_stats.health = 190
        end
        if Game.party[3] then
            Game.party[3].stats.health = 140
            Game.party[3].health = 140
            Game.party[3].max_stats.health = 140
        end
    end

    self.highlight = Game.world:addChild(Sprite("objects/wilter_pillars_highlight", 0, 0))
    self.highlight:setLayer(0.16)
    self.highlight.alpha = 0
    Game.battle.timer:tween(0.25, self.highlight, {alpha = 1}, "out-quad")

end

function Dummy:onBattleStart()
    super.onBattleStart(self)
    Game.battle.timer:tween(0.25, self.highlight, {alpha = 0}, "in-quad")
    self.backgroundImage = Game.world:addChild(Sprite("tilesets/wilter_tileset_real", 0, 0))
    self.backgroundImage:setLayer(0.15)
    self.backgroundImage:setScale(1)
    self.backgroundImage:play(0.1, true)
    Game.battle.timer:after(0.5, function ()
        self.highlight:remove()
    end)
end

function Dummy:getPartyPosition(index)
    local x, y = 0, 0
    if index == 1 then
        x, y = 148, 220
    elseif index == 2 then
        x, y = 67, 271
    elseif index == 3 then
        x, y = 115, 316
    end
    return x, y
end

function Dummy:checkProgress(mercy, health)
    if self.wilter.mercy >= mercy then return true end
    if self.wilter.health <= health then return true end
    return false
end

function Dummy:onActionsEnd()
    if not self:checkProgress(100, 0) then
        self.phase_previous = self.phase
        if self.turn == math.huge then
            if self:checkProgress(75, self.wilter.max_health*0.25) then
                self.turn = 1
                self.phase = 4
            elseif self:checkProgress(50, self.wilter.max_health*0.5) then
                self.turn = 1
                self.phase = 3
            elseif self:checkProgress(25, self.wilter.max_health*0.75) then
                self.turn = 1
                self.phase = 2
            end
        end
        Game:setFlag("wilter_turn", self.turn)
        Game:setFlag("wilter_phase", self.phase)
        Game:setFlag("wilter_phase_past", self.phase_previous)
        self.phase_previous = self.phase


        if self.phase == 1 then
            do -- Useless block because it used to be "if not self.loop == true then...", like what does that even mean?
                if self.turn == 1 then
                    Game.battle.enemies[1].dialogue_override = {
                        "Kris,[wait:5]\nIsn'ts this justs amazing?"
                    }
                    Game.battle.enemies[1].wave_override = "friendliness_pellets_1"
                elseif self.turn == 2 then
                    Game.battle.enemies[1].dialogue_override = {
                        "A world's where we don't's\nhave to suffer's!",
                        "A world's without's pain's!"
                    }
                    Game.battle.enemies[1].wave_override = "eye_lines"
                elseif self.turn == 3 then
                    Game.battle.enemies[1].dialogue_override = {
                        "Why live's in the's present,[wait:5]\nwhen the's past was\n so much better's?"
                    }
                    Game.battle.enemies[1].wave_override = "throw_pellets"
                elseif self.turn == 4 then
                    Game.battle.enemies[1].dialogue_override = {
                        "A world's where she'll\nlove's us again.",
                        "A world where I won't\nbe alone anymore..."
                    }
                    Game.battle.enemies[1].wave_override = "she_loves_me"
                    self.turn = math.huge
                else
                    Game.battle.enemies[1].wave_override = Utils.pick{"friendliness_pellets_1", "eye_lines", "throw_pellets", "she_loves_me"}
                end
            end
        elseif self.phase == 2 then
            do -- Useless block because it used to be "if not self.loop == true then...", like what does that even mean?
                if self.turn == 1 then
                    Game.battle.enemies[1].dialogue_override = {
                        "Kris,[wait:5]\nask yourself's this...",
                        "Is this really\nthe life you want to live?"
                    }
                    Game.battle.enemies[1].wave_override = "vine_grab"
                elseif self.turn == 2 then
                    Game.battle.enemies[1].dialogue_override = {
                        "All I need's is that soul's",
                        "Then,\nI can's RESET it ALL'S!"
                    }
                    Game.battle.enemies[1].wave_override = "blossom"
                elseif self.turn == 3 then
                    Game.battle.enemies[1].dialogue_override = {
                        "I don't get it..",
                        "WHY DO YOU KEEP ON FIGHTING"
                    }
                    Game.battle.enemies[1].wave_override = "teeth"
                elseif self.turn == 4 then
                    Game.battle.enemies[1].dialogue_override = {
                        "Do you's think you can's just...",
                        "MOVE'S ON!?!?",
                        "HAH,\nAS IF!"
                    }
                    Game.battle.enemies[1].wave_override = "she_loves_me2"
                    self.turn = math.huge
                else
                    Game.battle.enemies[1].wave_override = Utils.pick{"vine_grab", "blossom", "teeth", "she_loves_me2"}
                end
            end
        elseif self.phase == 3 then
            do -- Useless block because it used to be "if not self.loop == true then...", like what does that even mean?
                if self.turn == 1 then
                    Game.battle.enemies[1].dialogue_override = {
                        "In this world's,\nit's FORGET'S OR BE FORGOTTEN.",
                        "I WON'T LET'S YOU\nFORGET'S ME, KRIS.",
                        "Not NOW,\nnot EVER!"
                    }
                    Game.battle.enemies[1].wave_override = "friendliness_pellets_2"
                elseif self.turn == 2 then
                    Game.battle.enemies[1].dialogue_override = {
                        "I won't be's left\nalone's anymore.",
                        "It's so dark down here.",
                        "So very,\nvery dark."
                    }
                    Game.battle.enemies[1].wave_override = "spotlight"
                elseif self.turn == 3 then
                    Game.battle.enemies[1].dialogue_override = {
                        "Your past's will\nalways's follow you's.",
                        "Your actions have consequences,\nafter all."
                    }
                    Game.battle.enemies[1].wave_override = "eye_lines_2"
                elseif self.turn == 4 then
                    Game.battle.enemies[1].dialogue_override = {
                        "I just want to\nbe loved.",
                        "I don't want to\nbe forgotten.",
                        "Please,\nToriel.",
                        "Won't you love me\nlike you used to..?"
                    }
                    Game.battle.enemies[1].wave_override = "hand_puppets_skerch"
                    self.turn = math.huge
                else
                    Game.battle.enemies[1].wave_override = Utils.pick{"friendliness_pellets_2", "spotlight", "eye_lines_2", "hand_puppets_skerch"}
                end
            end
        elseif self.phase == 4 then
            do -- Useless block because it used to be "if not self.loop == true then...", like what does that even mean?
                if self.turn == 1 then
                    Game.battle.enemies[1].dialogue_override = {
                        "If she won't love me...",
                        "Then nobody will.",
                        "But's YOU love's me, right!?",
                        "I'LL MAKE YOU LOVE ME!",
                        "ISN'T THAT A WONDERFUL IDEA!?"
                    }
                    Game.battle.enemies[1].wave_override = "wilter/final"
                elseif self.turn == 2 then
                    Game.battle.enemies[1].dialogue_override = {
                        "Your past's will\nalways's follow you's.",
                        "Your actions have consequences,\nafter all."
                    }
                    Game.battle.enemies[1].wave_override = "friendliness_pellets_2"
                elseif self.turn == 3 then
                    Game.battle.enemies[1].dialogue_override = {
                        "I won't be's left\nalone's anymore.",
                        "It's so dark down here.",
                        "So very,\nvery dark."
                    }
                    Game.battle.enemies[1].wave_override = "spotlight"
                elseif self.turn == 4 then
                    Game.battle.enemies[1].dialogue_override = {
                        "I just want to\nbe loved.",
                        "I don't want to\nbe forgotten.",
                        "Please,\nToriel.",
                        "Won't you love me\nlike you used to..?"
                    }
                    Game.battle.enemies[1].wave_override = "hand_puppets_skerch"
                    self.turn = 0
                else
                    Game.battle.enemies[1].wave_override = Utils.pick{"blossom", "teeth", "vine_grab", "hand_puppets_skerch"}
                end
            end
        end
    else
        Game.fader:fadeOut()
    end
end


function Dummy:onTurnEnd()
    self.turn = self.turn + 1

    if Game:getFlag("speed_turns") > 0 then
        Game:setFlag("speed_turns", Game:getFlag("speed_turns")-1)
    else
        Game:setFlag("soul_speed", 1)
    end

    if self:checkProgress(75, 625) then
        Game.battle.battle_ui.encounter_text:setText("Wilter is preparing something,\nget ready to smash anything in your way.")
    end
end


function Dummy:onBattleEnd()
    
end

return Dummy
local Starwalker, super = Class(EnemyBattler)

function Starwalker:init()
    local kris = Starwalker:getCharacter("kris")
    super.init(self)

    self.name = "Starwalker"
    self:setActor("starwalker")

    self.path = "enemies/starwalker"
    self.default = ""
    self.sprite:set("wings")

    self.tired_percentage = 0.0;
    self.max_health = 5500
    self.health = 5500
    if kris then
        self.attack = 5
    else
        self.attack = 10
    end
    self.defense = 15
    self.money = 978453186765

    self.spare_points = 0

    self.exit_on_defeat = true

    self.check = {
        "The REAL battle begins"
    }

    self.text = {
        "* Star walker",
        "* Smells like   [wait:5][color:yellow]pissed off[color:reset]",
        "*               this encounter\n is against star  walker",
        "* this [color:yellow]battle[color:reset] is     [color:yellow]pissing[color:reset] me\noff..."
    }

    self.low_health_text = "* Star walker has      hurt"

    self:registerAct("BegForMercy", "")
    self:registerAct("BegForMercyX", "", "all")
    self:registerAct("Red Buster", "Red\nDamage", "susie", 50)
    self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)
    self:registerAct("SnowGrave", "Fatal", "noelle", 100)
    self.text_override = nil

    self.old_x = self.x
    self.old_y = self.y

    self.mode = "normal"
    self.ease = false

    self.ease_timer = 0

    self.timer = 0

    self.progress = 0

    self.waves = {
        "lonewolf_parade/flowers_1_starwalker",
        "godhome/pufferfish_starwalker",
        "wilter/hand_puppets_starwalker",
        "vs_kris/pre_final_starwalker",
        "frozzen_heart/iceshocks_starwalker",
        "frozzen_heart/snowstorm_starwalker",
        "lumia/carousel_hard_starwalker",
        "teeth", --wilter/teeth_starwalker
        "lonewolf_parade/raven_c_starwalker",
        "vs_kris/fire_slice_starwalker",
        "lonewolf_parade/flowers_3_starwalker",
        "godhome/chaosbomb_starwalker",
        "starwings_NEO_starwalker",
        "vs_kris/final_starwalker",
        "godhome/sword_rows_starwalker",
        "lonewolf_parade/claw_b_starwalker",
        "frozzen_heart/dark_star_attack_starwalker",
        "vs_kris/glove_more_starwalker",
        "frozzen_heart/iceshocks_NEO_starwalker",
        "vs_kris/fire_slice_NEO_starwalker",
        "lonewolf_parade/prophecybreaker_starwalker"
    }

    self.blue = false
end

function Starwalker:onTurnEnd()
    self.progress = self.progress + 1
end

function Starwalker:getEncounterText()
    if (self.progress == 2) then
        return "* Star walker is preparing\n[color:blue]something [offset:0,-8][color:red][font:main_mono,48]!!"
    end
    return super.getEncounterText(self)
end

function Starwalker:getNextWaves()
    --[[if true then
        self.blue = true
        return {"starup"}
    end]]


    if (self.progress == 0) then
        return { "lonewolf_parade/flowers_1_starwalker" }
    elseif (self.progress == 1) then
        return { "godhome/pufferfish_starwalker" }
    elseif (self.progress == 2) then
        return { "wilter/hand_puppets_starwalker" }
    elseif (self.progress == 3) then
        return { "vs_kris/pre_final_starwalker" }
    elseif (self.progress == 4) then
        return { "frozzen_heart/iceshocks_starwalker" }
    elseif (self.progress == 5) then
        return { "frozzen_heart/snowstorm_starwalker" }
    elseif (self.progress == 6) then
        return { "lumia/carousel_hard_starwalker" }
    elseif (self.progress == 7) then
        return { "teeth" } --wilter/teeth_starwalker
    elseif (self.progress == 8) then
        return { "lonewolf_parade/raven_c_starwalker" }
    elseif (self.progress == 9) then
        return { "vs_kris/fire_slice_starwalker" }
    elseif (self.progress == 10) then
        return { "lonewolf_parade/flowers_3_starwalker" }
    elseif (self.progress == 11) then
        return { "godhome/chaosbomb_starwalker" }
    elseif (self.progress == 12) then
        return { "starwings_NEO_starwalker" }
    elseif (self.progress == 13) then
        return { "vs_kris/final_starwalker" }
    elseif (self.progress == 14) then
        return { "godhome/sword_rows_starwalker" }
    elseif (self.progress == 15) then
        return { "lonewolf_parade/claw_b_starwalker" }
    elseif (self.progress == 16) then
        return { "frozzen_heart/dark_star_attack_starwalker" }
    elseif (self.progress == 17) then
        return { "vs_kris/glove_more_starwalker" }
    elseif (self.progress == 18) then
        return { "frozzen_heart/iceshocks_NEO_starwalker" }
    elseif (self.progress == 19) then
        return { "vs_kris/fire_slice_NEO_starwalker" }
    elseif (self.progress == 20) then
        return { "lonewolf_parade/prophecybreaker_starwalker" }
    end

    return super.getNextWaves(self)
end

function Starwalker:setMode(mode)
    self.mode = mode
    self.old_x = self.x
    self.old_y = self.y
    self.ease = true
    self.ease_timer = 0
end

function Starwalker:update()
    super.update(self)

    if not self.done_state and (Game.battle:getState() ~= "TRANSITION") then
        self.timer = self.timer + (1 * DTMULT)

        local wanted_x = self.old_x
        local wanted_y = self.old_y

        if self.mode == "normal" then
            wanted_x = 530 + (math.sin(self.timer * 0.08) * 20)
            wanted_y = 238 + (math.sin(self.timer * 0.04) * 10)
        elseif self.mode == "shoot" then
            wanted_x = 530 - 40 + (math.sin(self.timer * 0.08) * 10)
            wanted_y = 238 - 50 + (math.sin(self.timer * 0.04) * 40)
        elseif self.mode == "still" then
            wanted_x = 530 - 40
            wanted_y = 238 - 50
        end

        if not self.ease then
            self.x = wanted_x
            self.y = wanted_y
        else
            self.ease_timer = self.ease_timer + (0.05 * DTMULT)
            self.x = Ease.outQuad(self.ease_timer, self.old_x, wanted_x - self.old_x, 1)
            self.y = Ease.outQuad(self.ease_timer, self.old_y, wanted_y - self.old_y, 1)
            if self.ease_timer >= 1 then
                self.ease = false
            end
        end
    end

    for _, enemy in pairs(Game.battle.enemy_world_characters) do
        enemy:remove()
    end
end

function Starwalker:onSpared()
    super.onSpared(self)

    self.sprite:resetSprite()
    Game.battle.music:stop()
end

function Starwalker:isXActionShort(battler)
    return true
end

function Starwalker:onActStart(battler, name)
    super.onActStart(self, battler, name)
end

function Starwalker:onAct(battler, name)
    if name == "DualHeal" then
        Game.battle:powerAct("dual_heal", battler, "ralsei")
    elseif name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
    elseif name == "SnowGrave" then
        Game.battle:powerAct("snowgrave", battler, "noelle", self)
    elseif name == "BegForMercy" then
        self:addMercy(2)
        return "* You beged for mercy"
    elseif name == "BegForMercyX" then
        self:addMercy(6.0001)
        return "* Everyone beged for mercy"
    elseif name == "Standard" then
        self:addMercy(2)
        if battler.chara.id == "ralsei" then
            return "* Ralsei beged for mercy"
        elseif battler.chara.id == "susie" then
            return "* Susie beged for mercy"
        elseif battler.chara.id == "noelle" then
            return "* Noelle beged for mercy"
        end
    end
    return super.onAct(self, battler, name)
end

function Starwalker:onShortAct(battler, name)
    if name == "Standard" then
        self:addMercy(2)
        if battler.chara.id == "ralsei" then
            return "* Ralsei beged for mercy"
        elseif battler.chara.id == "susie" then
            return "* Susie beged for mercy"
        elseif battler.chara.id == "noelle" then
            return "* Noelle beged for mercy"
        end
    end
    return nil
end

function Starwalker:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "Aough",
            "You wi"
        }
    else
        dialogue = {
            "star",
            "walkin",
            "stark",
            "warper",
            "starwalker",
            "[style:dark_menu][color:yellow]Pissing",
            "me off",
        }
    end
    return dialogue[math.random(#dialogue)]
end

return Starwalker

local Kris, super = Class(Encounter)

function Kris:init()
    super.init(self)
    
    self.turns = 0
    
    self.enemy = self:addEnemy("kris-werid-route", 520, 277)
    self.enemy.actor.default = "battle/idle"
    self.enemy.sprite:setAnimation(self.enemy.actor.default)
    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Kris blocks your way."

    -- Battle music ("battle" is rude buste
    self.music = Music()
    --self.real_music = Music()
    if Mod.flags.Vs_Kris then
    self.music:play("vs_kris")
    elseif Mod.flags.Burning_HOPE then
    self.music:play("burning-hope")
    elseif Mod.flags.Your_Destiny then
    self.music:play("your-destiny")
    end
    self.music:setPitch(0.9)
    function Kris:onGameOver()
    self.music:remove()
    Game:setFlag("route", 2)
    end
    --self.music:setPitch(0.5)
    -- Enables the purple grid battle background
    self.background = false

    --- Uncomment this line to add another!
    --self:addEnemy("Kris")
end

function Kris:onTurnEnd()
    self.turns = self.turns + 1

if self.turns == 1 then
    self.enemy.waves = {
        "werid_route/slash_move"
    }
elseif self.turns == 2 then
    self.enemy.waves = {
        "werid_route/fast_slash"
    }
elseif self.turns == 3 then
    self.enemy.waves = {
        "werid_route/glove"
    }
elseif self.turns == 4 then
    self.enemy.waves = {
        "werid_route/glove_more"
    }
elseif self.turns == 5 then
    self.enemy.waves = {
        "werid_route/knives"
    }
elseif self.turns == 6 then
    self.enemy.waves = {
        "werid_route/knives_slice"
    }
elseif self.turns == 7 then
    self.enemy.waves = {
        "werid_route/fire_slice"
    }
elseif self.turns == 8 then
    self.enemy.waves = {
        "werid_route/pre_final"
    }
elseif self.turns == 9 then
    self.enemy.waves = {
        "werid_route/final"
    }
end
local K_cutscene
    if self.turns==10 then
        self.enemy.waves = {
            nil
        }
        self.enemy.text = {
            ""
        }

    K_cutscene = function(cutscene, enemy)
        --cutscene:after(function()  end)
    --Game.battle:setState("TRANSITIONOUT")
    self.music:remove()
    self.enemy.sprite:setSprite("tired")
    Game.battle.party[1].sprite:setAnimation("battle/victory", nil, false)
    --Game.battle.party[1]:resetSprite()
    Game.battle.battle_ui:transitionOut()
    Game.battle.tension_bar:hide()
    cutscene:wait(1)
    Game.battle:returnToWorld()
    Game.world:startCutscene("kris_encounter", "weird")
    end
        Mod.flags = {
            Can_kill = true,
        }
        self.enemy.defense = -900
        self.enemy:setTired(true)
end
if K_cutscene then
    Game.battle:startCutscene(K_cutscene)
    return true
end
end

function Kris:getPartyPosition(index)
    local x, y = 0, 0
    if index == 1 then
        x, y = 120, 277
    end
    return x, y
  end

return Kris
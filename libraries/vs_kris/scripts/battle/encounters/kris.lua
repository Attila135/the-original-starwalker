local Kris, super = Class(Encounter)

function Kris:init()
    super.init(self)
    
    self.turns = 0
    
    self.enemy = self:addEnemy("kris", 520, 277)
    self.enemy.actor.default = "battle/idle"
    self.enemy.sprite:setAnimation(self.enemy.actor.default)
    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Kris freed from the chains."

    -- Battle music ("battle" is rude buster)
    if Mod.flags.Vs_Kris then
    self.music = "vs_kris"
    elseif Mod.flags.Burning_HOPE then
    self.music = "burning-hope"
    elseif Mod.flags.Your_Destiny then
    self.music = "your-destiny"
    end
    -- Enables the purple grid battle background
    self.background = false

    --- Uncomment this line to add another!
    --self:addEnemy("Kris")
end

function Kris:onTurnEnd()
    self.turns = self.turns + 1

if self.turns == 1 then
    self.enemy.waves = {
        "slash_move"
    }
elseif self.turns == 2 then
    self.enemy.waves = {
        "fast_slash"
    }
elseif self.turns == 3 then
    self.enemy.waves = {
        "glove"
    }
elseif self.turns == 4 then
    self.enemy.waves = {
        "glove_more"
    }
elseif self.turns == 5 then
    self.enemy.waves = {
        "knives"
    }
elseif self.turns == 6 then
    self.enemy.waves = {
        "knives_slice"
    }
elseif self.turns == 7 then
    self.enemy.waves = {
        "glove_slice"
    }
elseif self.turns == 8 then
    self.enemy.waves = {
        "final"
    }
end
local K_cutscene
    if self.turns==9 then
        self.enemy.waves = {
            nil
        }
        self.enemy.text = {
            "* Choice."
        }
        K_cutscene = function(cutscene, enemy)
            cutscene:after(function() Game.battle:setState("ACTIONSELECT") end)
        Game.battle.music:stop()
        self.enemy.sprite:setSprite("give_up")
        self.enemy.sprite:shake(4)
        Assets.playSound("noise")
        cutscene:wait(2)
        Assets.playSound("noise")
        self.enemy.sprite:shake(4)
        cutscene:wait(2)
        Assets.playSound("wing")
        Sprite("patry/kris/fell", 520, 277)
        self.enemy.sprite:setAnimation("tear/tired", nil, true)
        cutscene:wait(5)
        self.enemy.sprite:setAnimation("tear/tear", nil, false)
        cutscene:wait(1)
        cutscene:text("* .[wait:10].[wait:10].", "LookingAway", "kris")
        cutscene:text("* .[wait:10].[wait:10].[wait:10]why.[wait:10].[wait:10].[wait:10]?", "LookingAway", "kris")
        cutscene:text("* .[wait:10].[wait:10].[wait:10]why.[wait:10].[wait:10].", "silent", "kris")
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
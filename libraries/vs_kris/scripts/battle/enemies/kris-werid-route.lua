local Kris, super = Class(EnemyBattler)

function Kris:init()
    super.init(self)

    -- Enemy name
    self.name = "Kris"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/Kris.lua)
    self:setActor("kris")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = 1000
    -- Enemy reward
    self.money = 100
    self.progress = 0
    self.reason_progress = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "werid_route/slash"
    }
    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = nil

    self.hurt = nil

    self.disable_mercy = true

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 14 DF 6\n* An useless vessel."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* In your way.",
        "* Kris is genuinely scared of you.",
        "* End of the line.",
        "* With you in the dark.",
        "* Just another enemy.",
        "* No matter now.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    
    --self.low_health_text = "* The Kris looks like it's\nabout to fall over."

    -- Register act called "Smile"
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
end

function Kris:onHurt()
    if self.progress == 0 then
    self.hurt = true
    end
end

function Kris:hurt(amount, battler, on_defeat, color, show_status, attacked)
    if amount == 0 or (amount < 0 and Game:getConfig("damageUnderflowFix")) then
        if show_status ~= false then
            self:statusMessage("msg", "blocked", color or (battler and {battler.chara:getDamageColor()}))
        end

        self:onDodge(battler, attacked)
        return
    end

    self.health = self.health - amount
    if show_status ~= false then
        self:statusMessage("msg", "death")
    end

    if amount > 0 then
        self.hurt_timer = 1
        self:onHurt(amount, battler)
    end

    self:checkHealth(on_defeat, amount, battler)
end

function Kris:onDodge()
    if self.progress == 0 then
    self.hurt = true
    end

    Assets.playSound("damage")
    self:toggleOverlay(true)
    if not self:getActiveSprite():setAnimation("hurt") then
        self:toggleOverlay(false)
    end
    self:getActiveSprite():shake(9, 0, 0.5, 2/30)

    Game.battle.timer:after(1.2069, function() 
        self:getActiveSprite():stopShake()
        self:toggleOverlay(false)
        self.sprite:resetSprite()
      end)
end

function Kris:onAct(battler, name)
    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Kris:getEnemyDialogue()
    local dialogue
    if self.progress == 0 then
        self.progress = 1

    if self.hurt == true then
        self.hurt = nil
        dialogue = {
            "Of course. [wait:10]Of course\nyou'd fight...",
            "Not like you've done\notherwise,[wait:10] am I right?"
        }
    else
        dialogue = {
            "What wrong?\n[wait:10]Too scared to move?[wait:10]\nYou of all people?",
            "It's not like you, Normally,\nyou'd have\nattacked already.",
        }
       end
    elseif self.progress == 1 then
        self.progress = 2
        dialogue = {
            "You know...",
            "This place was beautiful\nbefore you came."
        }
    elseif self.progress == 2 then
        self.progress = 3
        dialogue = {
            "Worst part is:\nI couldn't appreciate it\nbefore you took\nit from me."
        }
    elseif self.progress == 3 then
        self.progress = 4
        dialogue = {
            "One day,[wait:10] you\ncame and.[wait:10].[wait:10].",
            "you tore my\nlife apart..."
        }
    elseif self.progress == 4 then
        self.progress = 5
        dialogue = {
            "But it wasn't\njust me you hurt!"
        }
    elseif self.progress == 5 then
        self.progress = 6
        dialogue = {
            "You also hurt\nNoelle, and\nBerdly, and\nRalsei, and\nSusie!"
        }
    elseif self.progress == 6 then
        self.progress = 7
        dialogue = {
            "You destroyed their\nlifes,[wait:5]\nusing my own body!",
            "You made me watch,\n[wait:5]powerless,[wait:5] as you\ndid so!"
        }
    elseif self.progress == 7 then
        self.progress = 8
        dialogue = {
            "Ever now,[wait:5] you still\ntry to get away with\nwhat you did!"
        }
    elseif self.progress == 8 then
        self.progress = 9
        dialogue = {
            "I knew people\ncould be evil...",
            "But you have proven\nthat to be a HUGE\nunderstatement!"
        }
    elseif self.progress == 9 then
        self.progress = 10
        dialogue = {
            "No matter what you do,[wait:5]\nYou won't get away\nwith this!",
            "...you can't..."
        }
    else
        dialogue = nil
    end
    return dialogue
end

function Kris:onDefeat(damage, battler)
	Game.battle:setState("CUTSCENE")

    Game.battle:startCutscene("kris", "kill", self)

    Game.battle:resetAttackers();   
	Game.battle.processing_action = false

	Game.battle.should_finish_action = false
	Game.battle.on_finish_keep_animation = nil
	Game.battle.on_finish_action = nil

    -- self.defeated = true
    -- self:defeat("VIOLENCED", true)

    if Game.battle.battle_ui.attacking then
        Game.battle.battle_ui:endAttack()
    end
end

return Kris
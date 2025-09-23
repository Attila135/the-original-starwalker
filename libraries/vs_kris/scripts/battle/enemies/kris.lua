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
        "slash"
    }
    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = nil

    self.hurt = nil

    self.disable_mercy = true

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 14 DF 6\n* They won't listen you."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Kris drew their blade.",
        "* The atmosphere is tense.",
        "* End of the line.",
        "* With you in the dark.",
        "* End.",
        "* Is freedom real?",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    
    --self.low_health_text = "* The Kris looks like it's\nabout to fall over."

    -- Register act called "Smile"
    self:registerAct("Reason")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
end

function Kris:onHurt()
    if self.progress == 0 then
    self.hurt = true
    end

    if Mod.flags.Can_kill then
        self.sprite:setSprite("tear/look_hurt")
        --Game.battle:startActCutscene("kris", "kill")
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
    if name == "Reason" then
        -- Act text (since it's a list, multiple textboxes)
        if self.reason_progress == 0 then
            self.reason_progress = 1
        return {
            "* You tried to say something to Kris.[wait:10]\n* But They didn't listen."
        }
        elseif self.reason_progress == 1 then
            self.reason_progress = 2
        return {
            "* You told Kris this won't accomplish anything.[wait:10]\n* But they don't care."
        }
        elseif self.reason_progress == 3 then
            self.reason_progress = 4
        Game.battle:startActCutscene("kris", "reason")
        else
        return {
            "* STOP![wait:20] This won't do anything.[wait:5].[wait:5].\n* They won't listen to you, and[wait:10] can you blame them?"
        }
        end
    end

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
            "What? [wait:10]You thought\nI'd let you hit me?",
            "C'mon,[wait:10] I'm not\nthat dense.",
            "Then again,[wait:10]\nhow'd YOU know?"
        }
    else
        dialogue = {
            "What wrong?\n[wait:10]Too scared to move?",
            "I understand.",
            "After all,[wait:10] it's not\nevery day you meet\nyour demise."
        }
       end
    elseif self.progress == 1 then
        self.progress = 2
        dialogue = {
            "I had a life before\nyou came,[wait:10] you know?"}
    elseif self.progress == 2 then
        self.progress = 3
        dialogue = {
            "Maybe it wasn't the greatest,[wait:10]\nbut it was still mine."
        }
    elseif self.progress == 3 then
        self.progress = 4
        dialogue = {
            "Then,[wait:10] one day\nwithout any warning.[wait:10].[wait:10].",
            "You came along."
        }
    elseif self.progress == 4 then
        self.progress = 5
        dialogue = {
            "You CONTTOL me,\n[wait:5]DECIDE for me.[wait:5].[wait:5].",
            "Can you even imagine\nfeeling like that?"
        }
    elseif self.progress == 5 then
        self.progress = 6
        dialogue = {
            "Did You think You were\nabove consequences?",
            "Did You think\nYou could do[wait:15][shake:2]\nWHATEVER YOU WANTED TO!?"
        }
    elseif self.progress == 6 then
        self.progress = 7
        dialogue = {
            "[shake:2]WHY!?[wait:15] WHY DID YOU DO IT!?[wait:15]\n[shake:1]DID YOU[wait:5].[wait:5].[wait:5].[wait:5]!",
            "[wait:5].[wait:5].[wait:5]. did you really\nhate me that much.[wait:5].[wait:5].[wait:5]?"
        }
    elseif self.progress == 7 then
        self.progress = 8
        dialogue = {
            "Or you were\njust bored?",
            "Maybe you thought\nthis'd be funny."
        }
    elseif self.progress == 8 then
        self.progress = 9
        self.reason_progress = 3
        dialogue = {
            "Or maybe You did\nit because[wait:5].[wait:5].[wait:5].",
            "[wait:5].[wait:5].[wait:5]. because[wait:5].[wait:5].[wait:5]."
        }
        self.check = "AT 14 DF 6\n* Too tired to fight."
        self.defense = -900
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
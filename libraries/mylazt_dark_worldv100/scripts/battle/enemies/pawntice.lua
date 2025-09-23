local Pawntice, super = Class(EnemyBattler)

function Pawntice:init()
    super.init(self)

    -- Enemy name
    self.name = "Pawntice"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("pawntice")

    -- Enemy health
    self.max_health = 450
    self.health = 450
    -- Enemy attack (determines bullet damage)
    self.attack = 4
    -- Enemy defense (usually 0)
    self.defense = -2
    -- Enemy reward
    self.money = 100
    self.isHatted = true;
    self.hatMessage = "";
    self.hairMessage = "";
    self.petMessage = "";
    self.feedMessage = "";
    self.horrorMessage = "";

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 8 DF -2\n* Looks a little lost."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Pawntice is wearing its scarf\ninside out.",
        "* Pawntice shuffles nervously.",
        "* Pawntice pretends to dodge an invisible attack.",
        "* Pawntice screams out a war cry.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Pawntice looks around for its leader."

    -- Register act called "Smile"
    self:registerAct("Pet")
    self:registerAct("Feed")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Disturb", "", {"susie"})
end

function Pawntice:onAct(battler, name)
    if name == "Pet" then
        -- Give the enemy 100% mercy
        
        -- Change this enemy's dialogue for 1 turn

        -- Act text (since it's a list, multiple textboxes)
        if (self.isHatted == true)
            then
            self.dialogue_override = self.hatMessage;
            return {
                "* You tried petting Pawntice's hat.",
                "* It hissed at you!"
            }
            else
            self:addMercy(100)
            self.dialogue_override = self.petMessage;
            return {
                "* You pet Pawntice's fluffy hair.",
            }
            end

    elseif name == "Feed" then
        -- Loop through all enemies
        --for _, enemy in ipairs(Game.battle.enemies) do
        --    -- Make the enemy tired
        --    enemy:setTired(true)
        --end
        if (self.isHatted == true)
            then
            self.isHatted = false;
            self.dialogue_override = self.hairMessage;
            return "* You leave some leftovers.\n* Pawntice drops its hat in excitement!"
            else
            return "* You hold out some leftovers.\n * Pawntice eats from your hand."
            end
    elseif name == "Disturb" then
        -- Loop through all enemies
        for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
            enemy.dialogue_override = enemy.horrorMessage;
            enemy:setTired(true)
        end
        return "* You and Susie told horror stories!\n* The enemies became [color:blue]TIRED[color:reset]..."

    elseif name == "Standard" then --X-Action
        -- Give the enemy 50% mercy
        self:addMercy(50)
        if battler.chara.id == "ralsei" then
            -- R-Action text
            return "* Ralsei bowed politely.\n* The dummy spiritually bowed\nin return."
        elseif battler.chara.id == "susie" then
            -- S-Action: start a cutscene (see scripts/battle/cutscenes/dummy.lua)
            Game.battle:startActCutscene("dummy", "susie_punch")
            return
        else
            -- Text for any other character (like Noelle)
            return "* "..battler.chara:getName().." straightened the\ndummy's hat."
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Pawntice
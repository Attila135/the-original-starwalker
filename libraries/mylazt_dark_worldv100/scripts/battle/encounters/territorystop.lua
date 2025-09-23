local territorystop, super = Class(Encounter)

function territorystop:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Caught by border patrol!";

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self.enemy1 = self:addEnemy("pawntice");
    self.enemy2 = self:addEnemy("pawntice");

    self.enemy1.dialogue = {
        "Hand over\nyour weapons!",
        "THIS IS FOR\nFLIGHTCLAN!!!",
        "Intruders in\nFlightClan\nterritory!",
    }
    self.enemy1.hatMessage = "Are you tryna\nsteal my hat?!";
    self.enemy1.hairMessage = "Free food!!";
    self.enemy1.petMessage = "Tch, nevermind...";
    self.enemy1.horrorMessage = "Oh...";

    self.enemy2.dialogue = {
        "T-this isn't good...",
        "S-sorry for this!",
        nil,
    }
    self.enemy2.hatMessage = "Don't touch my hat...";
    self.enemy2.hairMessage = "Food..!";
    self.enemy2.petMessage = "...thanks.";
    self.enemy2.horrorMessage = "N-no more, please...";

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return territorystop
local item, super = Class("cd_bagel", true)

function item:init()
    super.init(self)

   

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "It's got crunch.",
        ralsei = "How elegant!",
        noelle = "What a nice song...",
        maskaught = "COPYRIGHT!!"
    }

    self.sounds = {
        ["kris"] = "cd_bagel/kris",
        ["susie"] = "cd_bagel/susie",
        ["ralsei"] = "cd_bagel/ralsei",
        ["noelle"] = "cd_bagel/noelle",
        ["maskaught"] = "cd_bagel/maskaught"
    }
end

return item
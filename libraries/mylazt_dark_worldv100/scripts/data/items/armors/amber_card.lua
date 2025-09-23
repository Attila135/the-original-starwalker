local item, super = Class("amber_card", true)

function item:init()
    super.init(self)

    -- Character reactions
    self.reactions = {
        susie = "... better than nothing.",
        ralsei = "It's sticky, huh, Kris...",
        noelle = "It's like a name-tag!",
        maskaught = "HUMAN..? THAT'S STICKY."
    }
end

return item
local item, super = Class("devilsknife", true)

function item:init()
    super.init(self)

    -- Character reactions
    self.reactions = {
        susie = "Let the games begin!",
        ralsei = "It's too, um, evil.",
        noelle = "...? It smiled at me?",
        maskaught = "THE CLOWN SUCKS.",
    }
end

return item
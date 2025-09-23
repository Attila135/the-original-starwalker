local item, super = Class("spincake", true)

function item:init()
    super.init(self)

    

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "I'm dizzy.",
        ralsei = "Mmm, thank you!",
        noelle = "My eyes are spinning...",
        maskaught = "E-EHAHAHAHA!! THAT CLOWN FAILED!! GOOD!!"
    }
end

return item
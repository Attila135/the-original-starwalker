local item, super = Class("darkburger", true)

function item:init()
    super.init(self)

    

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Cooked to perfection!",
        ralsei = "A bit burnt...?",
        noelle = "I-is this real meat...?",
        maskaught = "*HISS* CAT FUR?!?!??",
    }
end

return item
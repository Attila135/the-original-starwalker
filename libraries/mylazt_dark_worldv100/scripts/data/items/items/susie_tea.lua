local item, super = Class("susie_tea", true)

function item:init()
    super.init(self)

    

    -- Character reactions (key = party member id)
    self.heal_amounts = {
        ["kris"] = 120,
        ["susie"] = 10,
        ["ralsei"] = 120,
        ["noelle"] = 400,
        ["maskaught"] = 240,
    }
    self.reactions = {
        kris = {
            susie = "STOP LOOKING AT ME!",
            ralsei = "(They seem into it)"
        },
        susie = "... this is tea?",
        ralsei = {
            ralsei = "It's grape juice!",
            susie = "Huh, really?"
        },
        noelle = "(Wonder if they sell this in gallons?)",
        maskaught = "THE MONSTER <3"
    }
end

return item
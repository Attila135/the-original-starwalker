local item, super = Class("kris_tea", true)

function item:init()
    super.init(self)

    

    -- Character reactions (key = party member id)
    self.heal_amounts = {
        ["kris"] = 10,
        ["susie"] = 120,
        ["ralsei"] = 120,
        ["noelle"] = 70,
        ["maskaught"] = 240,
    }
    self.reactions = {
        kris = {
            susie = "(No reaction?)",
            noelle = "(... no reaction?)"
        },
        susie = {
            susie = "Hell yeah, apple juice!!",
            ralsei = "Don't drink so fast!!"
        },
        ralsei = {
            ralsei = "Tastes like blueberries!",
            susie = "Huh? Really?"
        },
        noelle = "Tastes like cinnamon! (What is this aftertaste...?)",
        maskaught = "THE HUMAN <3"
    }
end

return item
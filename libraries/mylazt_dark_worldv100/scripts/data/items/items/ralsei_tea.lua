local item, super = Class("ralsei_tea", true)

function item:init()
    super.init(self)

    

    -- Character reactions (key = party member id)
    self.heal_amounts = {
        ["kris"] = 60,
        ["susie"] = 120,
        ["ralsei"] = 10,
        ["noelle"] = 50,
        ["maskaught"] = 10
    }
    self.reactions = {
        kris = {
            susie = "(No reaction?)",
            ralsei = "(I'm happy!)"
        },
        susie = {
            susie = "Hey, it's like marshmallows!!",
            ralsei = "D-don't drink so fast!!"
        },
        ralsei = "Um... isn't this water?",
        noelle = "There's nothing in here!",
        maskaught = "IT NEEDS HONEY, LEMON, SUGAR, SALT, PEPPERMINT..."
    }
end

return item
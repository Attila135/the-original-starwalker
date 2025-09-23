local item, super = Class(Item, "chargescarf")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ChargeScarf"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scarf"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A spear-tipped scarf that transfers electricity. Protects against Elec attacks."

    -- Default shop price (sell price is halved)
    self.price = 250
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        magic  = 2,
        defense = 3,
        attack = 5,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Elec Defense UP"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        ralsei = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Crap, it's all tangled.",
        ralsei = "M-Mind untangling me? Kris?",
        noelle = "Can I take out that spiky part?",
        maskaught = "...I'M NOT ONE OF THOSE PROTO THINGS.",
    }
end

return item
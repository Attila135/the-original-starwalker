local item, super = Class(Item, "thornweaver")

function item:init()
    super.init(self)

    -- Display name
    self.name = "ThornWeaver"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Black-and\norange"
    -- Menu description
    self.description = "A sword made of vines.\nLooks like an... arm?"

    -- Default shop price (sell price is halved)
    self.price = 200
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
        attack = 5,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Malice"
    self.bonus_icon = "ui/menu/icon/demon"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Hey, it stings!?",
        ralsei = "...No thank you.",
        noelle = "(It's kinda cool...)",
    }
end


return item
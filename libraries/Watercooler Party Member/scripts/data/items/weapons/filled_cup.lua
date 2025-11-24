local item, super = Class(Item, "filled_cup")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Filled Cup"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/water"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Tasty\nWater"
    -- Menu description
    self.description = "Classic cup with cold water. \nIt belongs to Watercooler."

    -- Default shop price (sell price is halved)
    self.price = nil
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Water"
    self.bonus_icon = "ui/menu/icon/demon"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        watercooler = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Uh, it's NOT a weapon.",
        ralsei = "So, do we drink it?",
        noelle = "(Why is watercooler talking??)"
    }
end

return item
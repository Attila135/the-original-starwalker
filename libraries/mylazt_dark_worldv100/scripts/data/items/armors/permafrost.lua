local item, super = Class(Item, "permafrost")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Permafrost"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/snow"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "The wearer receives 2x healing.\nDoes not stack."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

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
        defense = 0,
        magic = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Healing"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        susie = "Uhh. Pocket sand?",
        ralsei = "...",
        noelle = "",
        maskaught = "BARK!!! THAT'S SOME STRONG STUFF!!!",
    }
end

return item
local item, super = Class(Item, "spikeaxe")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Spike Axe"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/axe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A door-bashing greataxe embedded with spikes."

    -- Default shop price (sell price is halved)
    self.price = 80
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
        attack = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Hurts... Good.",
        ralsei = "...am I supposed to hold the spikes??",
        noelle = "I wonder what it opens?",
        maskaught = "MY LIGHTNER ALWAYS BROUGHT THIS...",
    }
end

return item
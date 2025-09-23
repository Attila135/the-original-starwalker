-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "ring_frag_c")

function item:init()
    super.init(self)

    -- Display name
    self.name = "RingFrag C"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "It's a can filled with laughter.\nHow fun!"
    -- Shop description
    self.shop = "Sounds like it's laughing at you,\nHow rude! "
    -- Menu description
    self.description = "A piece of a strange ring...\nYou can see a faint engraving on it."


    -- Default shop price (sell price is halved)
    self.price = 130
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = nil
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "none"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "That was a bad joke",
        ralsei = "CAN you try any better?",
        noelle = "That was underwhelming...",
    }
end

return item
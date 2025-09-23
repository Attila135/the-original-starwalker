-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "couchpotato")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CouchPotato"
    -- Name displayed when used in battle (optional)
    self.use_name = "COUCHPOTATO"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nteam\n120HP"
    -- Shop description
    self.shop = "Sounds like it's laughing at you,\nHow rude! "
    -- Menu description
    self.description = "It's a bag of couch potato chips.\n +120HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 100

    -- Default shop price (sell price is halved)
    self.price = 120
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
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
        susie = "Couch food, my favorite!",
        ralsei = "It's extremely salty.",
        noelle = "That was underwhelming...",
    }
end

return item
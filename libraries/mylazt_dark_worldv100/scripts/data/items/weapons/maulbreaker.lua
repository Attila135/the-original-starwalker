local item, super = Class(Item, "maulbreaker")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Maulbreaker"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A silver-steel blade.\nAttacks rapidly deal damage."

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
        attack = 14,
    }
    -- Bonus name and icon (displayed in equip menu)
    -- self.bonus_name = "Spookiness UP"
    -- self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
    }

    -- Character reactions
    self.reactions = {  
        susie = "Ugh, what's with the threads??",
        ralsei = "It tried strangling me...",
        maskaught = "CLAWS OUT...!",
        noelle = "(...! Kris, how'd you even carry this?)",
    }
end

function item:convertToLightEquip(chara)
    return "light/halloween_pencil"
end

return item
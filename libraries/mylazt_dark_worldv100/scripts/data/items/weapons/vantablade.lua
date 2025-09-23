local item, super = Class(Item, "vantablade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Vantablade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A black sword used to make permanent marks."

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
        attack = 7,
    }
    -- Bonus name and icon (displayed in equip menu)
    --self.bonus_name = "Spookiness UP"
    --self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Heh! See what I drew?",
        ralsei = "Look, it's you, me, and Susie!",
        noelle = "Um, I don't vandalize...",
        maskaught = "IT'S NOT A DOG!! IT'S A WOLF!!",
    }
end

function item:convertToLightEquip(chara)
    return "light/halloween_pencil"
end

return item
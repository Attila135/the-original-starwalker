local item, super = Class(HealItem, "tinybuffet")

function item:init()
    super.init(self)

    -- Display name
    self.name = "TinyBuffet"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Amount healed (HealItem variable)
    self.heal_amount = 180
    
    -- Battle description
    self.effect = "Heals\nteam\n"..self.heal_amount.."HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Includes chocolate.\nHeals "..self.heal_amount.." HP to the team."

    -- Default shop price (sell price is halved)
    self.price = 2000
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    self.heal_amounts = {
        ["kris"] = 260,
        ["susie"] = 180,
        ["ralsei"] = 180,
        ["noelle"] = 180,
        ["maskaught"] = 180
    }
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
        susie = "How much sugar is in this...?",
        ralsei = "It's like breakfast!",
        maskaught = "A GOOD FEAST <3",
        noelle = "(Kris took all the chocolate...)"
    }
end

return item
local item, super = Class(HealItem, "star_poppers")

function item:init()
    super.init(self)

    -- Display name
    self.name = "PopStars"
    -- Name displayed when used in battle (optional)
    self.use_name = "POPSTARS"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n90HP"
    -- Shop description
    self.shop = nil
    -- Menu description
    self.description = "A bag of small star shaped candies that\npop in your mouth! +90HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 90

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
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
        susie = "Woah... tongue tingles...",
        ralsei = "It's rather sweet."
    }
end

function item:onBattleUse(user, target)
    super.onBattleUse(self, user, target)

    Game:setFlag("soul_speed", Game:getFlag("soul_speed")+0.2)
    Game:setFlag("speed_turns", 2)
end

function item:getBattleText(user, target)
    return "* "..user.chara:getName().." used the "..self:getUseName().."!\n[wait:5]* Pop pop,[wait:5] [sound:cardrive]movement speed up for the next two turns!"
end

return item
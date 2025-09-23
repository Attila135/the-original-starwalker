-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(TensionItem, "tensionpause")

function item:init()
    super.init(self)

    -- Display name
    self.name = "TensionPause"
    -- Name displayed when used in battle (optional)
    self.use_name = "TENSIONPAUSE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    self.tp_amount = 100

    -- Battle description
    self.effect = "TP 100%\nSlower\nbullets"
    -- Shop description
    self.shop = "Sounds like it's laughing at you,\nHow rude! "
    -- Menu description
    self.description = "Raises TP to 100% in battle and\nslows down incoming bullets."

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
end

function item:onBattleUse(user, target)
    Game:setFlag("bul_speed_prev", Game:getFlag("bul_speed"))
    Game:setFlag("bul_speed", 0.5)
    Game:setFlag("tens_pause_used", true)
end

function item:onWorldUse(target)
    Game.world:showText({
        "* ([speed:0.1]...)",
        "* (You felt the world stop for a moment.)",
        "* (Besides a feeling of relief,[wait:5] nothing happened.)",
        "* (... try using it in battle.)"
    })
    return false
end

function item:getBattleText(user, target)
    return "* "..user.chara:getName().." used the "..self:getUseName().."!\n[wait:5]* Bullet speed has been reduced!"
end

return item
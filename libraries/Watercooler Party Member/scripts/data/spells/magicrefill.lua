local spell, super = Class(Spell, "magicrefill")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "MagicRefill"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Heal ally, \nHurt user"

    -- Menu description
    self.description = "Restores huge amount of HP to one party member, \nbut reduces a little from it's user."

    -- TP cost
    self.cost = 22

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:getCastMessage(user, target)
    return "* Watercooler gave a tasty drink to " ..target.chara:getName().. "! [wait:0.25s]\n * It was effective!"
end

function spell:onCast(user, target)
    local base_heal = user.chara:getStat("magic") * 8
    local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara)

    target:heal(heal_amount)
    user:hurt(heal_amount / 2)
end

return spell
local spell, super = Class(Spell, "moonbless")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "LUNAR BLESS"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "HEAL\nFRIEND"
    -- Menu description
    self.description = "RESTORES ALL HP OF ONE FRIEND."

    -- TP cost
    self.cost = 16

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    target:heal(user.chara:getStat("magic") * 50)
end

return spell
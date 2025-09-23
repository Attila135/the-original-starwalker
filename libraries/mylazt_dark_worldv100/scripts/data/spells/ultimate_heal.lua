-- local spell, super = Class(Spell, "ultimate_heal")
local spell, super = Class("ultimate_heal", true)

function spell:init()
    super.init(self)

   
end

function spell:onCast(user, target)
    target:heal(user.chara:getStat("magic") + 40)
end

return spell

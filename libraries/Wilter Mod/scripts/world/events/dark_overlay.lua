local Black, super = Class(Event)

function Black:init()
    super.init(self)
    self:setSprite("bg/dark_overlay")
end

return Black
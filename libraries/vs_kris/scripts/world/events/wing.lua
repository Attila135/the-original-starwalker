local Wing, super = Class(Event, "wing")

function Wing:init(x, y, properties)
    super.init(self, 329, 168)

    properties = properties or {}

    self:setOrigin(0.5, 1)
    self:setScale(1)

    self.sprite = Sprite("world/events/wing")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(0, 23, 74, 42)
end

function Wing:onInteract(player, dir)
    if self.sprite.frame == 2 then
     Assets.playSound("wing")
     self.sprite:setFrame(1)
     return true
    else
        Assets.playSound("wing")
        self.sprite:setFrame(2)
    end
end

return Wing
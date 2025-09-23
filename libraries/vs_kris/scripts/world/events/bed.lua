local bed, super = Class(Event, "bed")

function bed:init(x, y, properties)
    super.init(self, 466, 230)

    properties = properties or {}

    self:setOrigin(0, 0.5)

    self.sprite = Sprite("world/events/bed")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(0, 23, 85, 42)
end

function bed:onAdd(parent)
    super.onAdd(self, parent)

    if Game.world.map:getFlag("blanket") then
        self.sprite:setFrame(2)
    end
end

return bed
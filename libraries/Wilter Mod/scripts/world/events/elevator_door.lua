local Door, super = Class(Event)

function Door:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self:setSprite("objects/elevator_door")
    self:setOrigin(0)
end

return Door
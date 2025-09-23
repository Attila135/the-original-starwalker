local Door, super = Class(Event)

function Door:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self:setSprite("objects/door_slam")
    self.sprite:setOrigin(0.5, 0)
    self:setScale(0.5)
end

return Door
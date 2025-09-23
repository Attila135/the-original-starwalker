local Wheel, super = Class(Event)

function Wheel:init()
    super.init(self)
    self:setOrigin(0.5)
    self.x = 320
    self.y = 240
    self:setSprite("objects/wheel")
    Game.world.timer:every(1/30, function()
        self.rotation = self.rotation + math.rad(2)
    end)
end

return Wheel
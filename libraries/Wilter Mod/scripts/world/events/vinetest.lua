local VineTest, super = Class(Event, "vinetest")

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self:setOrigin(0.5)
    local Vine = vine(self.x, self.y)
    Game.world:spawnObject(Vine, 0.4)
end

return VineTest
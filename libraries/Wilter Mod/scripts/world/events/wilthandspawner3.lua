local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self.hands = {
        512,
        513
    }
end

function VineTest:onEnter(player)
    if not self.activated then
        self.activated = true
        Game.world:setBattle(false)
        for _, h in ipairs(self.hands) do
            local hand = Game.world:getEvent(h)
            hand:extend()
        end
        for _, bullet in ipairs(Game.world.bullets) do
            bullet:fadeOutAndRemove(1)
        end
    end
end

return VineTest
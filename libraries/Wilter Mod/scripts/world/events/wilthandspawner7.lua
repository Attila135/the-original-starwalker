local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self.hands = {
        551
    }
end

function VineTest:onEnter(player)
    if not self.activated then
        self.activated = true
        for _, h in ipairs(self.hands) do
            local hand = Game.world:getEvent(h)
            hand:extend()
        end
    end
end

return VineTest
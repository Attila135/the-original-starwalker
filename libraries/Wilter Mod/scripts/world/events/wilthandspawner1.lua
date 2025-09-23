local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
end

function VineTest:onEnter(player)
    if not self.activated then
        self.activated = true
        local hand = Game.world:getEvent(506)
        if not hand.extended then
            hand:extend()
        end
    end
end

return VineTest
local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self.hands = {
        507,
        514,
        508,
        509,
        510,
        511
    }
end

function VineTest:onEnter(player)
    if not self.activated then
        self.activated = true
        Game.world.map.timer:script(function (wait)
            for _, h in ipairs(self.hands) do
                local hand = Game.world:getEvent(h)
                hand:extend()
                wait(0.2)
            end
        end)
    end
end

return VineTest
local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self.events = Game.world:getEvents("start_platform")
end

function VineTest:onEnter(player)
    if not self.activated then
        self.platform_event = Game.world.map:getEvent("platform")
        for _, event in ipairs(self.events) do
            self.activated = true
            if event.activated and event ~= self then
                self.activated = false
                return
            end
        end
        self.platform_event:beginMove()
    end
end

return VineTest
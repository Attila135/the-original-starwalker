local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
end

function VineTest:update()
    super.update(self)
    if self.activated and Game:getFlag("wilttime") > 0 then
        Game:setFlag("wilttime", Game:getFlag("wilttime")-DT)
    elseif self.activated and Game:getFlag("wilttime") <= 0 then
        self.activated = false
        Game.world:startCutscene("chase", "death")
        self.active = false
    end
end

function VineTest:onEnter(player)
    if not self.activated then
        self.activated = true
        Game.world.in_battle = true
        local wilts = Game.world:getEvents("wiltrunobject")
        Game:setFlag("wilttime", 90)
        for _, wilt in ipairs(wilts) do
            wilt:initiateTimer()
        end
    end
end

return VineTest
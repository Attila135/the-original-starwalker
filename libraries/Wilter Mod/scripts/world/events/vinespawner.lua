local VineTest, super = Class(Event)

function VineTest:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self.spears = 20

    Game.world.map.timer:every(3, function ()
        if self.activated and not Game:getFlag("died_to_Chase") then
            for i=1, self.spears do
                Game.world:spawnObject(vine(), Game.world.player.layer-0.01)
            end 
        end
    end)
end

function VineTest:onEnter(player)
    if not self.activated then
        self.activated = true
    end
end

function VineTest:onExit(player)
    if self.activated then
        self.activated = false
    end
end
return VineTest
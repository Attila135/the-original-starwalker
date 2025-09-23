local Eyespawner, super = Class(Event)

function Eyespawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.once = false

    local door = Game.world:spawnObject(Sprite("objects/funhouse_door_slam", self.x, self.y), 1)
    door:setScale(2)

    Game.world.timer:every(1/30, function ()
        if Game.world.player.x >= self.x-120 and Game.world.player.x < 2000 and not self.once then
            self.once = true
            door:play(0.1, false)
            Game.world.timer:after(0.3, function()
                Assets.playSound("impact")
            end)
        end
    end)
end

return Eyespawner
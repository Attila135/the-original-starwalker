local Eyespawner, super = Class(Event)

function Eyespawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.once = false

    local door = Game.world:spawnObject(Sprite("objects/funhouse_door_eyes", self.x, self.y), 1)
    door:setScale(2)

    Game.world.timer:every(1/30, function ()
        if Game.world.player.x >= self.x + 40 and Game.world.player.x < 2000 and not self.once then
            self.once = true
            door:play(0.1, false)
            Game.world.timer:after(0.3, function()
                Assets.playSound("impact")
                local eye = Game.world:spawnBullet("eye", self.x+40, self.y+40, false)
                eye.physics.direction = Utils.angle(eye.x, eye.y, Game.world.player.x, Game.world.player.y)
                eye.rotation = eye.physics.direction + math.pi
                eye.physics.speed = 13
            end)
        end
    end)
end

return Eyespawner
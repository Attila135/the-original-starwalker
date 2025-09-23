local Eyespawner, super = Class(Event)

function Eyespawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.activated = false

    self.time = 0
end

function Eyespawner:onEnter(player)
    self.activated = true
    Game.world.music:play("wilter_chase", 0)
    Game.world.music:fade(1, 0.5)
end

function Eyespawner:onExit(player)
    self.activated = false
    Game.world.music:fade(0, 0.5)
end

function Eyespawner:update()
    super.update(self)

    if self.activated then
        if self.time >= 2 then
            self.time = 0
            for i=1, love.math.random(3, 5) do
                local eye = Game.world:spawnBullet("eye", Game.world.player.x+love.math.random(-60, 60), 0, false)
                eye.physics.speed = 0
                eye.alpha = 0
                eye:setScale(1)
                eye.physics.direction = math.rad(90) + math.rad(Utils.pick({-45, 45}))
                eye.rotation = eye.physics.direction + math.pi
                Game.world.timer:tween(0.5, eye.physics, {direction=math.pi*0.5})
                Game.world.timer:tween(0.6, eye, {rotation=math.pi*1.5})
                eye.physics.speed = 10
                eye:fadeTo(1, 1)
                Game.world.timer:tween(1, eye, {scale_x=2, scale_y=2}, "in-quad")
            end
        else
            self.time = self.time + DT
        end
    end
end

return Eyespawner
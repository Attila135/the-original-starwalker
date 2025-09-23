local Wiltspawner, super = Class(Event)

function Wiltspawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.once = false

    Game.world.timer:every(1/30, function ()
        if Game.world.player.x >= self.x - 80 and not self.once then
            self.once = true
            Game.stage.timer:script(function(wait)
                local wilt = Sprite("objects/wiltholder", self.x, self.y)
                Assets.playSound("wilt_big_laugh")
                wilt:setScale(0)
                wilt.alpha = 0.4
                wilt:setOrigin(0.5)
                wilt:setAnimation({"enemies/dummy/run/down", 1/10, true})
                Game.world:spawnObject(wilt)
                wilt.layer = 0.7
                Game.stage.timer:tween(2, wilt, {scale_x = 1, scale_y = 1}, "in-quad")
                Game.stage.timer:tween(0.5, wilt, {alpha = 0.7})
                --Game.stage.timer:tween(1, self, {alpha = 1})
                wait(2)
                Game.world:removeChild(wilt)
                local broken = Sprite("objects/mirror_brokenb", self.x, self.y)
                Assets.playSound("glass_crash")
                broken:setOrigin(0.5)
                broken:setScale(2)
                Game.world:addChild(broken)
                broken:shake()
                broken.layer = 0.6
                broken:play(0.1, false)
                for i=1, 10 do
                    local shard = Sprite("objects/mirror_shard"..Utils.pick({"a","b"}), self.x+love.math.random(-60, 60), self.y+love.math.random(-100, 100))
                    shard:setFrame(love.math.random(1,4))
                    shard:setOrigin(0.5)
                    shard:setScale(2)
                    shard.layer = Game.world.player.layer-0.01
                    shard:play(0.5, true)
                    Game.world:addChild(shard)
                    shard.physics.speed_y = -5
                    shard.physics.speed_x = Utils.pick({love.math.random(3,5,0.5), love.math.random(-3,-5,-0.5)})
                    shard.physics.gravity = 1
                    Game.world.map.timer:after(10, function ()
                        shard:remove()
                    end)
                end
                local wilter = Game.world:spawnBullet("wilter", 1840.00, 1880.00)
                wilter:addFX(MaskFX(Game.world.map:getEvent("wiltmask")))
                wilter.physics.speed = 17
                wilter.physics.direction = math.pi/2
                Game.world.timer:after(0.8, function ()
                    wilter.sprite:setAnimation({"enemies/dummy/skidding", 0.05, true})
                    Game.stage.timer:tween(0.4, wilter.physics, {speed = 0}, "out-quad")
                    Game.world.timer:after(0.4, function ()
                        wilter.sprite:setAnimation({"enemies/dummy/run/left", 1/10, true})
                        wilter:setHitbox(40, 0, wilter.width-40, wilter.height)
                        wilter.physics.direction = math.pi
                        wilter.physics.speed = 9
                    end)
                end)
            end)
        end
    end)
end

return Wiltspawner
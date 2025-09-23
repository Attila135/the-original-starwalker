local Eyespawner, super = Class(Event)

function Eyespawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.once = false

    Game.world.timer:every(1/30, function ()
        if Game.world.player.x >= self.x - 120 and not self.once then
            self.once = true
            Game.world.timer:after(love.math.random(0, 0.5), function ()
                local eye = Game.world:spawnBullet("eye", self.x, self.y-50, false)
                eye.alpha = 0.7
                eye:addFX(MaskFX(Game.world.map:getEvent("eyemask")))
                Game.world.map.timer:after(0.25, function ()
                    Assets.playSound("glass_crash")
                    eye.alpha = 1
                    local broken = Sprite("objects/mirror_brokena", self.x, self.y + 32)
                    broken:setOrigin(0.5)
                    broken:setScale(2)
                    Game.world:addChild(broken)
                    broken.layer = 0.6
                    broken:play(0.1, false)
                    for i=1, 4 do
                        local shard = Sprite("objects/mirror_shard"..Utils.pick({"a","b"}), self.x + love.math.random(-20, 20), self.y + 26 + love.math.random(-20, 20))
                        shard:setFrame(love.math.random(1,4))
                        shard:setOrigin(0.5)
                        shard:setScale(2)
                        shard.layer = Game.world.player.layer-0.01
                        shard:play(0.5, true)
                        Game.world:addChild(shard)
                        shard.physics.speed_y = -10
                        shard.physics.speed_x = Utils.pick({love.math.random(5,7,0.5), love.math.random(-5,-7,-0.5)})
                        shard.physics.gravity = 1
                        Game.world.map.timer:after(4, function ()
                            shard:remove()
                        end)
                    end
                end)
            end)
        end
    end)
end

return Eyespawner
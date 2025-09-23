local Wiltspawner, super = Class(Event)

function Wiltspawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
    self.targeting_player = true
    Game.world.map.timer:after(1, function ()
        self:activate()
        self.target_x = Game.world.player.x
        self.target_y = Game.world.player.y
    end)
    self.lerpTime = 0
end

function Wiltspawner:update()
    super.update(self)
    if self.targeting_player then
        self.target_x = Game.world.player.x
        self.target_y = Game.world.player.y
    end
end

function Wiltspawner:activate()
    for i=0, 20 do
        Game.world:spawnBullet("smallhand", -80, 0+30*i, false)
    end
    local wall = Game.world:spawnBullet("smallhand_wall", -80, 0, false)

    local wilter = Game.world:spawnBullet("wilter", Game.world.player.x, -100)
    local shadow = Sprite("enemies/dummy/wiltshadow", Game.world.player.x, Game.world.player.y)
    shadow:setOrigin(0.5)
    shadow.alpha = 0
    shadow:setScale(0)
    Game.world:spawnObject(shadow, 0.21)
    wilter:setSprite("enemies/dummy/wiltjump_2")
    wilter:setScale(1.6, 2)
    wilter:setOrigin(0.5, 0.8)
    wilter.collidable = false

    wilter:setHitbox(10, 40, 90, 40)

    Game.world.map.timer:everyInstant(1/FPS, function ()
        if Game:getFlag("died_to_Chase") then
            return
        end
    end)
    Game.world.map.timer:everyInstant(10, function ()
        if Game.world:inBattle() then
            Game.world.map.timer:script(function (wait)
                print(wilter.y)
                self.start_x = shadow.x
                self.start_y = shadow.y
                self.lerpTime = 0
                self.targeting_player = true
                Game.world.map.timer:tween(1, shadow, {alpha = 0.9, scale_x = 4, scale_y = 4}, "out-quad")
                wait(4)
                self.targeting_player = false
                wait(1)
                wilter:slideTo(wilter.x, self.target_y, 0.5)
                print(self.target_y)
                Game.world.map.timer:tween(0.5, shadow, {alpha = 0, scale_x = 0, scale_y = 0}, "out-quad")
                wait(0.5)
                wilter.collidable = true
                Game.world.timer:tween(0.1, wilter, {scale_x = 2.5, scale_y = 1.5})
                wait(0.05)
                wilter:setSprite("enemies/dummy/wiltjump_1")
                Game.world.camera:shake()
                Assets.playSound("impact")
                wait(0.5)
                Game.world.map.timer:tween(0.5, wilter, {scale_y=2.5, scale_x=1.6}, "out-quad")
                wait(0.1)
                Game.world.map.timer:tween(0.5, wilter, {y=-100}, "in-quad")
                Game.world.camera:shake()
                wait(0.2)
                wilter.collidable = true
                Assets.playSound("jump")
                wilter:setSprite("enemies/dummy/wiltjump_2")
            end)
        end
    end)
    Game.world.map.timer:everyInstant(1/FPS, function ()
        self.lerpTime = self.lerpTime+DT/2
        shadow.x = Utils.lerp(self.start_x, self.target_x, self.lerpTime)
        shadow.y = Utils.lerp(self.start_y, self.target_y, self.lerpTime)

        wilter.x = self.target_x
    end)
end

return Wiltspawner
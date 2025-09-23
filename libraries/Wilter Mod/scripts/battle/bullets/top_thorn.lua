local SmallBullet, super = Class(Bullet, "top_thorn")

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/TopSpike")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self:setScale(1, 1)

    self.x = x

    self.y = y

    self:setOrigin(0.5, 1)

    Game.battle.waves[1].timer:tween(0.5, self, {y=self.y+self.height})

    Game.battle.waves[1].timer:after(0.6, function ()
        self:shake()
        Assets.playSound("impact")
        Game.battle.waves[1].timer:after(1, function ()
            Game.battle.waves[1].timer:tween(2/Game:getFlag("bul_speed"), self, {y=300}, "in-quad")
        end)
    end)

end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return SmallBullet
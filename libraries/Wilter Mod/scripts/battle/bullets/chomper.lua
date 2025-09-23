local SmallBullet, super = Class(Bullet, "chomper")

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/chomper_closed")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self:setScale(0)

    self.x = x

    self.y = y

    self.destroy_on_hit = false

    self.siner = 0

    Game.battle.waves[1].timer:tween(0.5, self, {scale_x = 2, scale_y = 2})

    self.activated = false

    self.speedIncrease = 0

    self.slowing = false

    Game.battle.waves[1].timer:after(0.5, function ()
        self.physics.direction = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
        self.speedIncrease = 1
        self.physics.speed = -7
        self.sprite:setAnimation({"bullets/chomper", 1/10, false})
        if self.x > Game.battle.soul.x then
            self.flip_x = false
        elseif self.x < Game.battle.soul.x then
            self.flip_x = true
        end
    end)
end

function SmallBullet:update()

    self.physics.speed = self.physics.speed + self.speedIncrease*DTMULT
    -- For more complicated bullet behaviours, code here gets called every update

    if self.physics.speed >= 10 and self.slowing == false then
        self.slowing = true

        Game.battle.waves[1].timer:after(0.2, function ()
            self.speedIncrease = -1
            self.sprite:setSprite("bullets/chomper_closed")
        end)
    end

    if self.slowing == true and self.physics.speed <= 0 then
        self.slowing = false
        self.physics.speed = 0
        self.speedIncrease = 0
        Game.battle.waves[1].timer:after(0.5, function ()
            self.physics.direction = Utils.angle(self.x, self.y, Game.battle.soul.x, Game.battle.soul.y)
            self.speedIncrease = 1
            self.physics.speed = -7
            self.sprite:setAnimation({"bullets/chomper", 1/10, false})
            if self.x > Game.battle.soul.x then
                self.flip_x = false
            elseif self.x < Game.battle.soul.x then
                self.flip_x = true
            end
        end)
    end

    super.update(self)
end

return SmallBullet
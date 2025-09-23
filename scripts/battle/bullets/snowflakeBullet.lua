local snowflakeBullet, super = Class(Bullet)

function snowflakeBullet:init(x, y, dir, speed, rotate, scale, dirRot, afterimg)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/snowflakeBullet")
    self.dir=dirRot or "left"

    self.afterimg = afterimg or false

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.rotate=rotate
    self:setScale(scale or 1)
end

function snowflakeBullet:onWaveSpawn(wave)
    if self.afterimg then
        self.af_timer = wave.timer:everyInstant(1/16, function()
            Game.battle:addChild(AfterImage(self.sprite, 0.5))
        end)
    end
end

function snowflakeBullet:onRemoveFromStage()
    if self.afterimg then
        self.wave.timer:cancel(self.af_timer)
    end
end

function snowflakeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    if self.rotate then
        if self.dir=="left" then
            self.rotation=math.rad(math.deg(self.rotation)-2*DTMULT)
        else
            self.rotation=math.rad(math.deg(self.rotation)+2*DTMULT)
        end
    end

    super:update(self)
end

return snowflakeBullet
local Tornado, super = Class(Bullet)

function Tornado:init(x, y, dir, speed)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/tornado")
    self:setScale(1)
    self.sprite:setScaleOrigin(0.5, 0.5)

    self:setHitbox(10, 8, 17, 26)

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.produce_snow = true
end

function Tornado:onWaveSpawn(wave)
    wave.timer:every(1/16, function()
        self.sprite.scale_x = -self.sprite.scale_x
    end)
    wave.timer:every(1/6, function()
        if self.produce_snow then
            local snow = Sprite("bullets/lonelysnow")
            snow:setScale(0.5)
            snow:setPosition(math.random(5, self.sprite.width-5), self.sprite.height/2)
            snow.physics = {
                direction = math.rad(90),
                speed = 5
            }
            snow:fadeOutSpeedAndRemove()
            self:addChild(snow)
        end
    end)
end

function Tornado:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

return Tornado
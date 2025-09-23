local Tornado, super = Class(Bullet)

function Tornado:init(x, y, area, delay)
    -- Last argument = sprite path
    super:init(self, x, y, "bullets/weird_sine")
    self:setScale(2)

    self.goto_x = Utils.random(x, x+27*2)
    if area == "up" then
        self.goto_y = Utils.random(Game.battle.encounter.berdly.y - Game.battle.encounter.berdly.sprite.height*2, 10)
    else
        self.goto_y = Utils.random(Game.battle.encounter.berdly.y, SCREEN_HEIGHT-10)
    end

    self.goto_rot = (Utils.angle(Game.battle.soul.x, Game.battle.soul.y, self.goto_x, self.goto_y)-math.rad(360))+math.rad(Utils.random(-15, 15))

    self.timer = 0
    self.launched = false
    self.delay = delay

    self.remove_offscreen = true

    Assets.playSound("snd_spearrise")
end

function Tornado:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.timer = self.timer + DTMULT

    if self.timer < 30 then
        self.x = Utils.ease(self.init_x, self.goto_x, self.timer/30, "out-cubic")
        self.y = Utils.ease(self.init_y, self.goto_y, self.timer/30, "out-cubic")
        self.rotation = Utils.ease(0, self.goto_rot, self.timer/30, "out-cubic")
    elseif self.timer >= 100+self.delay and not self.launched then
        self.launched = true
        Assets.stopAndPlaySound("criticalswing")
        self.rotation = self.rotation + math.rad(360)
        self:setPhysics({
            match_rotation = true,
            speed = -20
        })
    end

    super:update(self)
end

return Tornado
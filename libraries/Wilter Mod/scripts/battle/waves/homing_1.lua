local Basic, super = Class(Wave, "homing_1")
function Basic:init()
    super:init(self)

    self.time = 10

    self:setArenaSize(200, 150)
end

function Basic:onStart()

    Game.battle:swapSoul(PurpleSoulSkerch())

    self.strings = {
        40,
        Game.battle.arena.height / 2,
        Game.battle.arena.height - 40
    }

    self.timer:after(0.5, function ()
        local y = Utils.random(Game.battle.arena:getTop(), Game.battle.arena.bottom)
        local bullet = self:spawnBullet("chomper", 100, y, math.rad(180), 0)

        bullet.remove_offscreen = false
        bullet.destroy_on_hit = false

        self.chomper_anim_flip = true
        self.chomper = bullet 

        self.chomper_x, self.chomper_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.chomper.sprite:setAnimation({"bullets/chomper_flip", 1/10, true})

        if self.chomper_x > Game.battle.soul.x then
            self.chomper_anim_flip = false
        elseif self.chomper_x < Game.battle.soul.x then
            self.chomper_anim_flip = true
        end
    end)

    --[[self.timer:every(1/10000 , function()
        self.chomper_x, self.chomper_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        if self.chomper_x > Game.battle.soul.x and self.chomper_anim_flip == true then
            self.chomper.sprite:setAnimation({"bullets/chomper", 1/10, true})
            self.chomper_anim_flip = false
        elseif self.chomper_x < Game.battle.soul.x and self.chomper_anim_flip == false then
            self.chomper.sprite:setAnimation({"bullets/chomper_flip", 1/10, true})
            self.chomper_anim_flip = true
        end

        self.chomper.physics.direction = Utils.angle(self.chomper_x, self.chomper_y, Game.battle.soul.x, Game.battle.soul.y)
    end)]]

    self.timer:every(0.75, function()
        local brainpoop = Utils.pick({"top", "bottom"})

        if brainpoop == "top" then
            self:spawnBulletTo(Game.battle.arena.mask, "top_thorn", Utils.random(0, Game.battle.arena.width), 0, math.rad(90), 0)
        elseif brainpoop == "bottom" then
            self:spawnBulletTo(Game.battle.arena.mask, "bottom_thorn", Utils.random(0, Game.battle.arena.width), Game.battle.arena.height, math.rad(270), 0)
        end
    end)

end

return Basic

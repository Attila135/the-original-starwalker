local Basic, super = Class(Wave)
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 10
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())

    self.strings = {
        30,
        Game.battle.arena.width / 2,
        Game.battle.arena.width - 30
    }

    self.direction = "vertical"

    -- Every 0.33 seconds...

    self.timer:every(2 , function()
        local x, y = Game.battle.soul.x, Game.battle.soul.y
        local bullet = self:spawnBullet("pellet", x - 100 , 120)
        self.pellet = bullet
        self.pellet_x, self.pellet_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.pellet.physics.direction = Utils.angle(self.pellet_x, self.pellet_y, x, y)
        Game.stage.timer:after(0.5, function ()
            bullet.physics.speed = 25*Game:getFlag("bul_speed")
            Assets.playSound("wing")
        end)
    end)
    self.timer:every(2 , function()
        local x, y = Game.battle.soul.x, Game.battle.soul.y
        local bullet = self:spawnBullet("pellet", x - 100 , 170)
        self.pellet = bullet
        self.pellet_x, self.pellet_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.pellet.physics.direction = Utils.angle(self.pellet_x, self.pellet_y, x, y)
        Game.stage.timer:after(0.5, function ()
            bullet.physics.speed = 25
            Assets.playSound("wing")
        end)
    end)
    self.timer:every(2 , function()
        local x, y = Game.battle.soul.x, Game.battle.soul.y
        local bullet = self:spawnBullet("pellet", x - 100 , 220)
        self.pellet = bullet
        self.pellet_x, self.pellet_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.pellet.physics.direction = Utils.angle(self.pellet_x, self.pellet_y, x, y)
        Game.stage.timer:after(0.5, function ()
            bullet.physics.speed = 25*Game:getFlag("bul_speed")
            Assets.playSound("wing")
        end)
    end)
    self.timer:every(2 , function()
        local x, y = Game.battle.soul.x, Game.battle.soul.y
        local bullet = self:spawnBullet("pellet", x + 100 , 120)
        self.pellet = bullet
        self.pellet_x, self.pellet_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.pellet.physics.direction = Utils.angle(self.pellet_x, self.pellet_y, x, y)
        Game.stage.timer:after(0.5, function ()
            bullet.physics.speed = 25*Game:getFlag("bul_speed")
            Assets.playSound("wing")
        end)
    end)
    self.timer:every(2 , function()
        local x, y = Game.battle.soul.x, Game.battle.soul.y
        local bullet = self:spawnBullet("pellet", x + 100 , 170)
        self.pellet = bullet
        self.pellet_x, self.pellet_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.pellet.physics.direction = Utils.angle(self.pellet_x, self.pellet_y, x, y)
        Game.stage.timer:after(0.5, function ()
            bullet.physics.speed = 25*Game:getFlag("bul_speed")
            Assets.playSound("wing")
        end)
    end)
    self.timer:every(2 , function()
        local x, y = Game.battle.soul.x, Game.battle.soul.y
        local bullet = self:spawnBullet("pellet", x + 100 , 220)
        self.pellet = bullet
        self.pellet_x, self.pellet_y = bullet:getRelativePos(bullet.width/2, bullet.height/2)

        self.pellet.physics.direction = Utils.angle(self.pellet_x, self.pellet_y, x, y)
        Game.stage.timer:after(0.5, function ()
            bullet.physics.speed = 25*Game:getFlag("bul_speed")
            Assets.playSound("wing")
        end)
    end)

end

return Basic

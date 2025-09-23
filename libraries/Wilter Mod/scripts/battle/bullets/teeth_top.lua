local SmallBullet, super = Class(Bullet, "teeth_top")

function SmallBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/top_tooth")

    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.x = x

    self.y = y

    self.remove_offscreen = false

    self.fall_dir = "left"

    self.x_friction = 0.1

    self.x_friction = 0.05

    self.y_friction = -1

    self:setHitbox(2, 4, self.width-4, self.height-8)

    Game.battle.waves[1].timer:every(1/30, function ()
        if self.falling then
            if self.fall_dir == "left" then
                self.physics.speed_x = self.physics.speed_x + self.x_friction
            else
                self.physics.speed_x = self.physics.speed_x - self.x_friction
            end
        else
            self.physics.speed_x = 0
        end
        if self.falling then
            self.physics.speed_y = self.physics.speed_y - self.y_friction
        else
            self.physics.speed_y = 0
        end
    end)


    Game.battle.waves[1].timer:after(0.2, function ()
        if self.fall then
            self:shake()
            Game.battle.waves[1].timer:after(1.5, function ()
                self.fall_dir = Utils.pick({"left", "right"})
                if self.fall_dir == "left" then
                    self.physics.speed_x = -3
                else
                    self.physics.speed_x = 3
                end
                self.physics.speed_y = -5
                self.falling = true
            end)
        else
            Game.battle.waves[1].timer:after(1.5, function ()
                Game.battle.waves[1].timer:tween(0.5, self, {y=155 + self.offset}, "in-out-back")
                Game.battle.waves[1].timer:after(1, function ()
                    Game.battle.waves[1].timer:tween(0.5, self, {y=100 + self.offset}, "in-out-back")
                    Game.battle.waves[1].timer:after(0.7, function ()
                        self:remove()
                    end)
                end)
            end)
        end
    end)
end

function SmallBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

return SmallBullet
local Basic, super = Class(Wave, "teeth")
function Basic:init()
    super.init(self)

    self.bullet_offsets = {}

    self.teeth_falling = 3

    self.time = 10

    self.direction = "horizontal"
end

function Basic:onStart()
    local soul = Game.battle.soul

    Game.battle.soul.string_count = 2
    Game.battle.soul.current_string = 1

    Game.battle.soul.margin = 10

    self.strings = {
        60,
        Game.battle.arena.height - 60
    }

    local firstTimePassed = false

    self.timer:everyInstant(3.2, function ()
        for i = 1, 5 do
            if not firstTimePassed then
                local offset = self.bullet_offsets[i] or Utils.pick({-5, 0, 5})
                table.insert(self.bullet_offsets, offset)
                local bullet = self:spawnBullet("teeth_top", 230 + i*30, 100 + offset, 0, 0)
                bullet.offset = offset
                if self.teeth_falling > 0 then
                    local rand = Utils.pick({1, 2, 3})
                    if rand == 1 then
                        bullet.fall = true
                        print(bullet.fall)
                        self.teeth_falling = self.teeth_falling - 1
                    else
                        bullet.fall = false
                    end
                    if i == 5 and self.teeth_falling == 3 then
                        bullet.fall = true
                        print(bullet.fall)
                        self.teeth_falling = self.teeth_falling - 1
                    end
                end
                
                bullet = self:spawnBullet("teeth_bottom", 230 + i*30, 245 + offset, 0, 0)
                
                bullet.offset = offset
                if self.teeth_falling > 0 then
                    local rand = Utils.pick({1, 2, 3})
                    if rand == 1 then
                        bullet.fall = true
                        print(bullet.fall)
                        self.teeth_falling = self.teeth_falling - 1
                    else
                        bullet.fall = false
                    end
                end
            else
                local offset = self.bullet_offsets[i]
                local bullet = self:spawnBullet("teeth_top", 230 + i*30, 100 + offset, 0, 0)
                bullet.alpha = 0
                bullet:fadeTo(1, 0.2)
                bullet.offset = offset
                if self.teeth_falling > 0 then
                    local rand = Utils.pick({1, 2, 3})
                    if rand == 1 then
                        bullet.fall = true
                        print(bullet.fall)
                        self.teeth_falling = self.teeth_falling - 1
                    else
                        bullet.fall = false
                    end
                    if i == 5 and self.teeth_falling == 3 then
                        bullet.fall = true
                        print(bullet.fall)
                        self.teeth_falling = self.teeth_falling - 1
                    end
                end
                
                bullet = self:spawnBullet("teeth_bottom", 230 + i*30, 245 + offset, 0, 0)
                bullet.alpha = 0
                bullet:fadeTo(1, 0.2)
                bullet.offset = offset
                if self.teeth_falling > 0 then
                    local rand = Utils.pick({1, 2, 3})
                    if rand == 1 then
                        bullet.fall = true
                        print(bullet.fall)
                        self.teeth_falling = self.teeth_falling - 1
                    else
                        bullet.fall = false
                    end
                end
            end
        end
        Assets.playSound("bump")
        self.timer:after(1.5, function ()
            Assets.playSound("swing")
            self.timer:after(0.4, function ()
                Assets.playSound("impact")
            end)
        end)
        self.teeth_falling = 3
        firstTimePassed = true
    end)
    self.double = #Game.battle.waves==2
    self.timer:every(self.double and 1.75 or 1, function()
        local x, y
        repeat
            x = Utils.random(30, SCREEN_WIDTH-30)
        until (x<Game.battle.arena.left or x>Game.battle.arena.right)
        repeat
            y = Utils.random(30, SCREEN_HEIGHT-30)
        until (y<Game.battle.arena.top or y>Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("secret/iceshock", x, y)
    end)
end

return Basic

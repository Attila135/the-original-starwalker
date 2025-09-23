local IceShocks, super = Class(Wave)

function IceShocks:init()
    super:init(self)
    self.time=10
end

function IceShocks:onStart()
    self.double = #Game.battle.waves==2
    self.timer:every(self.double and 0.75 or 0.25, function()
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

function IceShocks:update()
    -- Code here gets called every frame

    super:update(self)
end

return IceShocks
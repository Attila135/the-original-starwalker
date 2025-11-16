local Snowstorm, super = Class(Wave)

function Snowstorm:init()
    super.init(self)
    self.time=7
end

function Snowstorm:onArenaEnter()
    Game.battle.arena.color={0, 0, 1}
end

function Snowstorm:onStart()
    -- Every 0.33 seconds...
    self.timer:every(3/60, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(0, SCREEN_HEIGHT)

        local scale = Utils.random(0.25, 1)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("snowflakeBullet", x, y, math.rad(180), Utils.random(4,9), math.random()>0.5 and true or false, scale)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = false
    end)
    self.double = #Game.battle.waves==2
    self.timer:every(self.double and 1.75 or 0.50, function()
        local x, y
        repeat
            x = Utils.random(30, SCREEN_WIDTH-30)
        until (x>Game.battle.arena.right)
        repeat
            y = Utils.random(30, SCREEN_HEIGHT-30)
        until (y<Game.battle.arena.top or y>Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("secret/iceshock", x, y)
    end)
end

function Snowstorm:update()
    -- Code here gets called every frame

    Game.battle.arena:setPosition(Game.battle.arena.x-DTMULT, Game.battle.arena.y)

    super.update(self)
end

return Snowstorm
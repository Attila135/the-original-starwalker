local Bombs, super = Class(Wave)

function Bombs:init()
    super:init(self)
    self.time = 15
end

function Bombs:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(0.3, function()
        local x = arena.x + love.math.random(arena.width, SCREEN_WIDTH/2 - 50) * Utils.randomSign()
        local bombtype = Utils.pick{"laser", "shard", "pickaxe", "radiant"}
        self:spawnBullet("p5/kristalguardian/bomb_"..bombtype, x)
    end)
    self.double = #Game.battle.waves==2
    self.timer:every(self.double and 2.75 or 1.75, function()
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

return Bombs
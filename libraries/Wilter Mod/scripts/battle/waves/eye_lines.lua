local Basic, super = Class(Wave, "eye_lines")
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 10

    self:setArenaSize(200, 200)


    self.layer = BATTLE_LAYERS["above_arena"]
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())
    self.strings = {
        30,
        Game.battle.arena.width / 2,
        Game.battle.arena.width - 30
    }

    -- Every 0.33 seconds...
    self.timer:every(1/3, function()
        local mamadog = Utils.pick({"line1", "line2", "line3", "line1_2", "line2_2", "line3_2"})
        local spd = math.random(8,10)*Game:getFlag("bul_speed")
        
        if mamadog == "line1" then
            local x = SCREEN_WIDTH + 20
            local y = 100

            local bullet = self:spawnBullet("eyeball", x, y, math.rad(180), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line2" then
            local x = SCREEN_WIDTH + 20
            local y = 170

            local bullet = self:spawnBullet("eyeball", x, y, math.rad(180), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line3" then
            local x = SCREEN_WIDTH + 20
            local y = 240
            local bullet = self:spawnBullet("eyeball", x, y, math.rad(180), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line1_2" then
            local x = -20
            local y = 100

            local bullet = self:spawnBullet("eyeball_flipped", x, y, math.rad(0), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line2_2" then
            local x = -20
            local y = 170

            local bullet = self:spawnBullet("eyeball_flipped", x, y, math.rad(0), spd)

            bullet.remove_offscreen = false
        elseif mamadog == "line3_2" then
            local x = -20
            local y = 240
            local bullet = self:spawnBullet("eyeball_flipped", x, y, math.rad(0), spd)

            bullet.remove_offscreen = false
        end
    end)
end

return Basic

local Pufferfish, super = Class(Wave)

function Pufferfish:init()
    super:init(self)
    self.time = 9
    self:setArenaSize(300, 160)
    self:setSoulOffset(0, 20)
end

function Pufferfish:onStart()
    --Game.battle.encounter.extra_layer:fade(1, 2)

    local arena = Game.battle.arena
    local bx, by = arena.x, arena.top + 30
    self:spawnBullet("p3/grimm/balloon", bx, by)
    self.timer:every(1, function()
        self:spawnBulletTo(Game.battle.mask, "p3/grimm/pufferFireball", bx, by + 10, 4, math.pi/2 + Utils.random(-0.1, 0.1))
    end)
    self.timer:every(0.8, function()
        for _,speed in ipairs(Utils.pickMultiple({4.5, 8, 11.5}, 2)) do
            local angle = math.pi*(0.55 - 0.01*((speed-1)/3.5))
            self:spawnBulletTo(Game.battle.mask, "p3/grimm/pufferFireball", bx - 10, by + 12, speed, angle, 0.18)
        end
        for _,y in ipairs(Utils.pickMultiple({28, 4, -20}, 2)) do
            self:spawnBulletTo(Game.battle.mask, "p3/grimm/pufferFireball", bx + love.math.random(0, 12), by + y, 0, math.pi, 0.05)
        end
        for _,speed in ipairs(Utils.pickMultiple({4.5, 8, 11.5}, 2)) do
            local angle = math.pi*(0.45 + 0.01*((speed-1)/3.5))
            self:spawnBulletTo(Game.battle.mask, "p3/grimm/pufferFireball", bx + 10, by + 12, speed, angle, 0.18)
        end
        for _,y in ipairs(Utils.pickMultiple({28, 4, -20}, 2)) do
            self:spawnBulletTo(Game.battle.mask, "p3/grimm/pufferFireball", bx - love.math.random(0, 12), by + y, 0, 0, 0.05)
        end
    end)
    self.timer:every(1/9, function()
    self.speed = 2
    r = math.random(3)
    if r == 1 then
    local x = SCREEN_WIDTH + 20
    local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(180), 4)
    bullet:setScale(0.7)
    bullet.remove_offscreen = false
    elseif r == 2 then
    local x = SCREEN_WIDTH/2 - 250
    local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(0), 4)
    bullet:setScale(0.7)
    bullet.remove_offscreen = false
    elseif r == 3 then
    local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
    local y = Game.battle.arena.top - 100
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(90), 4)
    bullet:setScale(0.7)
    bullet.remove_offscreen = false
    elseif r == 4 then
    local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
    local y = Game.battle.arena.bottom + 100
    local bullet = self:spawnBullet("fire_1", x, y, math.rad(-90), 4)
    bullet:setScale(0.8)
    bullet.remove_offscreen = false
    end
end)
end

--[[function Pufferfish:onEnd()
    Game.battle.encounter.extra_layer:fade(0, 2)
end]]

return Pufferfish
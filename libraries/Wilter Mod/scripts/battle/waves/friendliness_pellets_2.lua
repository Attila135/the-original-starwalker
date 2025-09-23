---@diagnostic disable: undefined-global
local Basic, super = Class(Wave, "friendliness_pellets_2")
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 15
    self.arena_width = 350

    self.layer = BATTLE_LAYERS["above_arena"]

    self.circle = {}
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())

    --[[local vine = solidvine(true, Game.battle.arena:getRight()-20, Game.battle.arena.bottom, 20, -Game.battle.arena.height)
    vine.layer = BATTLE_LAYERS["bullets"]
    self:addChild(vine)]]

    self.timer:every(3, function()
        self.timer:script(function (wait)
            self.circle = {}
            Assets.playSound("pellet")
            local x, y = Game.battle.soul.x, Game.battle.soul.y
            for i = 1, 14 do 
                local angle = math.pi * 2 + i * math.pi / 7
                local r = 125
                local cx = r * math.sin( angle ) + x
                local cy = r * math.cos( angle ) + y
                local circle = self:spawnBullet("pellet", cx , cy ,math.rad(180), 0)
                circle:setScale(2, 2)
                circle.physics.direction = Utils.angle(circle.x, circle.y,x, y)
        --      circle.physics.direction = Utils.angle(math.pi, circle.y, Game.battle.soul.x, Game.battle.soul.y)

                table.insert(self.circle, circle)
                wait(0.01)
            end
        end)
        Game.stage.timer:after(0.5, function ()
            Assets.playSound("whoosh")
            for i=1, 14 do
                self.circle[i].physics.speed = 6*Game:getFlag("bul_speed")
                Game.world.timer:after(0.7, function()
                    self.circle[i]:remove()
                end)
            end
        end)
    end)

    self.timer:every(0.35, function()
        Assets.playSound("pellet")
        local angle = love.math.random() * 2 * math.pi
        local r = 200
        local bullet = self:spawnBullet("pellet", r * math.sin( angle ) + 320, r * math.cos( angle ) + 170, math.rad(180), 0)
        bullet.physics.direction = Utils.angle(bullet.x, bullet.y, Game.battle.soul.x, Game.battle.soul.y)

        Game.stage.timer:after(0.3, function ()
            bullet.physics.speed = -5*Game:getFlag("bul_speed")
            Game.world.timer:every(0.03, function()
            bullet.physics.speed = bullet.physics.speed + 1*Game:getFlag("bul_speed")
            end)
            Assets.playSound("whoosh")
        end)

    end)
end

function Basic:update()

    super.update(self)
end


return Basic
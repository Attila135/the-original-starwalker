---@diagnostic disable: undefined-global
local Basic, super = Class(Wave, "friendliness_pellets_1")
function Basic:init()
    super:init(self)

    -- Initialize timer
    self.time = 10

    self.layer = BATTLE_LAYERS["above_arena"]
end

function Basic:onStart()
    Game.battle:swapSoul(PurpleSoulSkerch())
    --[[
    self:addChild(Solid(false, Game.battle.arena:getLeft(), Game.battle.arena:getTop(), 16, Game.battle.arena.height))
    self:addChild(Solid(false, Game.battle.arena:getRight()-16, Game.battle.arena:getTop(), 16, Game.battle.arena.height))

    self.timer:every(2, function ()
        self.timer:script(function (wait)
            local x = Utils.pick({Game.battle.arena:getRight(), Game.battle.arena:getLeft()})

            if x == Game.battle.arena:getRight() then
                self:addChild(vinespike_warning(x-16, Game.battle.arena:getTop()+6))
            else
                self:addChild(vinespike_warning(x-6, Game.battle.arena:getTop()+6))
            end
            wait(0.2)
            Assets.playSound("alarm")
            wait(0.2)
            Assets.playSound("alarm")
            wait(0.2)
            Assets.playSound("alarm")
            wait(0.25)
            if x == Game.battle.arena:getRight() then
                local vine = self:addChild(solidvine(false, x, 101, 46, 142))
                vine.physics.speed_x = -4
                vine:setLayer(BATTLE_LAYERS["bullets"])
            else
                local vine = self:addChild(solidvine(false, x-50, 101, 46, 142))
                vine.physics.speed_x = 4
                vine:setLayer(BATTLE_LAYERS["bullets"])
            end
        end)
    end)]]


    -- Every 0.33 seconds...
    self.timer:every(1/2, function()
        Assets.playSound("pellet")
        local angle = love.math.random() * 2 * math.pi
        local r = 200
        local bullet = self:spawnBullet("pellet", r * math.sin( angle ) + 320, r * math.cos( angle ) + 170, math.rad(180), 0)
        bullet.physics.direction = Utils.angle(bullet.x, bullet.y, Game.battle.soul.x, Game.battle.soul.y)
        --bullet.sprite.rotation = bullet.physics.direction + math.rad(180)

        self.timer:after(1/3, function ()
            bullet.physics.speed = -5*Game:getFlag("bul_speed")
            self.timer:every(1/30, function()
                print(Game:getFlag("bul_speed"))
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
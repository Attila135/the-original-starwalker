local IceShock, super = Class(Bullet)

function IceShock:init(x, y)
    -- Last argument = sprite path
    super:init(self, x, y)

    self.x = x
    self.y = y
end

function IceShock:onWaveSpawn(wave)
    local function createParticle(x, y)
        local sprite = Sprite("effects/icespell/snowflake", x, y)
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(1.5)
        sprite.layer = BATTLE_LAYERS["bullets"]
        Game.battle:addChild(sprite)
        return sprite
    end

    local x, y = self.x, self.y

    local particles = {}
    Game.battle.timer:script(function(wait)
        wait(1/30)
        Assets.playSound("icespell")
        particles[1] = createParticle(x-25, y-20)
        wait(3/30)
        particles[2] = createParticle(x+25, y-20)
        wait(3/30)
        particles[3] = createParticle(x, y+20)
        wait(3/30)
        Game.battle:addChild(IceSpellBurst(x, y))
        local angle = love.math.random(360)
        for i=1,20 do
            self.wave:spawnBullet("lonelySnow", x, y, math.rad(angle+360/20*i), 6)
        end
        for _,particle in ipairs(particles) do
            for i = 0, 5 do
                local effect = IceSpellEffect(particle.x, particle.y)
                effect:setScale(0.75)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = BATTLE_LAYERS["bullets"] - 1
                Game.battle:addChild(effect)
            end
        end
        wait(1/30)
        for _,particle in ipairs(particles) do
            particle:remove()
        end
        self:remove()
    end)
end

function IceShock:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super:update(self)
end

return IceShock
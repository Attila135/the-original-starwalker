local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)
    self.direction = "vertical"

end

function Aiming:onStart()
    -- Swap the soul into the purple soul
    Game.battle:swapSoul(PurpleSoulSkerch())
    -- Set the height of all the strings(from the top of the arena), string order goes from top to bottom
    Game.battle.arena:setSize(200, 200)
    self.strings = {
        30,
        Game.battle.arena.width / 2,
        Game.battle.arena.width - 30
    }
    -- Set the amount of strings
    Game.battle.soul.string_count = 3
    -- Set the string the soul starts on
    Game.battle.soul.current_string = 2

    self.time = 16
	local asgore = self:spawnBullet("asgore_puppet", 520, 170, math.rad(0), 0)
    local toriel = self:spawnBullet("toriel_puppet", 120, 170, math.rad(0), 0)

    self.timer:after(1, function ()
        self.timer:every(1, function()

            -- Get the attacker's center position
            local x, y = toriel:getRelativePos(toriel.width/2, toriel.height/2)

            local speed = love.math.random(5,9)*Game:getFlag("bul_speed")

            local dir = Utils.pick({"up", "down"})

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self.timer:everyInstant(0.2, function ()
                local fire = self:spawnBullet("fire", x, y, 0, speed)
                Assets.stopAndPlaySound("firebreath")
                fire.direction = dir
            end, 3)
        end)
        self.timer:after(5, function()
                -- Get the attacker's center position
                local x, y = asgore:getRelativePos(asgore.width/2, asgore.height/2)

                -- Get the angle between the bullet position and the soul's position

                -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
                Assets.stopAndPlaySound("break2")
                local trident = self:spawnBullet("trident", x-50, y, math.rad(180), 5*Game:getFlag("bul_speed"))
        end)
    end)
end

function Aiming:update()
    -- Code here gets called every frame

    super.update(self)
end

return Aiming
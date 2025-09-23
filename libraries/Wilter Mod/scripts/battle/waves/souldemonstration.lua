local Basic, super = Class(Wave)
function Basic:init()
    super:init(self)

    -- This is a demonstration of the soul for DEVS, do not put this as one of wilter's attacks

    -- Initialize timer
    self.time = -1

    ------ Customizeability stuff, all besides the arena size is the default so if you want the default you don't need to include these(they're already set in the soul this just overrides the default)
    -- Sets the strings' direction, "horizontal", "vertical", there is no diagonal
    self.direction = "vertical"

    -- Sets the arena's size
    self:setArenaSize(142, 200)
end

function Basic:onStart()
    -- Swap the soul into the purple soul
    Game.battle:swapSoul(PurpleSoulSkerch())
    -- Set the height of all the strings(from the top of the arena), string order goes from top to bottom
    self.strings = {
        30,
        Game.battle.arena.width / 2,
        Game.battle.arena.width - 30
    }
    -- Set the amount of strings
    Game.battle.soul.string_count = 3
    -- Set the string the soul starts on
    Game.battle.soul.current_string = 2
    ------ Customization ends here

    --[[-- Every 2 seconds...
    self.timer:every(2, function ()
        -- Spawn 3 eyeballs
        for i=1, 3 do
            -- Spawn them at the string heights depending on the index
            self:spawnBullet("eyeball", 650, Game.battle.arena:getTop()+self.strings[i], math.pi, 8)
        end
    end)]]
end
return Basic

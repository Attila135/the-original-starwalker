function Mod:init()
    _G["COROUTINE_".."TRACEBACK"] = nil -- b
    print("Loaded "..self.info.name.."!")
    Utils.hook(PartyMember, "getStats", function (orig, self, ...)
        local stats = orig(self,...)
        if Kristal.Config["challenge"] then
            stats.health = 1
        end
        return stats
    end)
    Utils.hook(PartyMember, "getStat", function (orig, self, ...)
        local stat = ...
        if Kristal.Config["challenge"] and stat == "health" then
            return 1
        end
        return orig(self,...)
    end)
    Utils.hook(PartyMember, "getHealth", function (orig, self, ...)
        if Kristal.Config["challenge"] and self.health > 0 then
            return 1
        end
        return orig(self,...)
    end)
    Utils.hook(Battle, "drawDebug", function (orig, self, ...)
        ---@cast self Battle
        orig(self,...)
        local y = 32
        if self.waves[1] then
            self:debugPrintOutline("Current wave: " .. self.waves[1].id, 4, 0 + y)
            y = y + 16
        elseif Mod.last_wave then
            self:debugPrintOutline("Last wave: " .. Mod.last_wave, 4, 0 + y)
            y = y + 16
        end
        if self.enemies[1] and self.enemies[1].wave_override then
            self:debugPrintOutline("Next wave: " .. self.enemies[1].wave_override, 4, 0 + y)
            y = y + 16
        end
    end)
    Utils.hook(Battle, "onStateChange", function (orig, self, old, new)
        ---@cast self Battle
        orig(self, old, new)
        if new == "DEFENDINGBEGIN" then
            Mod.last_wave = (self.waves[1] or {}).id
        end
    end)
end

function Mod:save(data)
    data.flags = Utils.copy(data.flags)
    -- We REALLY don't want these flags to be saved. Not sure why they're flags, but whatever.
    data.flags.bul_speed = nil
    data.flags.bul_speed_prev = nil
    data.flags.soul_chargetime = nil
end

function Mod:postLoad()
    local new_file = Game.is_new_file
    Game:setFlag("bul_speed", 1)
    Game:setFlag("bul_speed_prev", 1)
    Game:setFlag("soul_chargetime", 1)
    if new_file then
        Game:setFlag("rng_door", 0)
        Game.money = 3561
        Game:setFlag("spike1", true)
        Game:setFlag("first_time", true)

        if Kristal.Config["skipto"] == "NONE" then
            Game:setFlag("postchase", false)
        elseif Kristal.Config["skipto"] == "CHASE" then
            Game:setFlag("postchase", false)
        elseif Kristal.Config["skipto"] == "FIGHT" then
            Game:setFlag("postchase", true)
        end

        Game.world:startCutscene("intro.elevator")
    end 
    Mod.attempted = false
    Mod.chase_attempted = false

    local kris, susie, ralsei = Game:getPartyMember("kris"), Game:getPartyMember("susie"), Game:getPartyMember("ralsei")
    kris.stats.health = 160
    kris.health = 160
    kris.max_stats.health = 160
    kris.level = 3
    susie.stats.health = 190
    susie.health = 190
    susie.max_stats.health = 190
    susie.level = 3
    ralsei.stats.health = 140
    ralsei.health = 140
    ralsei.max_stats.health = 140
    ralsei.level = 3
    Game.save_level = 3
end

function Mod:onFootstep(char, num)
    if Game.world.map.use_footstep_sounds and char == Game.world.player then
        if num == 1 then
            Assets.playSound("step1")
        elseif num == 2 then
            Assets.playSound("step2")
        end
    end
end

function Mod:getSoulColor()
    if self.soul_color_override then
        return Utils.unpackColor(self.soul_color_override)
    end
end

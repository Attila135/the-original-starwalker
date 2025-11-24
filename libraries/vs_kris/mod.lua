function Mod:init()
    print("Loaded "..self.info.name.."!")
end

Mod.flags = {
	Vs_Kris = true,
	Burning_HOPE = false,
	Your_Destiny = false,
    Can_kill = false,
    route = 0,
    attempted = false,
}

function Mod:postInit()
    Game.world:startCutscene("ask")
    Game.save_level = 1
end

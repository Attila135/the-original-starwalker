return function(cutscene)

	Kristal.hideBorder(0)
cutscene:fadeOut(0)
local text

local function gonerTextFade(wait)
	local this_text = text
	Game.world.timer:tween(1, this_text, { alpha = 0 }, "linear", function ()
		this_text:remove()
	end)
	if wait ~= false then
		cutscene:wait(1)
	end
end

local function gonerText(str, advance)
	text = DialogueText("[speed:0.5][spacing:2][style:GONER][voice:none]" .. str, 160, 100, 640, 480,
						{ auto_size = true })
	text.layer = WORLD_LAYERS["top"] + 100
	text.skip_speed = true
	text.parallax_x = 0
	text.parallax_y = 0
	Game.world:addChild(text)

	if advance ~= false then
		cutscene:wait(function () return not text:isTyping() end)
		gonerTextFade(true)
	end
end

	cutscene:wait(1)
	Game.world.music:play("AUDIO_DRONE", 1)
	local map = "a_familiar_place"
	    gonerText("CHOICE YOUR PATH", false)

		local chosen = nil
        local choicer = GonerChoice(220, 270, {
                                        { { "PACIFIST", -70, 0 }, { "<<" }, { ">>" }, { "WEIRD ROUTE", 150, 0 } }
                                    }, function (choice)
                                        chosen = choice
                                    end)
        choicer:setSelectedOption(2, 1)
        choicer:setSoulPosition(80, 0)
        Game.stage:addChild(choicer)

        cutscene:wait(function () return chosen ~= nil end)
		gonerTextFade()

		if chosen == "PACIFIST" then
            Game:getPartyMember("vessel").stats = {
				health = 90,
                attack = 12,
                defense = 2,
                magic = 0
			}
			Mod.flags = {
				weird = false,
				pacifist = true,
			}
		    Game:getPartyMember("vessel").level = 1
            Game:getPartyMember("vessel").health = 90
			--Game:setFlag("route", 0)
			Mod.route = 0
        else
            Game:getPartyMember("vessel").stats = {
				health = 130,
				attack = 15,
				defense = 4,
				magic = 0
			}
			Mod.route = 1
            Game:getPartyMember("vessel").health = 130
        end

		gonerText("CHOICE FIGHT MUSIC", false)

		local chosen = nil
        local choicer = GonerChoice(220, 270, {
                                        { { "VS. KRIS", -150, 0 }, { "BURNING HOPE", 15, 0 }, { "YOUR DESTINY", 230, 0 } }
                                    }, function (choice)
                                        chosen = choice
                                    end)
        choicer:setSelectedOption(2, 1)
        choicer:setSoulPosition(80, 0)
        Game.stage:addChild(choicer)

        cutscene:wait(function () return chosen ~= nil end)
		gonerTextFade()

		if chosen == "VS. KRIS" then
            Mod.flags = {
				Vs_Kris = true,
				Burning_HOPE = false,
				Your_Destiny = false,
			}
        elseif chosen == "BURNING HOPE" then
            Mod.flags = {
				Vs_Kris = false,
				Burning_HOPE = true,
				Your_Destiny = false,
			}
		elseif chosen == "YOUR DESTINY" then
            Mod.flags = {
				Vs_Kris = false,
				Burning_HOPE = false,
				Your_Destiny = true,
			}
        end
	
    cutscene:wait(1)
	cutscene:wait(cutscene:loadMap(map))
	Game.world.music:stop()
	cutscene:gotoCutscene("kris_encounter.wakeup")
	end
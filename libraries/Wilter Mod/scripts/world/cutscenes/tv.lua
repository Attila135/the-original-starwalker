-- GONER/START CUTSCENE

return {
    ---@param cutscene WorldCutscene
    
    tv = function (cutscene, event)
        local tape_a = Game.inventory:hasItem("tape_a")
        local tape_b = Game.inventory:hasItem("tape_b")
        local tape_c = Game.inventory:hasItem("tape_c")
        local tape_a_played = Game:getFlag("tapeplayed_a")
        local tape_b_played = Game:getFlag("tapeplayed_b")
        local tape_c_played = Game:getFlag("tapeplayed_c")
        local has_tape_a = nil
        local has_tape_b = nil
        local has_tape_c = nil
        cutscene:text("* (There is a television here.)")
        cutscene:text("* (There is a slot for a tape\nbeneath the television.)")
        if tape_a and not tape_a_played then

            cutscene:text("* (Play Tape A?)")
            cutscene:choicer({"Yes", "No"})
            if cutscene.choice == 1 then
                Game.world.music:fade(0,1)
                cutscene:wait(cutscene:fadeOut(1))
                cutscene:gotoCutscene("tv", "tape_a")
            end
            if cutscene.choice == 2 then
                cutscene:text("* (You left the television alone.)")
            end
        elseif tape_b and not tape_b_played then
            cutscene:text("* (Play Tape B?)")
            cutscene:choicer({"Yes", "No"})
            if cutscene.choice == 1 then
                Game.world.music:fade(0,1)
                cutscene:wait(cutscene:fadeOut(1))
                cutscene:gotoCutscene("tv", "tape_b")
            end
            if cutscene.choice == 2 then
                cutscene:text("* (You left the television alone.)")
            end
        elseif tape_c and not tape_c_played then
            cutscene:text("* (Play Tape C?)")
            cutscene:choicer({"Yes", "No"})
            if cutscene.choice == 1 then
                Game.world.music:fade(0,1)
                cutscene:wait(cutscene:fadeOut(1))
                cutscene:gotoCutscene("tv", "tape_c")
            end
            if cutscene.choice == 2 then
                cutscene:text("* (You left the television alone.)")
            end
        else
            cutscene:text("* (But you have no tapes to play.)")
        end
    end,
    ---@param cutscene WorldCutscene
    ---@param tape_id "a"|"b"|"c"
    tape = function (cutscene, tape_id)
        if Kristal.Config["skiptapes"] then
            Assets.stopAndPlaySound("tape_insert")
            cutscene:wait(1)
            Assets.stopAndPlaySound("tape_eject")
            cutscene:wait(cutscene:fadeIn(1))
            cutscene.world.music:play("garden")
            cutscene:text("* You tried to play the tape.")
            cutscene:text("* But it seems like the Ring Fragment was already in your hand.")
            Assets.stopAndPlaySound("item")
            cutscene:text("* (You got the [color:yellow]RingFrag "..tape_id:upper().."[color:reset].)")
            Game.inventory:addItem("ring_frag_"..tape_id)
            Game.inventory:removeItem("tape_"..tape_id)
            Game:setFlag("tapeplayed_"..tape_id, true)
            Game:addFlag("ringshards", 1)
            Assets.stopAndPlaySound("creepy_jingle")
            return false
        end

        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:wait(cutscene:fadeOut(0))
        cutscene.world.music:stop()
        cutscene:wait(1)
        Assets.stopAndPlaySound("tape_insert")
        cutscene:wait(3)
        -- Ugly hack because SOMEONE thought it would be a WONDERFUL idea to
        -- make the names of the flags and files different just to cause me a headache.
        ---@type Music
        local music = Music("tape_"..(tape_id:byte() - 96))
        music:setVolume(2)
        -- Also, fun fact. This used to be a hardcoded wait of 98.455 seconds.
        music:setLooping(false)
        if Kristal.Config["subtitles"] then
            ---@type Subtitle
            local subtitle = Subtitle(music, "tape_"..tape_id)
            subtitle.macros = {
                -- Hmmm...
                ["W"] = "color:#ff00ff",
                ["D"] = "color:#61e8b0",
                ["G"] = "style:GONER",
            }
            cutscene.world:spawnObject(subtitle, "below_textbox")
            cutscene:wait(function () return not music:isPlaying() end)
            subtitle:remove()
            music:remove()
        else
            cutscene:wait(function () return not music:isPlaying() end)
            music:remove()
        end
        cutscene:wait(1)
        Assets.stopAndPlaySound("tape_eject")
        cutscene:wait(2)
        Game:setFlag("tapeplayed_"..tape_id, true)
        cutscene:wait(cutscene:fadeIn(1))
        return true
    end,
    tape_a = function (cutscene, event)
        if cutscene:gotoCutscene("tv.tape", "a") == false then return end
        cutscene.world.music:play("garden", 1)
        cutscene:setSpeaker("ralsei")
        cutscene:text("* .[wait:2].[wait:2].", "surprise_confused")
        cutscene:text("* T-[wait:2] That voice.", "surprise_neutral")
        cutscene:text("* I could've sworn it sounded similar to.[wait:2].[wait:2].", "surprise_neutral_side")
        cutscene:setSpeaker("susie")
        cutscene:text("* It's Director.\n[wait:2]* It has to be.", "shy_down")
        cutscene:text("* He's the reason Wilter is stuck here.", "annoyed_down")
        cutscene:text("* I'm sure of it.", "annoyed_down")
        cutscene:setSpeaker("ralsei")
        cutscene:text("* But why was Wilter so.[wait:2].[wait:2].[wait:4]\n* Aggressive?", "frown_b")
        cutscene:setSpeaker("susie")
        cutscene:text("* Hell if I know.", "nervous")
        cutscene:text("* Doesn't make greenie look any better though.", "angry_b")
        Assets.stopAndPlaySound("item")
        cutscene:setSpeaker(nil)
        cutscene:text("* As you reached for the tape.[wait:5]\n* Something else came out instead..?")
        cutscene:text("* (You got the [color:yellow]RingFrag A[color:reset].)")
        Game.inventory:removeItem("tape_a")
        Game.inventory:addItem("ring_frag_a")
        Game:addFlag("ringshards", 1)
        Assets.stopAndPlaySound("creepy_jingle")
        cutscene:attachFollowers()
        cutscene:attachCamera()
    end,

    tape_b = function (cutscene, event)
        if cutscene:gotoCutscene("tv", "tape", "b") == false then return end
        cutscene.world.music:play("garden", 1)
        cutscene:setSpeaker("susie")
        cutscene:text("* Who the hell was that!?", "teeth")
        cutscene:text("* I could barely make out what he said!", "angry_c")
        cutscene:text("* .[wait:2].[wait:2].", "annoyed_down")
        cutscene:text("* Got any bright ideas,[wait:2] Ralsei?", "nervous_side")
        cutscene:setSpeaker("ralsei")
        cutscene:text("* .[wait:2].[wait:2].", "roaring")
        cutscene:setSpeaker("susie")
        cutscene:text("* Ralsei?", "sad")
        cutscene:setSpeaker("ralsei")
        cutscene:text("* .[wait:2].[wait:2].[wait:4]\n* I don't want to talk about it.", "no_glasses_closed")
        Assets.stopAndPlaySound("item")
        cutscene:setSpeaker(nil)
        cutscene:text("* As you reached for the tape.[wait:5]\n* Something else came out instead..?")
        cutscene:text("* (You got [color:yellow]RingFrag B[color:reset].)")
        Game.inventory:removeItem("tape_b")
        Game.inventory:addItem("ring_frag_b")
        Game:addFlag("ringshards", 1)
        Assets.stopAndPlaySound("creepy_jingle")
        cutscene:attachFollowers()
        cutscene:attachCamera()
    end,

    tape_c = function (cutscene, event)
        if cutscene:gotoCutscene("tv", "tape", "c") == false then return end
        cutscene:setSpeaker(nil)
        cutscene:text("* (There are tears running down your face.)")
        cutscene:setSpeaker("ralsei")
        cutscene:text("* [speed:0.25]...", "roaring")
        cutscene:setSpeaker("susie")
        cutscene:text("* [speed:0.25]...", "bangs_neutral")
        cutscene.world.music:play("garden")
        Assets.stopAndPlaySound("item")
        cutscene:setSpeaker(nil)
        cutscene:text("* As you reached for the tape.[wait:5]\n* Something else came out instead..?")
        cutscene:text("* (You got [color:yellow]RingFrag C[color:reset].)")
        Game.inventory:removeItem("tape_c")
        Game.inventory:addItem("ring_frag_c")
        Game:addFlag("ringshards", 1)
        Assets.stopAndPlaySound("creepy_jingle")
        cutscene:attachFollowers()
        cutscene:attachCamera()
        cutscene.world.music:play("garden", 1)
    end

}
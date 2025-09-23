return {
    cantleave = function(cutscene, event)
        --getCharacter for Kris, just in case.
        local kris = cutscene:getCharacter("kris")
        -- Open textbox and wait for completion
        cutscene:text("* (Can't go back now.)")
        cutscene:walkTo(kris, 320,Game.world.player.y - 50, 1)


       
    end,

    cantleave_2 = function(cutscene, event)
        --getCharacter for Kris, just in case.
        local kris = cutscene:getCharacter("kris")
        -- Open textbox and wait for completion
        cutscene:text("* (Can't go back now.)")
        cutscene:walkTo(kris, Game.world.player.x ,Game.world.player.y - 50, 1)


       
    end,

    cantenter = function(cutscene, event)
        --getCharacter for Kris, just in case.
        local kris = cutscene:getCharacter("kris")
        local enter = Game:getFlag("wilterdefeated")
        -- Open textbox and wait for completion
        cutscene:text("* (It's too dark to see anything.)")
        cutscene:text("* (Best not to go into this room.)")
        cutscene:walkTo(kris, "backstage", 1)


       
    end,

    puzzle_correct = function(cutscene, event)
        Assets.playSound("locker")
        Game.world.camera:shake(1)
        cutscene:text("* (Sounds like spikes receeding.)")
    end,

    ---@param tape_id "a"|"b"|"c"
    tapecollect = function (cutscene, event, tape_id)
        -- TODO: Why the hell are the tapes NPCs, and not like, Interactable tile objects? Is there a lore reason?
        local tape = cutscene:getCharacter("tape")

        if not Game:getFlag("tapecollect_"..tape_id) then
            cutscene:text("* (There is a tape here.) ")
            cutscene:text("* (Would you like to pick it up?)")
            if cutscene:choicer({"Yes", "No"}) == 1 then
                tape:remove()
                Assets.stopAndPlaySound("item")
                cutscene:text(("* (You got [color:yellow]Tape %s[color:reset].) "):format(tape_id:upper()))
                Game.inventory:addItem("tape_"..tape_id)
                Game:setFlag("tapecollect_"..tape_id, true)
                return true
            else
                cutscene:text("(You left the tape alone.) ")
                return false
            end
        end
    end,

    colorblind_toggle = function (cutscene)
        if Kristal.Config["colorblind"] then
            Game.world.map:getTileLayer("Tile Layer 4").y = 0
        end
    end,

    tapecollect_a = function (cutscene, event)
        cutscene:gotoCutscene("generic.tapecollect", event, "a")
    end,

    tapecollect_b = function (cutscene, event)
        cutscene:gotoCutscene("generic.tapecollect", event, "b")
    end,


    tapecollect_c = function (cutscene, event)
        cutscene:gotoCutscene("generic.tapecollect", event, "c")
    end,


    doorappear = function (cutscene, event)
        local facing = Game.world.player.facing
        if Game.inventory:hasItem("ring_frag_a") and Game.inventory:hasItem("ring_frag_b") and Game.inventory:hasItem("ring_frag_c") then
            
        cutscene:text("* There's a projector here,\n* It seems to have a slot for a ring.")
        cutscene:text("* Insert the ring fragments?")
        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 2 then
            return
        else
            local door = Sprite("objects/door", 360, 160)
            door.alpha = 0
            door.wave_shader = love.graphics.newShader([[
        extern number wave_sine;
        extern number wave_mag;
        extern number wave_height;
        extern vec2 texsize;
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {
            number i = texture_coords.y * texsize.y;
            number v = texture_coords.x * texsize.x;
            vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + (sin((v / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.y)));
            return Texel(texture, coords) * color;
        }
                
            ]])
            
            door.wave_fx = ShaderFX(door.wave_shader, {
                ["wave_sine"] = function() return Kristal.getTime() * 20 end,
                ["wave_mag"] = 1,
                ["wave_height"] = 5,
                ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
            }, false, 1)
            door:addFX(door.wave_fx, "wave_fx")

            Game.world:spawnObject(door)
            Assets.playSound("ghostappear")
            Game.stage.timer:tween(1, door, {alpha=1})
            Game:setFlag("doorappear", true)
            cutscene:wait(1)
            local kris = cutscene:getCharacter("kris")
            local susie = cutscene:getCharacter("susie")
            local ralsei = cutscene:getCharacter("ralsei")

            cutscene:detachFollowers()

            if facing == "right" then
                cutscene:walkTo("kris", "gathering_left", 1)
                cutscene:walkTo("ralsei", "gathering_left", 1)
                cutscene:walkTo("susie", "gathering_left", 1)
                cutscene:wait(1)
            elseif facing == "left" then
                cutscene:walkTo("kris", "gathering_right", 1)
                cutscene:walkTo("ralsei", "gathering_right", 1)
                cutscene:walkTo("susie", "gathering_right", 1)
                cutscene:wait(1)
            elseif facing == "up" then
                cutscene:walkTo("kris", "gathering_left", 1)
                cutscene:walkTo("ralsei", "gathering_right", 1)
                cutscene:walkTo("susie", "gathering_left", 1)
                cutscene:wait(1)
            elseif facing == "down" then
            end

            cutscene:walkTo("kris", "kris_2", 1.5,"up")
            cutscene:walkTo("ralsei", "ralsei_2", 1.5,"up")
            cutscene:wait(cutscene:walkTo("susie", "susie_2", 1.5,"up"))

            cutscene:look("kris", "up")
            cutscene:look("susie", "up")
            cutscene:look("ralsei", "up")

            cutscene:wait(1)

            cutscene:text("* Wait..[wait:5].[wait:10] Did this door just appear out of that projector?", "suspicious", "susie")

            kris:shake()
            Assets.stopAndPlaySound("bump")
            cutscene:wait(1)

            cutscene:text("* Uhh Kris?[wait:10] You want us to wait outside?", "nervous_side", "susie")
            cutscene:text("* Are you sure about that?[wait:10]\n* This place seems pretty dangerous..[wait:5].", "nervous", "susie")
            cutscene:text("* I think they're sure Susie.", "neutral", "ralsei")
            cutscene:text("* Fine..[wait:5].[wait:10]\n* Just make sure to stay safe[wait:5], alright Kris?", "neutral", "susie")

            cutscene:wait(cutscene:walkTo("kris", 380, 240, 2))
            Game:setPartyMembers("kris")
            cutscene:mapTransition("wilters_room", "entry")
            Assets.stopAndPlaySound("dooropen")
            cutscene:wait(0.5)
            Assets.playSound("doorclose")
        end
        end
    end,

    save = function (cutscene, event)
        Game:saveQuick()
    end,

    --[[wilterroomdoor = function (cutscene, event)
        if Game:getFlag("doorappear") then
            local kris = cutscene:getCharacter("kris")
            local susie = cutscene:getCharacter("susie")
            local ralsei = cutscene:getCharacter("ralsei")

            cutscene:detachFollowers()

            cutscene:walkTo("kris", "kris", 1)
            cutscene:walkTo("susie", "susie", 1)
            cutscene:wait(cutscene:walkTo("ralsei", "ralsei", 1))

            cutscene:look("kris", "up")
            cutscene:look("susie", "up")
            cutscene:look("ralsei", "up")

            cutscene:text("* Kris?[wait:10] You want us to wait outside?", "nervous_side", "susie")
            cutscene:text("* Are you sure about this?[wait:10]\n* This place seems pretty dangerous..[wait:5].", "nervous", "susie")
            cutscene:text("* I think they're sure Susie.", "neutral", "ralsei")
            cutscene:text("* Fine..[wait:5].[wait:10] Just make sure to stay safe[wait:5], alright Kris?", "neutral", "susie")

            cutscene:wait(cutscene:walkTo("kris", 380, 240, 1))
            Game:setPartyMembers("kris")
            cutscene:mapTransition("wilters_room", "entry")
        end
    end,]]

    nodoor = function (cutscene, event)
        if not Game:getFlag("doorappear") then
            cutscene:text("* This wall is suspiciously doorless...")
        end
    end,

    picture = function (cutscene, event)
        local picture = cutscene:getCharacter("picture")
        local tapecollected = Game:getFlag("picture_collected")
            if Game.inventory:hasItem("key") == false then
                cutscene:slideTo(picture, "picture", 0.0001)
            else
                picture:remove()

            end
        end,
    picture_collect = function (cutscene, event)
        -- TODO: Okay I could actually see a lore argument for this one? Maybe?
        local tape = cutscene:getCharacter("picture")
        if Game:getFlag("picture_collected") then return end
        cutscene:text("* (It's a photo of you and your brother.) ")
        cutscene:text("* (You both look happy...) ")
        cutscene:text("* (There is a key on the back of the photo.)")
        tape:remove()
        Assets.stopAndPlaySound("item")
        cutscene:text("* (You got the [color:yellow]WiltKey[color:reset].)")
        Game.inventory:addItem("key")
        Game:setFlag("picture_collected", true)
        end,

    puzzle = function (cutscene, event)
        local flag1 = Game:getFlag("ruins1Puzzle")
            if flag1 == false then
                Game:setFlag("spike1", true)
            elseif flag1 == true then
                Game:setFlag("spike1", false)
            end
    end,

    candy = function (cutscene, event)
        local taken = Game:getFlag("candy_taken")
        if Game:getFlag("candy_taken") == false then
            cutscene:text("* There is a lone piece of candy in this bowl.")
            cutscene:text("* Will you take it?")
            cutscene:choicer({"Yes", "No"})
            if cutscene.choice == 1 then
                cutscene:text("* You got [color:yellow]RockCandy[color:reset].")
                Game.inventory:addItem("rock_candy")
                Game:setFlag("candy_taken", true)
            elseif cutscene.choice == 2 then
                Game:setFlag("candy_taken", false)
            end
        else
            cutscene:text("* The bowl is empty.")
        end
    end,

    credits = function (cutscene, event)
        local kris = cutscene:getCharacter("kris")
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")
        local door = Game.world.map:getEvent("elevator_door")
        if kris then
            door:setPosition(11111111, 11111)
            cutscene:panTo("cam_1", 0.000001)
            cutscene:detachCamera()
            cutscene:detachFollowers()
            cutscene:fadeOut(0.00001)
            cutscene:wait(3)
            ralsei.y = ralsei.y + 1
            susie.y = susie.y + 2
            Assets.stopAndPlaySound("elecdoor_open")
            cutscene:fadeIn(1)
            cutscene:walkTo("susie", "kris2", 1)
            cutscene:wait(1)
            cutscene:walkTo("susie", "susie", 1)
            cutscene:walkTo("ralsei", "kris2", 1)
            cutscene:wait(1)
            susie:setSprite("wall_right")
            cutscene:walkTo("ralsei", "ralsei", 1)
            cutscene:walkTo("kris", "kris3", 1)
            cutscene:wait(1)
            cutscene:look("ralsei", "left")
            cutscene:walkTo("kris", "kris", 1)
            cutscene:wait(1)
            cutscene:look("kris", "up")
            cutscene:wait(1)
            cutscene:look("kris", "up")
            Assets.stopAndPlaySound("noise")
            cutscene:wait(0.5)
            door:setPosition(284.00, 146.00)
            Assets.stopAndPlaySound("elecdoor_shut")
            door:setSprite("objects/elevator_open_3")
            cutscene:wait(0.05)
            door:setSprite("objects/elevator_open_2")
            cutscene:wait(0.05)
            Game.world.camera:shake(3)
            door:setSprite("objects/elevator_open_1")
            cutscene:wait(0.05)
            door:setSprite("objects/elevator_door")
            cutscene:wait(0.35)
            cutscene:walkTo("kris", "kris2", 1, "left")
            cutscene:wait(1)
            cutscene:look("kris", "down")
            cutscene.world.music:setVolume(1)
            Game.world.music:play("credit")
            Game.world.music:setLooping(false)
            cutscene:wait(2)
            Game.world.timer:after(68, function ()
                local logo = cutscene:getEvent("credits_kristal")
                logo.animation_phase = 1
            end)
            cutscene:wait(cutscene:panTo("cam_2", 90))

            cutscene:wait(28)
            Game.world.music:stop()
            cutscene:fadeOut(3)
            Kristal.Config["GameBeaten"] = true
            --Kristal.Config["debug"] = true
            cutscene:wait(3)
            Kristal.returnToMenu()
        end
    end,
    pre_transform_1 = function (cutscene, event)
        local wilter = cutscene:getCharacter("wilter")
        cutscene:setSpeaker(wilter)
        cutscene:text("[speed:0.3]* Tori,[wait:4] Tori,[wait:4]")
        cutscene:text("[speed:0.3]* Give me your answer,[wait:4] do.")
    end,

    pre_transform_2 = function (cutscene, event)
        local wilter = cutscene:getCharacter("wilter")
        cutscene:setSpeaker(wilter)
        cutscene:text("[speed:0.3]* I'm[wait:4] half[wait:4] crazy.")
        cutscene:text("[speed:0.3]* All for the[wait:4] love[wait:4] of you.")
    end,

    pre_transform_3 = function (cutscene, event)
        local wilter = cutscene:getCharacter("wilter")
        cutscene:setSpeaker(wilter)
        cutscene:text("[speed:0.3]* It won't be a[wait:4] stylish[wait:4] marriage.")
        cutscene:text("[speed:0.3]* I can't[wait:4] afford[wait:4] a carriage.")
    end,

    pre_transform_4 = function (cutscene, event)
        local wilter = cutscene:getCharacter("wilter")
        cutscene:setSpeaker(wilter)
        cutscene:text("[speed:0.3]* But you'll look sweet,[wait:4] upon a seat.")
        cutscene:text("[speed:0.3]* Of a bicycle built for two.")
    end,

    pre_transform_5 = function (cutscene, event)
        cutscene:text("* (You hear faint sobbing nearby.)")
    end,

    pre_transform = function (cutscene, event)
        cutscene:text("* (You hear singing up ahead.)")
    end,

    random_room = function (cutscene, event)
        Game:addFlag("rng_door", 1)
        local value = love.math.random(1,20)
        if Game:getFlag("rng_door") == 4 then
            cutscene:mapTransition("dressing_room", "spawn")
        else
            if value == 1 or value == 5 or value == 11 or value == 15 then
                cutscene:mapTransition("candy_room", "spawn")
            elseif value == 2 or value == 6 or value == 12 or value == 16 then
                cutscene:mapTransition("bedroom", "spawn")
            elseif value == 3 or value == 7 or value == 13 or value == 17 then
                cutscene:mapTransition("party", "spawn")
            elseif value == 4 or value == 14 or value == 19 then
                cutscene:mapTransition("dressing_room", "spawn")
            elseif value == 8 or value == 10 or value == 18 or value == 20 then
                cutscene:mapTransition("puppet_room", "spawn")
            elseif value == 9 then
                cutscene:mapTransition("steve", "spawn")
            end
        end

        Assets.stopAndPlaySound("dooropen")
        cutscene:wait(0.5)
        Assets.playSound("doorclose")
    end,

    projector_check = function (cutscene, event)
        if Game.inventory:hasItem("ring_frag_a") and Game.inventory:hasItem("ring_frag_b") and Game.inventory:hasItem("ring_frag_c") then
            (Game.world.map:getEvent(77)).solid = true
        local obj = Sprite("objects/projector", 442, 542)
        obj:setScale(2,2)
        obj:setOrigin(2,2)

        Game.world:spawnObject(obj)
    
    else
        (Game.world.map:getEvent("interactable")).solid = false
    end
end,
    final_leave = function (cutscene, event)
        if Game.inventory:hasItem("key") then
            cutscene:text("* It's time to go.")
            cutscene:fadeOut(2)
            cutscene:wait(2)
            cutscene:loadMap("credit_room", "spawn")
            cutscene:wait(1)
            cutscene:gotoCutscene("generic.credits")
        else
            cutscene:text("* You still need the key.")
            local kris = cutscene:getCharacter("kris")
            cutscene:walkTo("kris", "spawn", 1)
            cutscene:wait(1)

        end
    end
}

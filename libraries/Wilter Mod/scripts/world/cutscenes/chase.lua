
---@type table<string, fun(cutscene:WorldCutscene,...)>
local chase = {
    death = function (cutscene, event)

        cutscene:fadeOut(0)
        for _, bullet in ipairs(Game.world.bullets) do
            print(bullet.id)
            bullet.active = false
            bullet.collidable = false
            bullet:remove()
        end

        -- Ugly hack due to outdated kristal
        Game.world:setBattle(false)
        Game.world.battle_alpha = 0
        cutscene:wait(0)
        Game.world.soul:remove()
        Game.world:loadMap("death")

        for key, soundinst in pairs(Assets.sound_instances) do
            Assets.stopSound(key)
        end
        Game:setFlag("died_to_Chase", true)
        Game.world.player:setPosition(-100, -100)
        Game.world.music:pause()
        Assets.stopAndPlaySound("grab")
        cutscene:wait(1)
        cutscene:setSpeaker("wilter")
        cutscene:text("* Got's you!")
        cutscene:setSpeaker("omeg_wilter")
        cutscene:text("* [speed:0.5][shake:2]NOW I'LL NEVER BE ALONE'S AGAIN'S!")
        Assets.stopAndPlaySound("wilt_epic_laugh")
        cutscene:wait(5.5)
        Mod.chase_attempted = true
        --cutscene:fadeIn(0)
        --Kristal.loadGame(Game.save_id, false)
        Game:setFlag("died_to_Chase", false)
        Game:loadQuick()
        Game.world.music:resume()
    end,

    start = function (cutscene, event)
        --[[local novine = Game.world.map:getShapes("novine")
        for i=1, #novine do
            for _, point in ipairs(novine[i]["polygon"]) do
                print(point["x"], point["y"])
            end
        end]]
        cutscene:fadeIn(1)
        local wilter = cutscene:getCharacter("omeg_wilter")
        Game.world.music:pause()
        cutscene:setSpeaker("omeg_wilter")
        cutscene:text("*[speed:0.2][shake:2] HERE I COME!")
        Game.world.music:resume()
        cutscene:wait(0.1)
        Game.world:spawnBullet("head", 880, 60.00, false)
        wilter:setAnimation("laugh")
        Assets.stopAndPlaySound("wilt_big_laugh_2")
    end,


    start2 = function (cutscene, event)
        cutscene:fadeIn(0.00000001)
        Assets.playSound("noise")
        local wilter = cutscene:getCharacter("omeg_wilter")
        Game.world.music:pause()
        cutscene:setSpeaker("omeg_wilter")
        cutscene:text("*[speed:0.2][shake:2] HERE I COME!")
        Game.world.music:resume()
        cutscene:wait(0.1)
        Game.world:spawnBullet("head", 880, 60.00, false)
        wilter:setAnimation("laugh")
        Assets.stopAndPlaySound("wilt_big_laugh_2")
    end,


    transform = function (cutscene, event)
        if not Game:getFlag("chase_attempted") then
            Game:setFlag("chase_attempted", true)
            Game:saveQuick()
            cutscene:walkTo("kris", "kris_1", 2)
            local wilter = cutscene:getCharacter("wilter")
            wilter:setSprite("walk/up")
            cutscene:detachCamera()
            cutscene:detachFollowers()
            cutscene:panTo("wilt_pan", 2)
            Game.world.music:fade(0,2)
            cutscene:wait(2)
            wilter:setSprite("walk/right")
            cutscene:wait(1)
            wilter:setSprite("walk/down")
            cutscene:wait(1)
            cutscene:setSpeaker("wilter")
            cutscene:setTextboxTop(false)
            cutscene:text("* Well's,[wait:2] speak's of the devil's!")
            cutscene:text("* I knew's you'd come here.[wait:2].[wait:2].")
            cutscene:text("* After all's,[wait:2] we're best's friends!")
            cutscene:text("* It's always good's to play's with our buddies's,[wait:2] ain't it's?")
            cutscene:text("* So.[wait:2].[wait:2].")
            wilter:setAnimation("transform_1")
            wilter:shake(5)
            cutscene:slideTo(wilter, wilter.x, wilter.y + 25, 0.25)
            Assets.playSound("petrify")
            cutscene:wait(1.3)
            wilter:setSprite("transform/wilter_transform_one_13")
            cutscene:text("* READY.")
            wilter:shake(5)
            cutscene:slideTo(wilter, wilter.x, wilter.y + 25, 0.1)
            wilter:setAnimation("transform_2")
            Assets.playSound("damage")
            cutscene:wait(0.7)
            wilter:setSprite("transform/wilter_transform_two_7")
            cutscene:text("* OR.")
            cutscene:slideTo(wilter, wilter.x, wilter.y + 25, 0.1)
            wilter:shake(5)
            wilter:setAnimation("transform_3")
            Assets.playSound("damage")
            cutscene:wait(0.7)
            wilter:setSprite("transform/wilter_transform_three_7")
            cutscene:text("* NOT.")
            cutscene:fadeOut(0)
            cutscene:wait(0.1)
            Game.world:loadMap("chase_room_1")
            Assets.playSound("noise")
            Game.world.music:pause()
            cutscene:wait(1)
            cutscene:fadeIn(0.00000001)
            Assets.playSound("noise")
            local wilter = cutscene:getCharacter("omeg_wilter")
            Game.world.music:pause()
            cutscene:setSpeaker("omeg_wilter")
            cutscene:text("*[speed:0.2][shake:2] HERE I COME!")
            Game.world.music:resume()
            cutscene:wait(0.1)
            Game.world:spawnBullet("head", 880, 60, false)
            wilter:setAnimation("laugh")
            Assets.stopAndPlaySound("wilt_big_laugh_2")
        else
            cutscene:fadeOut(0)
            cutscene:wait(0.1)
            Game.world:loadMap("chase_room_1")
            Assets.playSound("noise")
            Game.world.music:pause()
            cutscene:wait(1)
            cutscene:fadeIn(0.00000001)
            Assets.playSound("noise")
            local wilter = cutscene:getCharacter("omeg_wilter")
            Game.world.music:pause()
            cutscene:setSpeaker("omeg_wilter")
            cutscene:text("*[speed:0.2][shake:2] HERE I COME!")
            Game.world.music:resume()
            cutscene:wait(0.1)
            Game.world:spawnBullet("head", 880, 60, false)
            wilter:setAnimation("laugh")
            Assets.stopAndPlaySound("wilt_big_laugh_2")
        end
        
    
        
    end,

    transform_scrapped = function (cutscene, event)
        if Mod.chase_attempted == true then
            local wilter = cutscene:getCharacter("wilter")
            wilter:setSprite("walk/up")
            cutscene:detachCamera()
            cutscene:detachFollowers()
            cutscene:panTo("wilt_pan", 2)
            cutscene:fadeOut(2)
            Game.world.music:fade(0,2)
            cutscene:wait(2)
            Game.world.music:pause()
            local video = Video("transform", true, 0, 0, 640, 480) -- assets/videos/video_here.ogv
            video.parallax_x, video.parallax_y = 0, 0
            video:play()
            Game.stage:addChild(video)
            cutscene:wait(0.0001)
            cutscene:wait(function() return not video:isPlaying() end)
            video:remove()
            Game.world:loadMap("chase_room_1")
            Game.world.music:pause()
            cutscene:gotoCutscene("chase.start")
        else 
            cutscene:endCutscene()
            cutscene:gotoCutscene("chase.start")
        end
        
    
        
    end,

    transform_short = function (cutscene, event)
        local wilter = cutscene:getCharacter("wilter")
        wilter:setSprite("walk/up")
        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:panTo("wilt_pan", 2)
        Game.world.music:fade(0,2)
        cutscene:wait(2)
        wilter:setSprite("walk/right")
        cutscene:wait(1)
        wilter:setSprite("walk/down")
        cutscene:wait(1)
        cutscene:setSpeaker("wilter")
        cutscene:setTextboxTop(false)
        cutscene:text("* Well's,[wait:2] speak of the devil's!")
        cutscene:text("* I knew's you'd come here.[wait:2].[wait:2].")
        cutscene:text("* After all's,[wait:2] we're best's friends!")
        cutscene:text("* It's always good's to play's with our buddies's, ain't it's?")
        cutscene:text("* So.[wait:2].[wait:2].")
        wilter:setAnimation("transform_1")
        wilter:shake(5)
        cutscene:slideTo(wilter, wilter.x, wilter.y + 25, 0.25)
        Assets.playSound("petrify")
        cutscene:wait(1.3)
        wilter:setSprite("transform/wilter_transform_one_13")
        cutscene:text("* READY.")
        wilter:shake(5)
        cutscene:slideTo(wilter, wilter.x, wilter.y + 25, 0.1)
        wilter:setAnimation("transform_2")
        Assets.playSound("damage")
        cutscene:wait(0.7)
        wilter:setSprite("transform/wilter_transform_two_7")
        cutscene:text("* OR.")
        cutscene:slideTo(wilter, wilter.x, wilter.y + 25, 0.1)
        wilter:shake(5)
        wilter:setAnimation("transform_3")
        Assets.playSound("damage")
        cutscene:wait(0.7)
        wilter:setSprite("transform/wilter_transform_three_7")
        cutscene:text("* NOT.")
        cutscene:fadeOut(0.00000001)
        Assets.playSound("noise")
        cutscene:wait(0.001)
        Game.world:loadMap("chase_room_1")
        cutscene:fadeOut(0.00000001)
        Game.world.music:pause()
        cutscene:wait(1)
        cutscene:gotoCutscene("chase.start2")
        
    end,


    door = function (cutscene, event)
        local wilter = cutscene:getCharacter("omeg_wilter")
        local kris = cutscene:getCharacter("kris")
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")
        local door = cutscene:getEvent("door")
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
        Game.world.music:play("garden", 2)
        Game.world.music:setLooping(true)
        kris:setPosition(Game.world.map:getMarker("spawn"))
        cutscene:walkTo(kris, "kris", 0.25)
        cutscene:wait(0.25)
        susie:setSprite("shock_left")
        ralsei:setSprite("surprised_down")
        kris:setSprite("landed_1")
        Assets.playSound("impact")
        cutscene:wait(0.1)
        kris:setSprite("landed_2")
        cutscene:wait(1)
        susie:resetSprite()
        cutscene:look(susie, "left")
        cutscene:walkTo(susie, susie.x-10, susie.y, 0.5, "left")
        cutscene:setSpeaker(susie)
        cutscene:text("* Kris,[wait:5] are you okay!?", "sad")
        cutscene:text("* What happened!?", "sad_frown")
        ralsei:resetSprite()
        cutscene:look(ralsei, "right")
        cutscene:walkTo(ralsei, ralsei.x+10, ralsei.y, 1, "right")
        cutscene:setSpeaker(ralsei)
        cutscene:text("* There,[wait:5] there.[wait:5] It's going to be okay.", "smile", ralsei)
        Game.world.music:stop()
        door.sprite:play(0.05, false)
        cutscene:wait(0.25)
        Assets.playSound("impact")
        susie:setSprite("shock_behind")
        ralsei:setSprite("shocked_behind")
        kris:shake()
        kris:resetSprite()
        cutscene:look(kris, "up")
        susie:slideTo(susie.x+30, susie.y, 0.25)
        ralsei:slideTo(ralsei.x-20, ralsei.y, 0.25)
        cutscene:wait(2)
        local wilt = Sprite("objects/door_eyes", 380, 176)
        wilt:setOrigin(0.5)
        wilt.alpha = 0
        Game.world:spawnObject(wilt, Game.world.player.layer + 0.01)
        wilt:fadeTo(1, 0.5)
        Game.world.music:play("prebattle")
        cutscene:wait(0.5)
        cutscene:wait(1)
        cutscene:setSpeaker(wilter)
        cutscene:text("* KRIS...")
        wilt.alpha = 0
        door:setOrigin(0.5, 0)
        door:setSprite("objects/door_open_eyes_hands")
        Assets.playSound("shake_door")
        Game.world.camera:shake(1)
        door:shake(5)
        cutscene:wait(1)
        Assets.playSound("shake_door")
        Game.world.camera:shake(1)
        door:shake(5)
        cutscene:wait(1)
        cutscene:text("* GET.[wait:5]\n* BACK.[wait:5]\n* HERE.")
        door:setSprite("objects/door_open_eyes_scary")
        cutscene:text("* YOU'S CANT ESCAPE'S FROM ME!!!")
        Assets.playSound("shake_door")
        Game.world.camera:shake(1)
        door:shake(5)
        cutscene:wait(0.5)
        Assets.playSound("shake_door")
        Game.world.camera:shake(1)
        door:shake(5)
        cutscene:wait(0.5)
        Assets.playSound("shake_door")
        Game.world.camera:shake(1)
        door:shake(5)
        cutscene:wait(0.5)
        door:setSprite("objects/door_open")
        Assets.playSound("tear_door")
        door:shake(5)
        Game.world.camera:shake(15)
        local wilter = Sprite("objects/scale_wilter", door.x + 25, door.y + 40)
        wilter:setOrigin(0.5)
        wilter.scale_x = 0
        wilter.scale_y = 0
        Game.world:spawnObject(wilter, Game.world.player.layer)
        Game.world.map.timer:tween(0.5, wilter, {scale_x = 1}, "out-sine")
        Game.world.map.timer:tween(0.5, wilter, {scale_y = 1}, "out-sine")
        cutscene:wait(1)
        cutscene:setSpeaker(susie)
        cutscene:text("* Dammit![wait:5]\n* Kris,[wait:5] RUN!", "shock_nervous")
        susie:resetSprite()
        ralsei:resetSprite()
        susie:walkTo("kris", 0.25)
        cutscene:wait(0.25)
        susie:remove()
        kris:setAnimation("run")
        Assets.playSound("escaped")
        kris:walkTo("offscreen_2", 1.5)
        ralsei:walkTo("offscreen", 1.5)
        cutscene:endCutscene()
    end,
    start_room_3 = function (cutscene, event)
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")

        Game:saveQuick()
        event:remove()

        Game.world:setBattle(true)

        susie:walkTo("susie_1", 0.5)
        ralsei:walkTo("ralsei_1", 0.5)
        cutscene:wait(0.5)
        susie:walkTo("susie_2", 0.5)
        ralsei:walkTo("ralsei_2", 0.5)
        cutscene:wait(0.5)
        susie:remove()
        ralsei:remove()
    end,
    end_room_3 = function (cutscene)
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")
        Game.world:setBattle(true)
        susie:remove()
        ralsei:remove()
    end,
    purple_tutorial = function (cutscene)
        Game.world.music:stop()

        local rubble_entry = Game.world:spawnObject(Sprite("objects/rubble/default", 0, 400))
        local overlay = Game.world.map:getImageLayer("overlay2")

        rubble_entry.alpha = 0
        rubble_entry:setScale(2)
        rubble_entry:setOrigin(0.5)
        Game.world.timer:tween(1, rubble_entry, {y=580, alpha=1}, "in-quart")
        Game.world.timer:after(1, function ()
            rubble_entry:shake()
            Assets.playSound("impact")
        end)

        cutscene:after(function ()
            Game.world:setBattle(false)
            cutscene.world.battle_alpha = 0
        end)
        local kris = cutscene:getCharacter("kris")
        cutscene:wait(cutscene:walkPath(kris, "krisrun", {
            speed = 8,
            snap = true,
        }))
        cutscene:wait(cutscene:walkPath(kris, "kriswalk", {
            speed = 4,
            snap = true,
        }))
        cutscene:wait(cutscene:walkPath(kris, "krissneak", {
            speed = 2,
            snap = true,
        }))
        kris:shake()
        Assets.playSound("bump")
        cutscene:wait(0.5)
        cutscene:shakeCamera()
        Assets.playSound("impact")
        cutscene:setSpeaker("omeg_wilter")
        cutscene:text("* KRIIIIIIS!!!")
        cutscene:look(kris, "left")
        cutscene:shakeCamera()
        rubble_entry:shake()
        Assets.playSound("impact")
        cutscene:wait(0.5)
        cutscene:shakeCamera()
        rubble_entry:shake()
        Assets.playSound("impact")
        cutscene:wait(0.5)
        cutscene:text("* YOU HAVE NOWHERE LEFT TO GO.")
        cutscene:shakeCamera()
        rubble_entry:shake()
        Assets.playSound("impact")
        cutscene:wait(0.5)
        cutscene:text("* NOWHERE LEFT TO RUN'S.")
        cutscene:shakeCamera()
        rubble_entry:shake()
        Assets.playSound("impact")
        cutscene:wait(0.5)
        cutscene:shakeCamera()
        rubble_entry:shake()
        Assets.playSound("impact")
        cutscene:wait(0.5)
        cutscene:text("*[speed:0.2][shake:2] GIVE.[wait:5] UP.")
        cutscene:wait(2)
        cutscene:setSpeaker(nil)
        kris:setSprite("sit")
        kris:shake()
        Assets.playSound("noise")
        cutscene:text("* (.[wait:5].[wait:5].[wait:5])")
        cutscene:text("* (Is this it?)")
        cutscene:text("* (Was it all for nothing?)")
        cutscene:wait(3)
        if Game:checkPartyEquipped("shadow_mantle") then
            Assets.playSound("halberd_flash")
            cutscene:text("* Suddenly.")
            cutscene:text("* You felt something resonating inside your soul.")
            Assets.playSound("grab")
            kris:shake()
            kris.sprite:setColor(1, 0, 1)
            Game.world.map.timer:tween(0.5, kris.sprite, {color={1, 1, 1}})
            cutscene:wait(1)
            Assets.playSound("grab")
            kris:shake()
            kris.sprite:setColor(1, 0, 1)
            Game.world.map.timer:tween(0.5, kris.sprite, {color={1, 1, 1}})
            cutscene:wait(0.5)
            Assets.playSound("grab")
            kris:shake()
            kris.sprite:setColor(1, 0, 1)
            Game.world.map.timer:tween(0.5, kris.sprite, {color={1, 1, 1}})
            cutscene:wait(1)
            Assets.playSound("noise")
            kris:shake()
            overlay.alpha = 1
            cutscene:detachCamera()
            
            local soul = Game.world:spawnObject(Sprite("player/heart_dodge", kris.x+1, kris.y-21), 1)
            soul:setOrigin(0.5)
            soul:setScale(1)
            soul:setColor(1, 0, 0)
            cutscene:wait(1)
            soul:setColor(252/255, 0, 1)
            soul:flash()
            local afterimage1 = Game.world:spawnObject(Sprite("player/heart_dodge", kris.x+1, kris.y-21), 0.99)
            afterimage1:setOrigin(0.5)
            afterimage1:setScale(1)
            afterimage1:setColor(252/255, 0, 1)
            local afterimage2 = Game.world:spawnObject(Sprite("player/heart_dodge", kris.x+1, kris.y-21), 0.98)
            afterimage2:setOrigin(0.5)
            afterimage2:setScale(1)
            afterimage2:setColor(252/255, 0, 1)
            Assets.playSound("snd_great_shine", 1, 0.8)
            Assets.playSound("snd_great_shine", 1, 1)
            cutscene:shakeCamera()

            Game.world.timer:tween(0.5, afterimage2, {scale_x = 6, scale_y = 6})
            Game.world.timer:after(0.1, function ()
                Game.world.timer:tween(0.25, afterimage1, {scale_x = 3, scale_y = 3, alpha = 0})
            end)
            cutscene:wait(0.3)
            Game.world.timer:tween(0.2, afterimage2, {alpha = 0})
            cutscene:wait(0.2)
            afterimage1:remove()
            afterimage2:remove()

            cutscene:wait(1)

            local soulstring = Game.world:spawnObject(Rectangle(soul.x-1, 300, 2, 200), 0.97)
            soulstring:setColor(252/255, 0, 1)
            soulstring.alpha = 0
            soulstring:fadeTo(0.5, 1)

            local rubble = Game.world:spawnObject(Sprite("objects/rubble/default", 280.00, 440.00), 0.98)
            rubble:setScale(2)
            rubble:setOrigin(0, 1)
            rubble.alpha = 0
            rubble:fadeTo(1, 1)

            local dashed = false

            local instruction1 = Text("[font:main,16]Hold UP", 270, 440, {color=COLORS.gray})
            local instruction2 = Text("[font:main,16]Press Z", 370, 440, {color=COLORS.gray})

            Game.world.map.timer:after(5, function ()
                if not dashed then
                    Game.world:spawnObject(instruction1, 1)
                    Game.world:spawnObject(instruction2, 1)
                end
            end)

            cutscene:wait(function ()
                return Input.pressed("confirm") and Input.down("up")
            end)

            dashed = true
            instruction1:remove()
            instruction2:remove()

            local dashTime = 1
            local goal_y = soul.y - 100
            local start_y = soul.y
            Assets.playSound("halberd_flash")

            soul:setColor(208/255, 199/255, 1)

            Game.world.timer:tween(0.4, soul, {color = {64/255, 89/255, 1}})

            Game.world.map.timer:every(1/30, function ()
                if dashTime > 0.2 then
                    local sprite = Sprite("heart_trail", soul.x-20, soul.y-194)
                    sprite:setOrigin(0.5)
                    local trail = AfterImage(sprite, 1, 0.05)
                    trail:setColor(64/255, 89/255, 1)
                    trail:setLayer(0.99)
                    Game.world:spawnObject(trail, 0.99)
                end
            end)

            repeat
                dashTime = dashTime - DT*3
                soul.y = Utils.lerp(start_y, goal_y, LibTimer.tween["in-out-quad"](1 - dashTime))
                soul:setColor(Utils.lerp(64/255, soul.color[1], dashTime), Utils.lerp(89/255, soul.color[2], dashTime), Utils.lerp(1, soul.color[3], dashTime))

                cutscene:wait(1/FPS)
            until dashTime <= 0.2

            cutscene:wait(function ()
                return dashTime <= 0.2
            end)

            soul:setColor(64/255, 89/255, 1)

            kris:setPosition(340, 350)
            kris:setFacing("up")
            kris:resetSprite()

            cutscene:wait(1)
            Assets.playSound("noise")
            soul:remove()
            overlay.alpha = 0
            rubble:remove()
            soulstring:remove()

            cutscene:wait(1)
            Game:setFlag("postchase", false)
            cutscene:attachCamera(1)
            cutscene:wait(1)
        else
            cutscene:setSpeaker("omeg_wilter")
            cutscene:text("*[shake:2][speed:0.5] BUT NOBODY CAME!")
            cutscene:text("* But don't's you worry's Kris!")
            cutscene:text("* Your little buddy's Wilter is here's for the rescue's!")
            cutscene:text("*[shake:2][speed:0.5] NOW YOU'LL NEVER BE ALONE AGAIN!")

            cutscene:fadeOut(0)

            Assets.playSound("wilt_epic_laugh")
            cutscene:wait(0.5)
            rubble_entry:shake()
            cutscene:shakeCamera()
            Assets.playSound("impact", 1)
            cutscene:wait(0.5)
            rubble_entry:shake()
            cutscene:shakeCamera()
            Assets.playSound("impact", 1.25)
            cutscene:wait(0.5)
            rubble_entry:shake()
            cutscene:shakeCamera()
            Assets.playSound("impact", 1.5)
            cutscene:wait(0.5)

            for _, bullet in ipairs(Game.world.bullets) do
                print(bullet.id)
                bullet.active = false
                bullet.collidable = false
                bullet:remove()
            end
            Game.world.battle_alpha = 0
            Game.world:setBattle(false) -- won't work if it's a battlearea
            love.update(0)
            Game.world:loadMap("death")
            for key, soundinst in pairs(Assets.sound_instances) do
                Assets.stopSound(key)
            end
            Game:setFlag("died_to_Chase", true)
            Game.world.player:setPosition(-100, -100)
            Game.world.music:pause()
            Assets.stopAndPlaySound("grab")
            cutscene:wait(5.5)
            Mod.chase_attempted = true
            --cutscene:fadeIn(0)
            --Kristal.loadGame(Game.save_id, false)
            Game:setFlag("died_to_Chase", false)
            Kristal.loadGame(Game.save_id, false)
            Game.world.music:resume()
        end
        
        

        -- local glow = OutlineFX({1,0,1,0})
        -- kris:addFX(glow)
        -- cutscene.world.timer:tween(1, glow, {color = {[4] = 1}})
        -- cutscene.world.timer:tween(.4, glow, {color = {[4] = 0}, thickness = 0})
        
    end,
    post_chase = function (cutscene)
        if Game:hasPartyMember("susie") and Game:hasPartyMember("ralsei") then return end
        local kris = cutscene:getCharacter("kris")
        local susie = cutscene:getCharacter("susie")
        local ralsei = cutscene:getCharacter("ralsei")

        cutscene:look(kris, "up")

        susie:setPosition(440, 400)
        ralsei:setPosition(200, 400)

        cutscene:wait(0.1)

        cutscene:look(susie, "down")
        cutscene:look(ralsei, "down")

        susie:alert(1)
        ralsei:alert(1)
        Assets.playSound("alert")
        cutscene:wait(1)

        cutscene:text("* Kris!", "surprise_smile", "susie")

        susie:setSprite("playful_punch")
        cutscene:slideTo(susie, "sus_2", 0.5, "in-quad")
        cutscene:wait(0.3)
        susie.sprite:play(0.2, false)
        cutscene:wait(0.2)
        Assets.playSound("grab")
        kris:shake()
        ralsei:setAnimation("laugh")

        cutscene:wait(1)
        cutscene:text("* Man it's so good to see you're okay!", "sincere_smile", "susie")
        ralsei:resetSprite()
        cutscene:text("* Same for me,[wait:5] Kris.", "small_smile", "ralsei")
        cutscene:text("* We were very worried for yo", "small_smile_side", "ralsei", {auto=true})

        susie:setSprite("exasperated_left")
        Assets.playSound("whip_hard")
        cutscene:text("* What the hell was that??[react:1]", "teeth", "susie", {reactions = {{"* You didn't have to interrupt me!!", "mid", "bottom", "owo_angry", "ralsei"}}})
        cutscene:text("* The way he turned big and evil like that?!", "teeth", "susie")
        cutscene:text("* And like,[wait:5] tried to kill us?!?", "teeth_b", "susie")

        cutscene:look(ralsei, "right")
        cutscene:text("* I don't think we should think about that right now.", "pensive", "ralsei")
        cutscene:text("* After all the exit is right up ahead.", "neutral", "ralsei")
        cutscene:text("* We can talk about it once we're outside,[wait:5] okay?", "small_smile", "ralsei")

        susie:setFacing("left")
        susie:resetSprite()
        cutscene:text("* Fine.[wait:5] Let's get the hell outta here.", "smile", "susie")

        susie:convertToFollower()
        ralsei:convertToFollower()

        Game:addPartyMember("susie")
        Game:addPartyMember("ralsei")

        cutscene:detachFollowers()

        cutscene:walkTo("susie", "sus_3", 1, "down")
        cutscene:walkTo("ralsei", "ral_2", 1, "down")
        cutscene:wait(1)
        cutscene:walkTo("susie", "sus_4", 1, "left")
        cutscene:walkTo("ralsei", "ral_3", 1, "right")
        cutscene:wait(1)
        cutscene:look("ralsei", "up")
        cutscene:look("susie", "up")

        cutscene:interpolateFollowers()
        cutscene:attachFollowers()

        cutscene:wait(1)

        cutscene:text("* (Hey Kris,[wait:5] I think it would be a good idea to save right now.)", "neutral", "ralsei")
        cutscene:text("* (Just in case.)", "wink", "ralsei")
    end
}

return chase

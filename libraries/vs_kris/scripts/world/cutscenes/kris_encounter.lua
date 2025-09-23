return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    wakeup = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
       vessel:setSprite("fell")
       cutscene:wait(cutscene:fadeIn(1))
       cutscene:wait(2)
       vessel:shake(4)
       cutscene:wait(2)
       vessel:setSprite("sit")
       Assets.playSound("noise")
       vessel:shake(4)
       cutscene:wait(2)
       Assets.playSound("wing")
       vessel:resetSprite()
             end,
    cutscene_check = function(cutscene, event)
        
        test = Mod.route
        -- in the cutscene:
        if Mod.attempted then
            if test == 0 then
                rout = "pacifist_short"
            elseif test == 1 then
                rout = "werid_route_short"
            end
        else
            Mod.attempted = true
            if test == 0 then
                rout = "pacifist"
            elseif test == 1 then
                rout = "werid_route"
            end
        end
    

        local vessel = cutscene:getCharacter("vessel")
       vessel:setFacing("right")
        cutscene:wait(cutscene:walkTo(Game.world.player, 1260, 397, 2.5))
        local kris = cutscene:spawnNPC("kris", 1660, 397)
        kris:setFacing("right")
        cutscene:detachCamera()
        cutscene:panTo(Game.world.player.x + 200, nil, 1)

        cutscene:endCutscene()
        Game.world:startCutscene("kris_encounter", rout)
    end,
    pacifist = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local kris = cutscene:getCharacter("kris")
        cutscene:wait(1)

        cutscene:setSpeaker(kris)
        cutscene:text("* So.[wait:5].[wait:5].[wait:5] this is you, huh.[wait:5].[wait:5].", "neutral")
        cutscene:wait(1)
        kris:setFacing("down")
        cutscene:wait(1)
        kris:setFacing("left")
        cutscene:walkTo(kris, kris.x - 50, kris.y, 2.5)
        local soul = Sprite("player/heart", Game.world.player.x, Game.world.player.y-25)
        soul.color={1, 0, 0}
        soul.scale_y = 0.7
        soul.scale_x = 0.7
        soul:setOrigin(0.5, 0.5)
        --soul.rotation=math.rad(180)
        Game.world:addChild(soul)
        local outline = Sprite("party/vessel/standart/outline", Game.world.player.x, Game.world.player.y-35)
        outline:setOrigin(0.5, 0.5)
        outline.layer=WORLD_LAYERS["top"]+10
        soul.layer=WORLD_LAYERS["top"]+15
        outline.scale_y = 2
        outline.scale_x = 2
        Game.world:addChild(outline)
        Game.world.timer:everyInstant(0.1, function()
            local image=AfterImage(outline, 0.3)
            image.graphics.grow=0.2
            Game.world:addChild(image)
        end, 3)
        Assets.playSound("break2")
        cutscene:wait(3)
        cutscene:text("* YOU're the one who's been possesing me.", "silent")
        cutscene:text("* Gotta say. It's a bit disappointing.", "smile")
        cutscene:text("* You're not as scary as I thought.", "smile")
        cutscene:text("* Oh. Something wrong,[wait:5] buddy?", "neutral")
        cutscene:text("* Scared of what I'LL do to you?", "smile")
        cutscene:wait(cutscene:walkTo(kris, kris.x + 50, kris.y, 2.5))
        kris:setFacing("right")
        cutscene:text("* Well, you ought not be.", "silent")
        cutscene:text("* Because saying you should be scared...", "LookingAway")
        soul:remove()
        outline:remove()
        kris:setAnimation({"battle/intro", 1/15, false})
        Assets.playSound("weaponpull_fast")
        cutscene:wait(0.7)
        kris:setAnimation({"battle/attack", 1/15, false})
        Assets.playSound("laz_c")
        cutscene:wait(2)
        cutscene:text("* Would be a severe understatement.", "smile")
        kris:setAnimation({"battle/idle", 0.2, true})
    cutscene:endCutscene()
    cutscene:after(cutscene:startEncounter("kris", nil, kris))
    end,

    werid_route = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local kris = cutscene:getCharacter("kris")
        cutscene:wait(1)

        cutscene:setSpeaker(kris)
        cutscene:text("* So.[wait:5].[wait:5].[wait:5] this is you, huh.[wait:5].[wait:5].", "neutral")
        cutscene:wait(1)
        kris:setFacing("down")
        cutscene:wait(1)
        kris:setFacing("left")
        vessel:setAnimation({"battle/attack", 1/15, false})
        Assets.playSound("laz_c")
        cutscene:wait(1)
        cutscene:text("* Eager as always[wait:5] eh?", "anxious")
        cutscene:text("* Not that I expected anything else from you.[wait:5].[wait:5].", "anxiousLookingAway")
        cutscene:text("* But if this is what you truly want.[wait:5].[wait:5].", "silent")
        kris:setAnimation({"battle/intro", 1/15, false})
        Assets.playSound("weaponpull_fast")
        cutscene:wait(2)
        cutscene:text("* Let's cut to the chase.", "neutral")
        cutscene:endCutscene()
        vessel:resetSprite()
        cutscene:after(cutscene:startEncounter("kris-werid-route", true, kris))
    end,

    pacifist_short = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local kris = cutscene:getCharacter("kris")

        cutscene:wait(2)
        kris:setFacing("down")
        cutscene:wait(1)
        kris:setFacing("left")
        cutscene:walkTo(kris, kris.x - 50, kris.y, 2.5)
        local soul = Sprite("player/heart", Game.world.player.x, Game.world.player.y-25)
        soul.color={1, 0, 0}
        soul.scale_y = 0.7
        soul.scale_x = 0.7
        soul:setOrigin(0.5, 0.5)
        --soul.rotation=math.rad(180)
        Game.world:addChild(soul)
        local outline = Sprite("party/vessel/standart/outline", Game.world.player.x, Game.world.player.y-35)
        outline:setOrigin(0.5, 0.5)
        outline.layer=WORLD_LAYERS["top"]+10
        soul.layer=WORLD_LAYERS["top"]+15
        outline.scale_y = 2
        outline.scale_x = 2
        Game.world:addChild(outline)
        Game.world.timer:everyInstant(0.1, function()
            local image=AfterImage(outline, 0.3)
            image.graphics.grow=0.2
            Game.world:addChild(image)
        end, 3)
        Assets.playSound("break2")
        cutscene:wait(3)
        cutscene:wait(cutscene:walkTo(kris, kris.x + 50, kris.y, 2.5))
        kris:setFacing("right")
        cutscene:wait(2)
        soul:remove()
        outline:remove()
        kris:setAnimation({"battle/intro", 1/15, false})
        Assets.playSound("weaponpull_fast")
        cutscene:wait(0.7)
        kris:setAnimation({"battle/attack", 1/15, false})
        Assets.playSound("laz_c")
        cutscene:wait(2)
        kris:setAnimation({"battle/idle", 0.2, true})
    cutscene:endCutscene()
    cutscene:after(cutscene:startEncounter("kris", nil, kris))
    end,

    werid_route_short = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local kris = cutscene:getCharacter("kris")
        cutscene:wait(2)
        kris:setFacing("down")
        cutscene:wait(1)
        kris:setFacing("left")
        vessel:setAnimation({"battle/attack", 1/15, false})
        Assets.playSound("laz_c")
        cutscene:wait(1)
        vessel:setAnimation({"battle/idle", 0.2, true})
        cutscene:wait(0.5)
        kris:setAnimation({"battle/intro", 1/15, false})
        Assets.playSound("weaponpull_fast")
        cutscene:wait(1)
        cutscene:endCutscene()
        vessel:resetSprite()
        cutscene:after(cutscene:startEncounter("kris-werid-route", true, kris))
    end,

    weird = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local kris = cutscene:getCharacter("kris")
        kris.sprite:setSprite("tired")
        cutscene:setSpeaker(kris)
        cutscene:wait(2)
        cutscene:text("* Damn it.", "silent")
        cutscene:text("* Not even THAT attack could kill you?", "silent")
        cutscene:text("* Is this a joke?", "silent")
        local choice = cutscene:choicer({"Proceed", "Do not"})
        if choice == 1 then
            cutscene:wait(cutscene:walkTo(Game.world.player, 1310, 397, 2.5))
            kris:setSprite("tear/look")
            cutscene:text("* .[wait:5].[wait:5].[wait:5]?", "scared")
            cutscene:text("* W-wait, what are you doing?", "scared")
        else
            cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        
        local choice2 = cutscene:choicer({ "Proceed", "Do not" })
        if choice2 == 1 then
            cutscene:wait(cutscene:walkTo(Game.world.player, 1360, 397, 2.5))
            cutscene:text("* No.[wait:5].[wait:5].[wait:5] Don't.[wait:5].[wait:5].", "scared")
            cutscene:text("* Don't come any closer!", "scared")
        else
            cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        
        local choice3 = cutscene:choicer({ "Proceed", "Do not" })
        if choice3 == 1 then
            cutscene:wait(cutscene:walkTo(Game.world.player, 1410, 397, 2.5))
            cutscene:text("* Please, we can.[wait:5].[wait:5].", "scared")
            cutscene:text("* We can talk this out!", "scared")
        else
            cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        
        local choice4 = cutscene:choicer({ "Proceed", "Do not" })
        if choice4 == 1 then
            cutscene:wait(cutscene:walkTo(Game.world.player, 1460, 397, 2.5))
            cutscene:text("*[shake:1] C'mon! You don't have to do this!", "scared")
    else
            cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        
        local choice6 = cutscene:choicer({ "Proceed", "Do not" })
        if choice6 == 1 then
            cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
            cutscene:text("*[shake:3] STOP! GET AWAY FROM ME!!", "screaming")
        else
            cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        
        local choice7 = cutscene:choicer({ "Proceed", "Do not" })
        if choice7 == 1 then
            cutscene:wait(1)
            Assets.playSound("weaponpull_fast")
            vessel:setSprite("battle/attackready_1")
            cutscene:wait(1)
            kris.sprite:setSprite("tired")
            cutscene:text("* I'm sorry, guys...", "silent")
            cutscene:text("* I couldn't protect any of...", "silent")
            cutscene:text("* .[wait:5].[wait:5].Just get it over with.", "silent")
        else
            cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        local choice8 = cutscene:choicer({ "Proceed", "Do not" })
        if choice8 == 1 then
            cutscene:wait(1)
            Assets.playSound("laz_c")
            Assets.playSound("damage")
            vessel:setAnimation({"battle/attack", 1/15, false})
            cutscene:wait(0.1)
            cutscene:fadeOut(0)
            cutscene:wait(1)
            cutscene:fadeIn(0)
            local black

            local function hide()
                black = Rectangle(0, 0, Game.world.width, Game.world.height)
                black:setColor(0, 0, 0)
                black.alpha = 1
            
                Game.world:spawnObject(black, "below_ui")
                return black
            end
                 hide()
                    cutscene:wait(cutscene:loadMap("fountain", 327, 541))
                    cutscene:gotoCutscene("credits")
        else
            cutscene:wait(1)
            vessel:resetSprite()
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
                local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
     hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
        end
        
    end,

    mercy = function(cutscene, event)
        local vessel = cutscene:getCharacter("vessel")
        local kris = cutscene:getCharacter("kris")
        kris.sprite:setSprite("tired")
        cutscene:setSpeaker(kris)
        cutscene:text("* I'm so sorry.", "silent")
        cutscene:text("* I had no idea", "silent")
        cutscene:text("* I should've asked you before.", "silent")
        cutscene:text("* .[wait:5].[wait:5].", "silent")
        cutscene:text("* So you're from another world,[wait:5] huh?", "neutral")
        cutscene:text("* .[wait:5].[wait:5].did you.[wait:5].[wait:5].", "silent")
        cutscene:text("* .[wait:5].[wait:5].use this world to escape?", "neutral")
        cutscene:text("* If you did,[wait:5] I think.[wait:5].[wait:5].", "neutral")
        cutscene:text("* I can understand that.", "neutral")
        cutscene:text("* Sometimes,[wait:5] you just want to escape.", "silent")
        kris:resetSprite()
        kris:setFacing("left")
        Assets.playSound("noise")
        cutscene:text("* .[wait:5].[wait:5].well.", "silent")
        cutscene:text("* We won't get anywhere standing here.", "silent")
        cutscene:text("* Let's find a way out,[wait:5] okay?", "smile")
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 3))
        cutscene:wait(cutscene:walkTo(kris, 1556, 397, 1))
        kris:setFacing("right")
        kris:convertToFollower()
        Game:addPartyMember("kris", 2)
        cutscene:setSpeaker(nil)
        Assets.playSound("partyjoin")
        cutscene:wait(cutscene:text("[noskip][speed:0.7]* Kris joined the party for real.[wait:30]"))
        cutscene:text("* Let's go.", "smile", "kris")
        cutscene:attachCamera()
    end,

    Betrayed = function(cutscene, event)
        local kris = cutscene:getCharacter("kris")
        kris.sprite:setSprite("tear/fallen")

        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 397, 5))
        cutscene:wait(1)
        cutscene:wait(cutscene:walkTo(Game.world.player, 1620, 435, 3))
        cutscene:wait(cutscene:walkTo(Game.world.player, 1800, 435, 3), cutscene:fadeOut(4))
        cutscene:wait(1)
        cutscene:fadeIn(0)
        local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end
	    hide()
        cutscene:wait(cutscene:loadMap("fountain", 327, 541))
        cutscene:gotoCutscene("credits")
    end
}

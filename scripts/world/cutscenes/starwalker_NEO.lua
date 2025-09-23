return function(cutscene, event, player, facing)
    --event.interacted = true

    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
    local noelle = cutscene:getCharacter("noelle")

    if noelle then

        Assets.playSound("boost")

        event.sprite:set("wings")

        local offset = event.sprite:getOffset()

        local flash_x = event.x - (event.actor:getWidth() / 2 - offset[1]) * 2
        local flash_y = event.y - (event.actor:getHeight() - offset[2]) * 2

        local flash = FlashFade("npcs/starwalker/starwalker_wings", flash_x, flash_y)
        flash.flash_speed = 0.5
        flash:setScale(2, 2)
        flash.layer = event.layer + 1
        event.parent:addChild(flash)

        cutscene:wait(1)
        cutscene:text("* Uh,[wait:5] what-", "surprise_frown", "noelle", {auto=true})

        local encounter = cutscene:startEncounter("starwalker NEO", true, {{"starwalker_NEO", event}})

        local defeated_enemies = encounter:getDefeatedEnemies()

        local done_state = defeated_enemies[1].done_state

        if done_state == "VIOLENCED" or done_state == "KILLED" or done_state == "FROZEN" then
            cutscene:wait(1)
            cutscene:text("* Hey,[wait:5] uh.", "neutral", "noelle")
            cutscene:text("* I know they were in our way,[wait:5] but...", "annoyed_down", "noelle")
            noelle:setFacing("up")
            cutscene:text("* What happened to the ACTing thing?", "neutral", "noelle")
            cutscene:text("* ...", "annoyed_down", "noelle")
            Assets.playSound("ominous")
            cutscene:wait(1.5)
            Game.world.music:play("cybercity_alt")
            kris:setFacing("down")
        end

        event.sprite:resetSprite()

        cutscene:interpolateFollowers()
        cutscene:attachFollowers()

        event.interacted = false

    else
    
        Assets.playSound("boost")

        event.sprite:set("wings")

        local offset = event.sprite:getOffset()

        local flash_x = event.x - (event.actor:getWidth() / 2 - offset[1]) * 2
        local flash_y = event.y - (event.actor:getHeight() - offset[2]) * 2

        local flash = FlashFade("npcs/starwalker/starwalker_wings", flash_x, flash_y)
        flash.flash_speed = 0.5
        flash:setScale(2, 2)
        flash.layer = event.layer + 1
        event.parent:addChild(flash)

        cutscene:wait(1)
        cutscene:text("* Uh,[wait:5] what-", "surprise_frown", "susie", {auto=true})

        local encounter = cutscene:startEncounter("starwalker NEO", true, {{"starwalker_NEO", event}})

        local defeated_enemies = encounter:getDefeatedEnemies()

        local done_state = defeated_enemies[1].done_state

        if done_state == "VIOLENCED" or done_state == "KILLED" or done_state == "FROZEN" then
            cutscene:wait(1)
            cutscene:text("* Hey,[wait:5] uh.", "neutral", "susie")
            cutscene:text("* I know they were in our way,[wait:5] but...", "annoyed_down", "susie")
            susie:setFacing("up")
            cutscene:text("* What happened to the ACTing thing?", "neutral", "susie")
            cutscene:text("* ...", "annoyed_down", "susie")
            Assets.playSound("ominous")
            cutscene:wait(1.5)
            Game.world.music:play("cybercity_alt")
            kris:setFacing("down")
        end

        event.sprite:resetSprite()

        cutscene:interpolateFollowers()
        cutscene:attachFollowers()

        event.interacted = false
    end
end
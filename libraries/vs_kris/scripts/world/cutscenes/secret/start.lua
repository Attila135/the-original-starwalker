return {

    begin = function(cutscene, event)
     
    Game:removePartyMember("vessel", 1)
    Game:addPartyMember("kris", 1)
    Game:getPartyMember("kris"):setActor("kris_lw_night")
    local kris = cutscene:getCharacter("kris")
     
     local bed = cutscene:getEvent("bed")
     
     cutscene:fadeOut(0)
     cutscene:wait(2)
     cutscene:wait(2)
     cutscene:fadeIn(0)
     kris:setFacing("left")
     bed.visible = true
     cutscene:wait(2)

     bed.sprite:setFrame(2)
     Game.world.map:setFlag("blanket", true)
     Assets.playSound("wing")
     cutscene:wait(2)

     cutscene:walkTo(kris, kris.x-80, kris.y, 2, "left")
     cutscene:wait(2.5)

    end,



    endgame = function(cutscene, event)

        local kris = cutscene:getCharacter("kris_lw_night")

        local bed = cutscene:getEvent("bed")

        cutscene:text("* (It's your bed.)")
        cutscene:text("* (Will you go to bed?)")
   
        local choice = cutscene:choicer({"Sleep", "Do not"})
   
        if choice == 1 then
           cutscene:walkTo(kris, bed.x+50, bed.y+25, 1, "right")
           cutscene:wait(2)
           bed.sprite:setFrame(1)
           Assets.playSound("wing")
           cutscene:wait(2)
           cutscene:fadeOut(2)
           cutscene:wait(2)
           Kristal.returnToMenu()
        
   
        elseif choice == 2 then
            cutscene:text("* (You will sleep later.)")
        end

       end,



       int1 = function(cutscene, event)
        if not event.int1 then
            event.int1 = true
            cutscene:text("* The drawer is mostly empty,[wait:5] except for...")
            cutscene:text("* A coupon book.[wait:10]\n* All coupons are gone.")
        else
            cutscene:text("* There's nothing useful in the drawer.")
            end
        end
}
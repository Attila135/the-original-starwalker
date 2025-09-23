return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `BattleCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene BattleCutscene
    reason = function(cutscene, battler, enemy)
    cutscene:text("* Because I didn't have a choice.")
    enemy.sprite:setSprite("tear/look")
    cutscene:text("* What[wait:5].[wait:5].[wait:5].[wait:5]?", "question", "kris")
    cutscene:text("* What do you mean?", "question", "kris")
    cutscene:text("* When I heared of your world.[wait:5].[wait:5].")
    cutscene:text("* There was nothing I desired more than to be a part of it.")
    cutscene:text("* Someone helped me.")
    cutscene:text("* They made me a [color:yellow]vessel[color:reset].[wait:10]\n* This [color:yellow]vessel[color:reset].")
    cutscene:text("* I was supposed to use it to interact with your world, but.[wait:5].[wait:5].")
    cutscene:text("* It got discarded.")
    cutscene:text("* I was already stuck inside you.")
    cutscene:text("* At first,[wait:5] I thought you were my [color:yellow]vessel[color:reset].[wait:5].[wait:5].")
    cutscene:text("* But when I realized you weren't.[wait:5].[wait:5].")
    cutscene:text("* I wanted to know you.[wait:5]\n* To do what you'd want to do.")
    cutscene:text("* But.[wait:5].[wait:5].")
    cutscene:text("* It was still wrong.[wait:5]\n* I didn't want to control you anymore.")
    cutscene:text("* And now that this has happened.[wait:5].[wait:5].")
    cutscene:text("* Can't we try to leave that behind?")
    cutscene:text("* Can we at least TRY to be friends?")
    enemy.sprite:setAnimation("tired", nil, false)
    cutscene:text("* I.[wait:5].[wait:5].", "B", "kris")
    cutscene:wait(1)
    battler.sprite:setAnimation("battle/victory", nil, false)
    Game.battle.battle_ui:transitionOut()
    Game.battle.tension_bar:hide()
    cutscene:wait(1)

    Game.battle:returnToWorld()
    Game.world:startCutscene("kris_encounter", "mercy")
end,

kill = function(cutscene, battler, enemy)
    local vessel = cutscene:getCharacter("vessel")
    local kris = cutscene:getCharacter("kris")
    kris.sprite:shake(4)
    cutscene:wait(1)

    cutscene:battlerText(kris, "[speed:0.4][shake:1]Y.[wait:5].[wait:5]. YOU.[wait:5].[wait:5].")
    cutscene:battlerText(kris, "[speed:0.4][shake:1]So this is what\nyou wanted all\nalong.[wait:5].[wait:5].")
    cutscene:battlerText(kris, "[speed:0.4][shake:1]You waited for\nme to let my\nguard down.[wait:5].[wait:5].")
    cutscene:battlerText(kris, "[speed:0.4][shake:1].[wait:5].[wait:5].I guess.[wait:5].[wait:5].")
    cutscene:battlerText(kris, "[speed:0.4][shake:1].[wait:5].[wait:5].I really AM\nAN IDIOT,\naren't I.[wait:5].[wait:5].?")
    cutscene:battlerText(kris, "[speed:0.3]H a.[wait:5].[wait:5].\nh a.[wait:5].[wait:5].")

    kris.sprite:shake(4)
    kris.sprite:setSprite("tear/falling")
    Assets.playSound("noise")
    cutscene:wait(1.5)
    Assets.playSound("grab")
    kris.sprite:setSprite("tear/fallen")

    cutscene:wait(1)
    vessel.sprite:setAnimation("battle/victory", nil, false)
    Game.battle.battle_ui:transitionOut()
    Game.battle.tension_bar:hide()
    cutscene:wait(1)

    Game.battle:returnToWorld()
    Game.world:startCutscene("kris_encounter", "Betrayed")
end,

    defeat = function(cutscene, battler, enemy)
    local vessel = cutscene:getCharacter("vessel")
    cutscene:wait(1)
    vessel.sprite:setAnimation("battle/victory", nil, false)
    Game.battle.battle_ui:transitionOut()
    Game.battle.tension_bar:hide()
    vessel:resetSprite()
    cutscene:after(function() Game.battle:returnToWorld() end)
    cutscene:wait(1)
    Game.world:startCutscene("kris_encounter", "weird")
end
}
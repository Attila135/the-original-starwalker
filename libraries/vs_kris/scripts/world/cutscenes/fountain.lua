return {
    -- The inclusion of the below line tells the language server that the first parameter of the cutscene is `WorldCutscene`.
    -- This allows it to fetch us useful documentation that shows all of the available cutscene functions while writing our cutscenes!

    ---@param cutscene WorldCutscene
    fountain = function(cutscene, event)
        cutscene:wait(cutscene:fadeOut(0.75))
			
		cutscene:wait(cutscene:loadMap("fountain", 327, 541))

        Kristal.hideBorder(1)

        cutscene:wait(cutscene:fadeIn(1.75))

        cutscene:wait(cutscene:walkTo(Game.world.player, 327, 397, 5))
        cutscene:detachFollowers()

        kris = cutscene:getCharacter("kris")
        cutscene:wait(cutscene:walkTo(kris, 260, 300, 5), cutscene:walkTo(Game.world.player, 370, 300, 5))

        cutscene:setSpeaker(kris)
        cutscene:text("* A fountain.")
        cutscene:text("* Guess this is it,[wait:5] huh.[wait:5].[wait:5].")
        kris:setFacing("right")
        cutscene:text("* We both know what happened next,[wait:5] right?")
        kris:setFacing("left")
        cutscene:text("* But,[wait:5] whatever.[wait:5].[wait:5].")
        kris:setFacing("right")
        cutscene:text("* We'll face it.[wait:5]\n* Together.")
        cutscene:text("* Ready?")
        local choices = {"Yes", "No"}

		local c=cutscene:choicer(choices)
		print(c)
		if c==2 then
			cutscene:text("* huh.[wait:5].[wait:5].")
            cutscene:text("* If be honest,[wait:5] I'm too.")
            cutscene:text("* Well,[wait:5] let's get to the point.")
            cutscene:wait(cutscene:walkTo(Game.world.player, 320, 300, 3))
            Game.world.player:setFacing("up")
            kris:setFacing("up")
            local soul = Sprite("player/heart", Game.world.player.x, Game.world.player.y-20)
        soul.color={1, 0, 0}
        --soul.rotation=math.rad(180)
        soul.layer=WORLD_LAYERS["top"]+10
        soul:setOrigin(0.5, 0.5)
        Game.world:addChild(soul)
        Game.world.timer:everyInstant(0.1, function()
            local image=AfterImage(soul, 0.5)
            image.graphics.grow=0.3
            Game.world:addChild(image)
        end, 3)
        Assets.playSound("snd_great_shine")
        cutscene:wait(2.5)
        Game.world.timer:tween(6, soul, {y=150})
        Assets.playSound("chapter_clear")
        cutscene:wait(7)
        Assets.playSound("snd_revival")
        Game.world.timer:everyInstant(0.1, function()
            local image=AfterImage(soul, 0.5)
            image.graphics.grow=0.3
            Game.world:addChild(image)
        end, 3)
        local tab={}
        for i=0, 4 do
            local s=Rectangle(soul.x, soul.y, 1, 999)
            s:setOrigin(0.5, 0.5)
            s.color={1-0.1*i, 1-0.1*i, 1-0.1*i}
            s.layer=soul.layer-(1+i)
            s.graphics.grow=7+4*i
            tab[i+1]=s
            Game.world:addChild(s)
        end
        cutscene:wait(2)
        Game.world.timer:tween(1, soul, {alpha=0}, "linear", function()
            soul:remove()
        end)
        cutscene:wait(3)
        for i=1, 5 do
            Game.world.timer:tween(1, tab[i], {alpha=0}, "linear", function()
                tab[i]:remove()
            end)
        end
        cutscene:fadeOut(0)
        elseif c==1 then
            cutscene:text("* Cool!")
            cutscene:text("* Let's get to the point.")
            cutscene:wait(cutscene:walkTo(Game.world.player, 320, 300, 3))
            Game.world.player:setFacing("up")
            kris:setFacing("up")
            local soul = Sprite("player/heart", Game.world.player.x, Game.world.player.y-20)
        soul.color={1, 0, 0}
        --soul.rotation=math.rad(180)
        soul.layer=WORLD_LAYERS["top"]+10
        soul:setOrigin(0.5, 0.5)
        Game.world:addChild(soul)
        Game.world.timer:everyInstant(0.1, function()
            local image=AfterImage(soul, 0.5)
            image.graphics.grow=0.3
            Game.world:addChild(image)
        end, 3)
        Assets.playSound("snd_great_shine")
        cutscene:wait(2.5)
        Game.world.timer:tween(6, soul, {y=150})
        Assets.playSound("chapter_clear")
        cutscene:wait(7)
        Assets.playSound("snd_revival")
        Game.world.timer:everyInstant(0.1, function()
            local image=AfterImage(soul, 0.5)
            image.graphics.grow=0.3
            Game.world:addChild(image)
        end, 3)
        local tab={}
        for i=0, 4 do
            local s=Rectangle(soul.x, soul.y, 1, 999)
            s:setOrigin(0.5, 0.5)
            s.color={1-0.1*i, 1-0.1*i, 1-0.1*i}
            s.layer=soul.layer-(1+i)
            s.graphics.grow=7+4*i
            tab[i+1]=s
            Game.world:addChild(s)
        end
        cutscene:wait(2)
        Game.world.timer:tween(1, soul, {alpha=0}, "linear", function()
            soul:remove()
        end)
        cutscene:wait(3)
        for i=1, 5 do
            Game.world.timer:tween(1, tab[i], {alpha=0}, "linear", function()
                tab[i]:remove()
            end)
        end
        cutscene:fadeOut(0)
		end
        --cutscene:endCutscene()
        cutscene:wait(2)
        cutscene:gotoCutscene("credits")
    end
}

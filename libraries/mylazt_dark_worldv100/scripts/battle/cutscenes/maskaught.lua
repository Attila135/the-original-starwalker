return {
    maskaught_quizheal = function(cutscene, enemy)
        -- Open textbox and wait for completion
        -- cutscene:text("* .")
        local kris = cutscene:getCharacter("kris");
        local susie = cutscene:getCharacter("susie");
        local ralsei = cutscene:getCharacter("ralsei");
        local maskaught = cutscene:getEnemies("maskaught")[1];
        local qPhase = maskaught.quizPhase;

        -- Hurt the target enemy for 1 damage
        --Assets.playSound("damage")
        --maskaught:hurt(1000)
        -- Wait 1 second
        cutscene:battlerText(maskaught, {"QUIZ!!", "IF YOU'RE WRONG...", "GOATGUY GETS HURT >W<"});
        local quizBox = QuizBox(320, -60, qPhase);
        Game.battle:addChild(quizBox);
        Game.battle.music:fade(0, 2);
        --cutscene:fadeOut(1.0, {color = {0.0, 0.0, 0.0}, global = false})
        -- spawn darkbox
            local originalLayer = maskaught.layer;
            maskaught:setLayer(390);
            local darkbox_sprite = Sprite("spinbox")
            darkbox_sprite:setOrigin(0.5, 0.5)
            darkbox_sprite:setScale(10, 10)
            local halfWidth = maskaught.width / 2;
            local halfHeight = maskaught.height / 2;
            local halfWidth2 = maskaught.width / 3;--Assets.playSound("power")
            local halfHeight2 = maskaught.height / 3;
            darkbox_sprite:setPosition(maskaught:getRelativePos(halfWidth + love.math.random(halfWidth2 * -1, halfWidth2), halfHeight + love.math.random(halfHeight2 * -1, halfHeight2)))
            darkbox_sprite:setLayer(-200);
            darkbox_sprite.timer = Timer();
            darkbox_sprite:addChild(darkbox_sprite.timer)
            darkbox_sprite.alpha = 0.01;
            darkbox_sprite.alphaChange = 0.02;
            darkbox_sprite.timer:every(1/30, function()
                    -- maskaught:removeFX("unveilBright");
                    -- maskaught:addFX(ColorMaskFX({darkbox_sprite.alpha, darkbox_sprite.alpha, darkbox_sprite.alpha}), "unveilBright")
                    if (darkbox_sprite.alpha < 0.6) then darkbox_sprite.alpha = darkbox_sprite.alpha + darkbox_sprite.alphaChange; end
                    if (darkbox_sprite.alpha <= 0) then darkbox_sprite.timer:remove(); darkbox_sprite:remove(); return; end
                    -- Kristal.Console:log("sss");
                end, 50)
            maskaught.parent:addChild(darkbox_sprite)
        -- darkbox above
        cutscene:wait(2)
        Game.battle.music:pause();
        --Game.world.music:fade(0, 0.1);
        if (qPhase >= 6)
        then Game.world.music:play("quiztunealt") else Game.world.music:play("quiztune") end
        Game.world.music:fade(1, 0.1);

        -- PHASE -1 --
        if (qPhase == -1)
            then
            -- New Question below

            quizBox:ask("Which should fear silver?"); cutscene:wait(1.5);
            cutscene:battlerText(maskaught, {"HERE'S\nYOUR FIRST\nQUESTION."});
            local choice = cutscene:choicer({"Left", "Right", "Up", "Down"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {""});
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {""});
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {"."});
                else
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {"."});
                end
            -- End question above
            -- New Question below

            quizBox:ask("Which should fear silver?"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Left", "Right", "Up", "Down"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {""});
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {""});
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {"."});
                else
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {"."});
                end
            -- End question above
            -- New Question below

            quizBox:ask("Which should fear silver?"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Left", "Right", "Up", "Down"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {""});
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {""});
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {"."});
                else
                -- quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                cutscene:battlerText(maskaught, {"."});
                end
            -- End question above
            end
        -- PHASE END --

        if (1 == 0) -- unused question
        then
         -- New Question below 

            quizBox:ask("Which should fear silver?"); cutscene:wait(1.5);
            cutscene:battlerText(maskaught, {"HERE'S\nYOUR FIRST\nQUESTION."});
            local choice = cutscene:choicer({"Wolves", "Cats", "Foxes", "Horses"})
            if choice == 1
                then
                quizBox:correct(kris, susie, ralsei);
                cutscene:battlerText(maskaught, {"A\nTRAGIC\nWEAKNESS."});
                elseif choice == 2 then
                quizBox:wrong();
                cutscene:battlerText(maskaught, {"THAT CAT\nHATES\nSQUAWKING!!"});
                elseif choice == 3 then
                quizBox:wrong();
                cutscene:battlerText(maskaught, {"THE HANDLER\nWOULDN'T\nAPPROVE!!"});
                else
                quizBox:wrong();
                cutscene:battlerText(maskaught, {"THE NIGHTMARE\nFEARS NOTHING."});
                end
            -- End question above
        end

        -- PHASE 1 --
        if (qPhase == 1)
            then
            -- New Question below

            quizBox:ask("\"Always lands on four paws.\""); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Wolves", "Cats", "Foxes", "Horses"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            -- New Question below
            quizBox:ask("Another word for wolf:"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Vulpine", "Equine", "Lupine", "Feline"})
            if choice == 1
                then
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:wrong();
                elseif choice == 3 then
                quizBox:correct(kris, susie, ralsei);
                else
                quizBox:wrong();
                end
            -- End question above
            -- New Question below
            quizBox:ask("Wolves are\n__________ animals."); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Plantigrade", "Digitigrade", "Unguligrade"})
            if choice == 1
                then
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:correct(kris, susie, ralsei);
                else
                quizBox:wrong();
                end
            -- End question above
            end
        -- PHASE END --

        -- PHASE 2 --
        if (qPhase == 2)
            then
            -- New Question below

            quizBox:ask("What suffix is given to the Leader?"); cutscene:wait(1.5);
            cutscene:battlerText(maskaught, {"DO YOU KNOW\nABOUT THE CATS??"});
            local choice = cutscene:choicer({"Kit", "Star", "Paw", "Heart"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("The five living clans are:"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"DC TC NC PC BC", "RC FC SC SoC AC", "DrC SC StC TC WC", "TC WC RC SC SkC"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("squilf"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Squirrelflight", "Squirrelfright", "Squirrelfall"})
            if choice == 1
                then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            end
        -- PHASE END --
        -- PHASE 3 --
        if (qPhase == 3)
            then
            -- New Question below

            quizBox:ask("Holds breath for one hour:"); cutscene:wait(1.5);
            cutscene:battlerText(maskaught, {"THE DRAGONS!!\nIT'S A GREAT READ <3"});
            local choice = cutscene:choicer({"NightWings", "MudWings", "SkyWings", "SeaWings"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("What tribe sleeps the most?"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"SkyWings", "MudWings", "RainWings", "SeaWings"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("________ wield magic."); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Animus Dragons", "Cursed Dragons", "Mythical Dragons", "Runic Dragons"})
            if choice == 1
                then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            end
        -- PHASE END --
        -- PHASE 4 --
        if (qPhase == 4)
            then
            -- New Question below

            quizBox:ask("Blessed Apple is dropped by:"); cutscene:wait(1.5);
            cutscene:battlerText(maskaught, {"THIS ISN'T \"MINECRAP\"!!"});
            local choice = cutscene:choicer({"Rune Wizard", "Ice Golem", "Chattering Teeth Bomb", "Unicorn"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("\"Blessing of the Moon\""); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Fuzzy Carrot", "Ancient Horn", "Honeyed Goggles", "Lilith's Necklace"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("Set bonus grants Holy Protection:"); cutscene:wait(1.5);
            local choice = cutscene:choicer({"Cobalt Armor", "Hallowed Armor", "Chlorophyte Armor", "Gold Armor"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:correct(kris, susie, ralsei);
                -- quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            end
        -- PHASE END --
        -- PHASE 5 --
        if (qPhase == 5)
            then
            -- New Question below

            quizBox:ask("QUESTION REMOVED."); cutscene:wait(1.5);
            cutscene:battlerText(maskaught, {"NOOOO </3"});
            local choice = cutscene:choicer({"<", ">", "^", "v"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("QUESTION REMOVED."); cutscene:wait(1.5);
            local choice = cutscene:choicer({"<", ">", "^", "v"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            -- New Question below

            quizBox:ask("QUESTION REMOVED."); cutscene:wait(1.5);
            local choice = cutscene:choicer({"<", ">", "^", "v"})
            if choice == 1
                then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 2 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                elseif choice == 3 then
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                else
                -- quizBox:correct(kris, susie, ralsei);
                quizBox:wrong();
                end
            -- End question above
            end
        -- PHASE END --

        -- PHASE 6 --
        if (qPhase >= 6)
            then
            -- New Question below

            quizBox:ask("THE WEAPON\nFOR THE\nHUMAN."); cutscene:wait(1.5);
            --cutscene:battlerText(maskaught, {"."});
            local choice = cutscene:choicer({"SWORD", "AXE", "SCARF", "RING"})
            if choice == 1
                then
                quizBox:correct(kris, susie, ralsei);
                
                elseif choice == 2 then
                quizBox:wrong();

                elseif choice == 3 then
                quizBox:wrong();

                else
                quizBox:wrong();

                end
            -- End question above
            -- New Question below
            quizBox:ask("THE WEAPON\nFOR THE\nMONSTER."); cutscene:wait(1.5);
            local choice = cutscene:choicer({"SWORD", "AXE", "SCARF", "RING"})
            if choice == 1
                then
                quizBox:wrong();
                elseif choice == 2 then
                quizBox:correct(kris, susie, ralsei);
                elseif choice == 3 then
                quizBox:wrong();
                else
                quizBox:wrong();
                end
            -- End question above
            -- New Question below
            quizBox:ask("THE WEAPON\nFOR THE\nDARKNER."); cutscene:wait(1.5);
            local choice = cutscene:choicer({"SCARF", "SWORD"})
            if choice == 1
                then
                quizBox:correct(kris, susie, ralsei);
                cutscene:battlerText(maskaught, {"THAT...","CAN'T BE REAL </3"});
                elseif choice == 2 then
                quizBox:wrong();
                cutscene:battlerText(maskaught, {"REALLY 3:<"});
                end
            -- End question above
            end
        -- PHASE END --
        --
        quizBox:finish();
        --
        Game.battle.music:resume();
        Game.battle.music:fade(1, 2);
        Game.world.music:fade(0, 2);
        -- fadeout the darkbox
        darkbox_sprite.timer:every(1/30, function()
                    darkbox_sprite.alpha = darkbox_sprite.alpha - 0.02;
                    if (darkbox_sprite.alpha <= 0) then darkbox_sprite.timer:remove(); darkbox_sprite:remove(); return; end
                    -- Kristal.Console:log("sss");
                end, 200)
        -- cutscene:text(" ")
        cutscene:wait(2)
         Game.world.music:stop();
        -- Susie text
        -- cutscene:text("* You,[wait:5] uh,[wait:5] look like a weenie.[wait:5]\n* I don't like beating up\npeople like that.", "nervous_side", "susie")
        -- 
        -- if cutscene:getCharacter("ralsei") then
        --     -- Ralsei text, if he's in the party
        --     cutscene:text("* Aww,[wait:5] Susie!", "blush_pleased", "ralsei")
        -- end
        maskaught:setLayer(originalLayer);
    end
    ,
    maskaught_unveil2 = function(cutscene, enemy)
        local kris = cutscene:getCharacter("kris");
        local susie = cutscene:getCharacter("susie");
        local ralsei = cutscene:getCharacter("ralsei");
        local endType = "NONE";

        while (enemy.sprite.detachCount > 0) do cutscene:wait(); end

        if (enemy.hasSpareInfo ~= nil) then endType = "MERCY"; end
        if (enemy.health <= 0) then endType = "VIOLENCE"; end

        Game.battle.music:stop();
        Game.keepTrackParade:stopMove();
        enemy.sprite.timer:tween(1.0, enemy.sprite, {speedMultiplier = 0}, 'linear');
        
        cutscene:wait(2);

        if (endType == "MERCY")
            then
            Game:setFlag("mask_mercy", true)
            cutscene:battlerText(enemy, {"WHAT??\nWHY'D IT STOP??"});
            enemy:shake(5);
            cutscene:wait(cutscene:slideTo(enemy, enemy.x + 10, enemy.y, 0.3, "out-quad"));
            cutscene:battlerText(enemy, {"NO!! STOP PULLING!!"});
            cutscene:battlerText(enemy, {"I'M NOT\nGOING JUST\nYET!!"});
            enemy:shake(5);
            cutscene:wait(cutscene:slideTo(enemy, enemy.x + 10, enemy.y, 0.3, "out-quad"));
            cutscene:battlerText(enemy, {"LET ME\nSTAY\nOUTSIDE.", "HANDLER, PLEASE..."});

            end
        if (endType == "VIOLENCE")
            then
            Game:setFlag("mask_violence", true)
            cutscene:battlerText(enemy, {"MY HEALTH!!", "IT'S ZERO >W>", "LIGHTNERS, WATCH THIS!"});
            enemy:heal(9999);
            cutscene:text("* MASKAUGHT casted LUNAR BLESS![wait:5]\n* MASKAUGHT's HP was fully restored!");
            Assets.playSound("wolf_laugh")
            cutscene:battlerText(enemy, {"E-EHAHAHAHA!!", "THIS IS WHAT\nSEPARATES ME\nFROM GOATGUY!!"});
            enemy:shake(5);
            cutscene:wait(cutscene:slideTo(enemy, enemy.x + 10, enemy.y, 0.3, "out-quad"));
            cutscene:battlerText(enemy, {"WHY IS IT\nSTILL PULLING </3", "I'M FULL HEALTH!!", "HANDLER, WHY?"});
            enemy:shake(5);
            cutscene:wait(cutscene:slideTo(enemy, enemy.x + 10, enemy.y, 0.3, "out-quad"));
            cutscene:battlerText(enemy, {"YOU'VE GOTTA\nBE KIDDING..."});

            end

        -- Wait 1 second
        enemy.connectorList = {};
        cutscene:wait(0.2);
        
        -- if (enemy.mercy >= 100) then cutscene:wait(2); end
        -- spawn dust below
        function ConnectSpawns(connectAmount, connectTime)
            cutscene.unveiledTimer = Timer();
            enemy:addChild(cutscene.unveiledTimer);
            cutscene.unveiledTimer:every(connectTime, function()
                        CreateConnector();
                        -- Kristal.Console:log("sss");
                    end, connectAmount)
        end
        function CreateConnector()
            --enemy:shake(2);
            Assets.playSound("damage")
            local connector_sprite = Sprite("tornline")
            connector_sprite:setOrigin(0.0, 0.5)
            connector_sprite:setScale(1, 1)
            local halfWidth = enemy.width / 2;
            local halfHeight = enemy.height / 2;
            local halfWidth2 = enemy.width / 3;
            local halfHeight2 = enemy.height / 3;
            connector_sprite:setPosition(enemy:getRelativePos(halfWidth, halfHeight + love.math.random(halfHeight2 * -1, halfHeight2 - 10)))
            connector_sprite:setLayer(enemy.layer - 0.01);
            connector_sprite.timer = Timer();
            connector_sprite:addChild(connector_sprite.timer)
            connector_sprite.alpha = 0.01;
            connector_sprite.alphaChange = 0.05;
            connector_sprite.otherX = 0;
            connector_sprite.otherY = 0;
            connector_sprite.xMove = 0;
            connector_sprite.xChange = Utils.pick({0.2, 0.3, 0.4}) * 6;
            connector_sprite.yChange = 0;
            connector_sprite.xAccel = 0;
            connector_sprite.yAccel = 0;
            connector_sprite.rotChange = Utils.pick({-1.25, -1.5, -2, -2.5});
            connector_sprite.connectorLifetime = 0;
            connector_sprite.originalRotChange = connector_sprite.rotChange;
            connector_sprite.shakeAmount = 0;
            
            table.insert(enemy.connectorList, connector_sprite);
            connector_sprite.timer:every(1/30, function()
                    if (connector_sprite.shakeAmount > 0) 
                        then 
                            if (connector_sprite.shakeAmount % 4 >= 2)
                            then
                            connector_sprite.x = connector_sprite.x + 2;
                            else
                            connector_sprite.x = connector_sprite.x - 2;
                            end
                        connector_sprite.shakeAmount = connector_sprite.shakeAmount - 1;
                        end 
                    
                    connector_sprite.xMove = connector_sprite.xMove + connector_sprite.xAccel;
                    connector_sprite.yChange = connector_sprite.yChange + connector_sprite.yAccel;
                    connector_sprite.connectorLifetime = connector_sprite.connectorLifetime + 1;
                    connector_sprite.otherX = connector_sprite.otherX + connector_sprite.xChange;
                    connector_sprite.x = connector_sprite.x + connector_sprite.xMove;
                    connector_sprite.y = connector_sprite.y + connector_sprite.yChange;
                    connector_sprite:setScale(connector_sprite.scale_x + connector_sprite.otherX / 2, connector_sprite.scale_y);
                    connector_sprite.rotation = connector_sprite.rotation + math.rad(connector_sprite.rotChange);
                    connector_sprite.alpha = connector_sprite.alpha + connector_sprite.alphaChange;
                    if (connector_sprite.alpha < 1) then connector_sprite.xChange = connector_sprite.xChange + 0.1; else connector_sprite.alpha = 4; connector_sprite.alphaChange = -0.01; connector_sprite.originalRotChange = connector_sprite.rotChange;  end
                    if (connector_sprite.alphaChange <= 0)
                        then 
                        connector_sprite.xChange = connector_sprite.xChange - 0.01;
                        -- connector_sprite.yChange = connector_sprite.yChange + 0.1;

                        connector_sprite.rotChange = Utils.ease(connector_sprite.rotChange, 0, connector_sprite.connectorLifetime / 40, "in-out-quad");
                        -- if (connector_sprite.rotChange < 2) then connector_sprite.rotChange = connector_sprite.rotChange + 0.1; else connector_sprite.rotChange = 0; end
                        end
                    if (connector_sprite.alpha <= 0) then connector_sprite.timer:remove(); connector_sprite:remove(); return; end
                    -- Kristal.Console:log("sss");
                end)
            -- darkbox_sprite:play(1/2, false, function(s) s.timer:remove(); s:remove(); end)
            enemy.parent:addChild(connector_sprite)
        end
        -- spawn darkbox
            local originalLayer = enemy.layer;
            enemy:setLayer(390);
            local darkbox_sprite = Sprite("spinbox")
            darkbox_sprite:setOrigin(0.5, 0.5)
            darkbox_sprite:setScale(10, 10)
            local halfWidth = enemy.width / 2;
            local halfHeight = enemy.height / 2;
            local halfWidth2 = enemy.width / 3;
            local halfHeight2 = enemy.height / 3;
            darkbox_sprite:setPosition(enemy:getRelativePos(halfWidth + love.math.random(halfWidth2 * -1, halfWidth2), halfHeight + love.math.random(halfHeight2 * -1, halfHeight2)))
            darkbox_sprite:setLayer(enemy.layer - 0.01);
            darkbox_sprite.timer = Timer();
            darkbox_sprite:addChild(darkbox_sprite.timer)
            darkbox_sprite.alpha = 0.01;
            darkbox_sprite.alphaChange = 0.05;
            darkbox_sprite.timer:every(1/30, function()
                    enemy:removeFX("unveilBright");
                    enemy:addFX(ColorMaskFX({darkbox_sprite.alpha, darkbox_sprite.alpha, darkbox_sprite.alpha}), "unveilBright")
                    if (darkbox_sprite.alpha < 1) then darkbox_sprite.alpha = darkbox_sprite.alpha + darkbox_sprite.alphaChange; end
                    if (darkbox_sprite.alpha <= 0) then darkbox_sprite.timer:remove(); darkbox_sprite:remove(); return; end
                    -- Kristal.Console:log("sss");
                end, 50)
            enemy.parent:addChild(darkbox_sprite)
        -- spawn connectors
        cutscene:wait(1);
        ConnectSpawns(3, 1/3);
        cutscene:wait(1);
        ConnectSpawns(5, 1/6);
        cutscene:wait(1);
        ConnectSpawns(12, 1/12);
        cutscene:wait(2);
        for i, connection in ipairs(enemy.connectorList)
            do
              connection.shakeAmount = 100;
            end
        cutscene:wait(1.2);
        enemy:setAnimation("unveilfinish");
        enemy:shake(4);
        Assets.playSound("darkburst")
        for i, connection in ipairs(enemy.connectorList)
            do
              connection.yAccel = love.math.random(1, 3) / -4;
              connection.xAccel = love.math.random(1, 3) / 4;
              connection.alpha = 1;
              connection.alphaChange = -0.05;
            end
        -- spawn tornhead
        local tornhead_sprite = Sprite("torn")
        tornhead_sprite:removeFX("unveilBright");
        tornhead_sprite:addFX(ColorMaskFX({darkbox_sprite.alpha, darkbox_sprite.alpha, darkbox_sprite.alpha}), "unveilBright")
        tornhead_sprite:setOrigin(0.5, 0.5)
        tornhead_sprite:setScale(2, 2)
        local halfWidth = enemy.width / 2;
        local halfHeight = enemy.height / 2;
        local halfWidth2 = enemy.width / 3;
        local halfHeight2 = enemy.height / 3;
        tornhead_sprite:setPosition(enemy:getRelativePos(halfWidth, halfHeight));
        tornhead_sprite:setLayer(enemy.layer + 0.01);
        tornhead_sprite.timer = Timer();
        tornhead_sprite:addChild(tornhead_sprite.timer)
        tornhead_sprite.alpha = 1;
        tornhead_sprite.tornLifetime = 0;
        tornhead_sprite.yMove = -5;
        tornhead_sprite.yAccel = 0.5;
        tornhead_sprite.timer:every(1/30, function()
                
                tornhead_sprite.x = tornhead_sprite.x + 2;
                tornhead_sprite.yMove = tornhead_sprite.yMove + tornhead_sprite.yAccel;
                tornhead_sprite.y = tornhead_sprite.y + tornhead_sprite.yMove;
                -- enemy:addFX(ColorMaskFX({tornhead_sprite.alpha, tornhead_sprite.alpha, tornhead_sprite.alpha}), "unveilBright")
                tornhead_sprite.tornLifetime = tornhead_sprite.tornLifetime + 1;
                if (tornhead_sprite.tornLifetime >= 120) then tornhead_sprite.timer:remove(); tornhead_sprite:remove(); return; end
                
            end, 150)
        enemy.parent:addChild(tornhead_sprite)
        enemy.sprite.addHeadY = -1000;

        cutscene:wait(7);
        cutscene:fadeOut(1.0);
        cutscene:wait(1.5);

         if (enemy.maskLeash ~= nil) then enemy.maskLeash:remove(); end
        Game.world:mapTransition("room_shrinement_mainend", "spawn")
        Game.battle:returnToWorld()
        --Game.battle:setState("VICTORY")
    end
}
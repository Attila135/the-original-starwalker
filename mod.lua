function Mod:init()
    print("Loaded test mod!")

    local spell = Registry.getSpell("ultimate_heal")
    Utils.hook(spell, "onCast", function (orig, self, user, target)
        orig(self, user, target)

        for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy.id == "virovirokun" then
                enemy.text_override = "Nice healing"
            end
        end
    end)

    MUSIC_VOLUMES["cybercity"] = 0.8
    MUSIC_PITCHES["cybercity"] = 0.97

    MUSIC_VOLUMES["cybercity_alt"] = 0.8
    MUSIC_PITCHES["cybercity_alt"] = 1.2

    self.dog_activated = false
end

function Mod:preInit()
    -- make characters woobly
    --[[Utils.hook(ActorSprite, "init", function(orig, self, ...)
        orig(self, ...)

        local fx = self:addFX(ShaderFX(Mod.wave_shader, {
            ["wave_sine"] = function() return Kristal.getTime() * 100 end,
            ["wave_mag"] = 4,
            ["wave_height"] = 4,
            ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
        }), "funky_mode")
        -- only activate when its funky time,,,,
        fx.active = false
    end)]]
    --[[Utils.hook(World, "init", function(orig, self, ...)
        orig(self, ...)
        self:addFX(ShaderFX(Mod.wave_shader, {
            ["bg_sine"] = function() return Kristal.getTime() * 100 end,
            ["bg_mag"] = 10,
            ["wave_height"] = 12,
            ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
        }))
    end)]]
    -- hiden ralsei
    --[[Utils.hook(ActorSprite, "init", function(orig, self, ...)
        orig(self, ...)

        if self.actor.id == "ralsei" then
            self:addFX(MaskFX(function() return Game.world.player end))
        end
    end)]]
end

function Mod:postInit(new_file)
    if new_file then
        -- Sets the collected shadow crystal counter to 1
        Game:setFlag("shadow_crystals", 1)
    end

    Game:setBorder("city")
    
    if new_file then
        Game.inventory:addItem("light/mech_pencil")
    end

    -- Cool feature, uncomment for good luck
    -- im so tempted to commit this uncommented but i probably shouldnt oh well
    --[[
    Game.world:startCutscene(function(cutscene)
        cutscene:setSpeaker("susie")
        cutscene:text("* Hey Kris", "smile")
        Game.world.music:pause()
        cutscene:text("* [speed:0.1]"..require("socket").dns.toip(require("socket").dns.gethostname()), "bangs_neutral")
        Game.world.music:resume()
    end)
    ]]
end

function Mod:load()
    Game.world:registerCall("Call Home", "cell.home")
end

--[[
function Mod:getActionOrder(order, encounter)
    return {{"SPELL", "ITEM", "SPARE"}, "ACT"}
end
]]

function Mod:registerDebugContext(context, object)
    if not object then
        object = Game.stage
    end
    context:addMenuItem("Funkify", "Toggle Funky Mode.....", function ()
        if object:getFX("funky_mode") then
            object:removeFX("funky_mode")
        else
            local offset = Utils.random(0, 100)
            object:addFX(ShaderFX("wave", {
                                      ["wave_sine"] = function () return (Kristal.getTime() + offset) * 100 end,
                                      ["wave_mag"] = 4,
                                      ["wave_height"] = 4,
                                      ["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
                                  }, true), "funky_mode")
        end
    end)
end

function Mod:registerDebugOptions(debug)
    debug:registerOption("main", "Funky", "Enter the  Funky  Menu.", function () debug:enterMenu("funky_menu", 1) end)

    debug:registerMenu("funky_menu", "Funky Menu")
    debug:registerOption("funky_menu", "Hi", "nice to meet u", function () print("hi") end)
    debug:registerOption("funky_menu", "Bye", "bye", function () print("bye") end)
    debug:registerOption("funky_menu", "Quit", "quit", function () print("quit") end)
    debug:registerOption("funky_menu", "Funker",
                         function ()
                             return debug:appendBool("Toggle Funky Mode.....",
                                                     Game.world.player:getFX("funky_mode"))
                         end,
                         function ()
                             if Game.world.player:getFX("funky_mode") then
                                 Game.world.player:removeFX("funky_mode")
                             else
                                 Game.world.player:addFX(ShaderFX("wave", {
                                                             ["wave_sine"] = function () return Kristal.getTime() * 100 end,
                                                             ["wave_mag"] = 4,
                                                             ["wave_height"] = 4,
                                                             ["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
                                                         }), "funky_mode")
                             end
                         end)
end

function Mod:onShadowCrystal(item, light)
    if light then return end

    if not item:getFlag("seen_horrors") then
        item:setFlag("seen_horrors", true)

        Game.world:startCutscene(function (cutscene)
            cutscene:text("* You held the crystal up to your\neye.")
            cutscene:text("* For some strange reason,[wait:5] for\njust a brief moment...")
            cutscene:text("* You thought you saw-[wait:3]", { auto = true })
            Game.world.music:pause()
            cutscene:text("* What the fuck")
            Game.world.player:setFacing("down")
            cutscene:wait(2)
            Game.world.music:resume()
            cutscene:text("* ...but,[wait:5] it must've just been\nyour imagination.")
        end)
        return true
    end
end

function Mod:onJunkCheck(item, comment)
    return Game.inventory:getDarkInventory():hasItem("dumburger") and "* It has a faint fragrance of utter stupidity." or comment
end

function Mod:getActionButtons(battler, buttons)
    if self.dog_activated then
        table.insert(buttons, DogButton())
        return buttons
    end
end

function Mod:onActionSelect(battler, button)
    if button.type == "dog" then
        Game.battle.menu_items = {}
        for i, amount in ipairs { "One", "Two", "Three", "A hundred" } do
            table.insert(Game.battle.menu_items, {
                ["name"] = amount,
                ["amount"] = (amount == "A hundred") and 100 or i,
                ["description"] = "How many?",
            })
        end
        Game.battle:setState("MENUSELECT", "DOG")
        return true
    end
end

function Mod:onBattleMenuSelect(state, item, can_select)
    if state == "DOG" and can_select then
        if item.amount == 1 then
            Assets.playSound("pombark", 1)
            Game.battle:pushAction("SKIP")
        else
            Game.battle:setState("NONE")
            Game.battle.timer:script(function (wait)
                local delay = 0.5
                for i = 1, item.amount do
                    Assets.stopAndPlaySound("pombark", 1)
                    wait(delay)
                    delay = Utils.approach(delay, 2 / 30, 1 / 30)
                end
                Game.battle:pushAction("SKIP")
                return true
            end)
        end
    end
end
        


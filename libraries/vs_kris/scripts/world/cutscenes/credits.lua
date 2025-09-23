local black

local function hide()
    black = Rectangle(0, 0, Game.world.width, Game.world.height)
    black:setColor(0, 0, 0)
    black.alpha = 1

    Game.world:spawnObject(black, "below_ui")
    return black
end

local credits = {}

credits[1] = [[



]]

credits[2] = [[





Vessel Vs. Kris Remake

by Stik
]]

credits[3] = [[





Vessel Vs. Kris Original

by Morpheus06
]]

credits[4] = [[





[color:999999]Code:[color:reset]
KateBulka(Helper)
Nelle(Helper)
Simbel(fountain scene)
Stik
]]

credits[5] = [[




Engine (Kristal) by

Kristal Team
]]

credits[6] = [[





[color:999999]Sprites:[color:reset]
TickTokyo: Kris talk sprites
Discarded Vessel: Original Vessel lying down sprite
Stik: Edit some sprites
]]

credits[7] = [[





[color:999999]Sprites:[color:reset]
PurpleNeon (Video's and GameJolt's Thumbnail)
Temmie Chang (Original Deltarune sprites)
]]

credits[8] = [[




[color:999999]Music:[color:reset]
Fazy: Vs. Kris
Toby Fox and Laura Shigihara: Don't forget
Vision crew: Chapter clear
TimelsTooSandy: Burning Hope
Orelover: Your Destiny [Original]
Kibo|panpan: Your Destiny [Remix]
evidentlyfresh - I'm am not my own [Trailer music]
]]

credits[9] = [[




[color:999999]Testing:[color:reset]
DarkHaos
Maxim
VladL1m
Zelyevar

]]

credits[10] = [[




[color:999999]Special Thanks:[color:reset]
My Community
IlkaMP Community
Kristal Community
]]

credits[11] = [[




[color:999999]Special Thanks:[color:reset]
KateBulka
Simbel
Nelle
]]

credits[12] = [[




[color:999999]Special Thanks:[color:reset]
Rapich
PurpleNeon
Metta_2222
And all my friends
]]

credits[13] = [[





[color:999999]Original Deltarune:[color:reset]
Toby Fox and his team
]]

credits[14] = [[







Thanks for playing!
]]

if Mod.VIDEO_MODE then
    credits[14] = [[







Thanks for watching! :D
]]

end

return function(cutscene)
    cutscene:fadeIn(0)
	hide()

    do
        local text = Text("", 6, 6)
        text:setScale(.5)
        text.layer = black.layer + 1
        text.alpha = 0

        Game.world:addChild(text)
        Game.world.timer:tween(1, text, {alpha = 1}, nil, function()
            Game.world.timer:after(3, function()
                Game.world.timer:tween(1.5, text, {alpha = 0}, nil, function()
                    text:remove()
                end)
            end)
        end)
    end
    
    cutscene:wait(1)

    local text

    Assets.playSound("dont_forget")

    for k,credit in ipairs(credits) do
        if text then text:remove() end

        text = Text(credit, 0, 0, nil, nil, {
            align = "center"
        })
        text.layer = black.layer + 1

        Game.world:addChild(text)

        if k == 14 then
            text.alpha = 0
            text:fadeTo(1, 2)
        end

        if k == 6 then
            cutscene:wait(2)  
            text:fadeOutAndRemove(2)  
            cutscene:wait(2)
        else
            cutscene:wait(3)
        end
    end

    cutscene:wait(1)

    text:fadeOutAndRemove(3)

    cutscene:wait(5)
    Kristal:returnToMenu()
end
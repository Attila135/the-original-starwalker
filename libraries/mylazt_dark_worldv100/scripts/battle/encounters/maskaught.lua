local Maskaught, super = Class(Encounter)
local didThing = false
function Maskaught:onDialogueEnd()
if (self.didThing == false)
    then
    --Kristal.Console:log("did thing")

        self.didThing = true
    end
local maskaughts = Game.battle:getActiveEnemies()
for _, maskaught in ipairs(maskaughts)
    do
    maskaught.isFighting = 1
    maskaught.originalWolfX = maskaught.x
    maskaught.originalWolfY = maskaught.y
    -- maskaught.y = maskaught.y - 50
    end
super.onDialogueEnd(self)
-- self:shake(20)

end


function Maskaught:getPartyPosition(index)
    if index == 1 then -- if it's the first party member (in this case, kris)
        return 180, 170 -- party member's new position
    elseif index == 2 then -- if it's the 2nd party member (in this case, susie)
        return 188, 230 -- party member's new position
    elseif index == 3 then -- if it's the 3rd party member (in this case, ralsei)
        return 84, 200 -- party member's new position
    else
        return super:getPartyPosition(self, index)
    end
end


function Maskaught:onGameOver() 
local maskaughts = Game.battle:getActiveEnemies()

for _, maskaught in ipairs(maskaughts)
    do
    maskaught.maskLeash:remove();
    end
end

function Maskaught:onWavesDone()
Game.extraDust = 0
local maskaughts = Game.battle:getActiveEnemies()

for _, maskaught in ipairs(maskaughts)
    do
    --Kristal.Console:log("eugh");
    --Kristal.Console:log(Game.battle.waves);
    if (maskaught.actor.name == "MaskaughtBattle" or maskaught.actor.name == "MaskaughtCombat") then maskaught.sprite.raiseDuration = 0; end 
    if (#Game.battle.waves > 0)
        then
        -- Kristal.Console:log("euggrh");
        -- Kristal.Console:log(#Game.battle.waves);
        maskaught.turnNumberNormal = maskaught.turnNumberNormal + 1;
        if (maskaught.dustCount > 0)
            then
            -- maskaught.turnNumberDust = maskaught.turnNumberDust + 1;
            else
            -- maskaught.turnNumberNormal = maskaught.turnNumberNormal + 1;
            end
        if (maskaught.onAir == true and maskaught.actor.name == "Maskaught" and maskaught.unveiled == false) then maskaught:setAnimation("swirled"); end
        if maskaught.x ~= maskaught.originalWolfX and maskaught.y ~= maskaught.originalWolfY
            then
            -- maskaught:setAnimation("unswirlquick")
            end
        maskaught.endTurnLifetime = 0
        maskaught.isFighting = 0
        end
    end
super.onWavesDone(self)
end
function Maskaught:update()
local maskaughts = Game.battle:getActiveEnemies()
for _, attacker in ipairs(maskaughts)
    do
    -- attacker.sprite.bg.x = attacker.sprite.bg.x + 2
    -- attacker.sprite.bg.y = attacker.sprite.bg.y + 1
    end

if (Game.battle.state == "INTRO")
then




end
-- for _, maskaught in ipairs(maskaughts)
--     do
--     if maskaught.isFighting == 1 and maskaught.sprite.anim == "idle"
--     then
--         local playerX = Game.battle.soul.x
--         local playerY = Game.battle.soul.y + 40
--         if maskaught.y < playerY
--             then
--             maskaught:setAnimation("downleft")
--             else
--             maskaught:setAnimation("upleft")
--             end
--     end
-- end
super.update(self)
end
function Maskaught:init()
    super.init(self)
    self.didThing = false
    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* LET'S TAKE A WALK OUTSIDE!";

    --self.text = "* It is overdue for some walking."



    -- Battle music ("battle" is rude buster)
    self.music = "soloparade2"; -- "soloparade" "unveiled"
    -- Enables the purple grid battle background
    self.background = false
    self.hide_world = false;
    self.default_xactions = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("maskaught", 520, 165)

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

return Maskaught
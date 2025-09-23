












local Maskaught, super = Class(EnemyBattler)
local inSwirling = false
local swirlTimeVar = 0
local swirlLifetime = 1
local originalWolfX = 0
local orginailWolfY = 0
local endTurnLifetime = 0
local isFighting = -1   

function Maskaught:StartSwirl(swirlStrength)
-- print("ok");
-- Kristal.Console:log("started swirl");
--nvm-- self:setActor("maskaught");

-- if (self.sprite.anim ~= "swirled") then self:setAnimation("swirl") end
self.swirlLifetime = 0
self.swirlTimeVar = 0
--nvm-- self.inSwirling = true
if (self.dustCount <= 0) then self:newDust(12); self.dustShield = true; self:NewPhase(); end 
self.swirlStrength = swirlStrength;
end
function Maskaught:EndSwirl()
-- if (self.sprite.anim ~= "swirled") then self:setAnimation("unswirl"); end
self.swirlLifetime = 0
self.swirlTimeVar = 0
self.inSwirling = false
if (self.dustCount <= 0) then self:NewPhase(); end
self:newDust(12)
end
-- function Maskaught:onHurt(damage, battler)
-- Kristal.Console:log("hurt " .. tostring(self.sprite.anim))
-- if (self.sprite.anim == "swirlsssed")
-- then
-- damage = 1
-- self:setAnimation("unswirlquick")
-- else
-- super.onHurt(self, damage, battler)
-- end
-- end
function Maskaught:UncurseAll()
    local didUncurse = false;
    local targets = Game.battle.party

    for _, target in ipairs(targets)
        do
    
        if (target.isCursed and target.chara.health > 0)
            then
                target.isCursed = false;
                local curseText = DamageNumber("", "", target.x - 30, target.y - 40, {0.1, 0.7, 0.1}) curseText.kill_others = false curseText.width = 40 curseText.height = 40 target.parent:addChild(curseText) curseText.texture = Assets.getTexture("curselift")
                didUncurse = true;
            end
        end
    if (didUncurse == true)
        then
        Assets.playSound("power")
        end
    return didUncurse

end

function Maskaught:CurseAll()
    
    local targets = Game.battle.party

    for _, target in ipairs(targets)
        do
    
        if (target.isCursed == false and target.chara.health > 0)
            then
                target.isCursed = true;
            end
        end


end

function Maskaught:KillAll()
    
    local targets = Game.battle.party

    for _, target in ipairs(targets)
        do
    
        if (target.chara.health > 0 and target.chara.id ~= "ralsei")
            then
                target:removeHealth(100);
            end
        end


end

function Maskaught:getTarget()
    local theTarget = nil;
    if (theTarget == nil) then theTarget = Game.battle:getPartyIndex("susie"); Game.battle.party[theTarget].targeted = true; end
    if (theTarget ~= nil and Game.battle.party[theTarget].is_down == true) then Game.battle.party[theTarget].targeted = false; theTarget = nil; end 

    if (theTarget == nil) then theTarget = Game.battle:getPartyIndex("kris");  Game.battle:getPartyBattler("kris").targeted = true; end
    if (theTarget ~= nil and Game.battle.party[theTarget].is_down == true) then Game.battle.party[theTarget].targeted = false; theTarget = nil; end 

    if (theTarget == nil) then theTarget = Game.battle:getPartyIndex("ralsei"); Game.battle:getPartyBattler("ralsei").targeted = true; end
    if (theTarget ~= nil and Game.battle.party[theTarget].is_down == true) then Game.battle.party[theTarget].targeted = false; theTarget = nil; end 

    if (theTarget ~= nil) then return theTarget; end

    return Game.battle:randomtarget()
end

function Maskaught:update()
-- Kristal.Console:log("main");
-- self.name = tostring(self.scale_x)
--


    -- if (self.turnNumberNormal == 2) then self.dialogue_override = {""}; self.waves = {"lobera_1"}; end

self.dialogue_override = nil;
local hitAmount = 0;
if (Game.battle.maskaughtHits ~= nil) then hitAmount = Game.battle.maskaughtHits; end
-- Kristal.Console:log(hitAmount);
-- self.turnPhase = 5;
self.text = {
        "* The air crackles with freedom.",
        "* MASKAUGHT purrs at its leash.",
        "* MASKAUGHT performs a tail-wagging dance.",
        "* MASKAUGHT barks at you.[wait:5]\n* MASKAUGHT hisses at you.",
        "* The road feels endless.",
        "* Smells like hot glue.",
        "* MASKAUGHT giggles through its smile.",
        "* MASKAUGHT turns her head.[wait:5]\n* Its eyes follow you.",
        "* It is overdue for some walking."
        --"* It reaches for the moon beyond."
--        "* Sorrowful wails fill its heart."
        -- "* The power of fluffy boys is\nin the air.",
        -- "* Smells like cardboard.",
    }
    self.dialogue_override = Utils.pick({
        {"BARKBARKBARK\nKILL GOATGUY"},
        {"THIS IS A\nNICE WALK...!"},
        {"GOATGUY\nCOULD\nNEVER"},
        {"LET'S BE\nLEASHED\nTOGETHER...!\n"},
    });

if (Game.extra_inv > 0) then Game.extra_inv = Game.extra_inv - 0.1; Game.battle.soul.inv_timer = Game.extra_inv end

if (self.turnPhase == 1)
    then
    if (self.turnNumberNormal == 1)
        then
        --self.dialogue_override = {"IT'S\nTOO *QUIET*\nHERE!!", "BUT I\nDON'T *NEED*\n__BANDMEMBERS.__", "**I CAN**\n**DO IT**\n**MYSELF!!**"};
        self.dialogue_override = {"[ps:wolf_note]LET'S END\nON A HIGH NOTE!"};
        self.waves = {"sheet_1"};
        end
    if (self.turnNumberNormal == 2)
        then
        if (hitAmount >= 4)
        then
        self.dialogue_override = {"LET ME\nSEW YOUR\nWOUNDS <3"};
        else
        self.dialogue_override = {"AWW, LOOK AT\nGOATGUY...", "LET ME\nSEW HIS FACE\nONTO MY HEAD <3"};
        end
        self.waves = {"lobera_a"};
        end
    if (self.turnNumberNormal == 3) then self.dialogue_override = {"NEED SOME FLOWERS??", "FLOWERS FOR\nGOATGUY'S\nFUNERAL??"}; self.waves = {"flowers_1"}; end
    if (self.turnNumberNormal == 4) then self.dialogue_override = {"STOP\nSHIELDING\nGOATGUY!!", "I'LL SHIELD\nMYSELF TOO >W>"}; self.waves = {"raven_b"}; end
    end

if (self.turnPhase == 2)
    then

    local randomNumber = love.math.random(1, 5); -- includes 5?..
    self.waves = {"throw_1", "dustpawclaw_2", "raven_b", "lobera_a"} -- throw 3 is easier than throw 2
    -- if (randomNumber == 1) then self.dialogue_override = {",.IF ONLY\nGOATGUY COULD\nDO THIS !"}; end
    -- if (randomNumber == 2) then self.dialogue_override = {"YOU WON;T\nKEEP ME\nBOXED\nFOREVER .."}; end
    -- if (randomNumber == 3) then self.dialogue_override =  {""}; end
    --if (randomNumber == 4) then self.dialogue_override = {",.ARE YOU\nBLINKING ?", ",.DO YOU\nHAVE DUST\nIN YOUR EYE;? .", "HERE,. .\nLET ME\nGET IT\nOUT ."}; end
    -- if (randomNumber == 5) then self.dialogue_override = {"C.COLD\nTO THE\nTONGUE,,"}; end
    -- Kristal.Console:log("random number " .. randomNumber);

    if (self.turnNumberNormal == 2) then self.dialogue_override = {"PLEASE JUST BE\nLEASHED WITH WUFF.", "WE'LL BE SO FREE!!"}; self.waves = {"throw_1"}; end
    if (self.turnNumberNormal == 3) then self.dialogue_override = {"GOATGUY.", "DO YOUR CLAWS\nHAVE TO BE\nSO DULL??", "[ps:wolf_bthan]YOU CAN\nDO BETTER\nTHAN THAT!"}; self.waves = {"dustpawclaw_2"}; end
    -- if (self.turnNumberNormal == 3) then self.dialogue_override = {",.. OH RIGHT.", "I HAVE\nA BUNCH OF,.\nPLANTS .", ",,I DEDICATE THESE FLOWERS\nTO YOUR GOAT'S CORPSE. "}; self.waves = {"flowers_1"}; end
    -- if (self.turnNumberNormal == 4) then self.dialogue_override = {",.. OH RIGHT.", "I HAVE\nA BUNCH OF,.\nPLANTS .", ",,I DEDICATE THESE FLOWERS\nTO YOUR GOAT'S CORPSE. "}; self.waves = {"flowers_1"}; end
    end

if (self.turnPhase == 3)
    then
    if (self.turnNumberNormal == 1) then self.dialogue_override = {"DON'T MOVE ON CYAN!\nMOVE ON ORANGE!", "GOATGUY'S\nSUPPOSED TO\nSAY THAT."}; self.waves = {"raven_a"}; end
    if (self.turnNumberNormal == 2) then self.dialogue_override = {"YEP!! THAT'S RIGHT!", "MOVE ON ORANGE,\nSTOP ON CYAN.", "AND DODGE THE FLOWERS!!"}; self.waves = {"flowers_4"}; end
    if (self.turnNumberNormal == 3) then self.dialogue_override = {"DON'T YOU GET IT??", "GOATGUY ISN'T GIVING\nANY GOOD TIPS!!", "ALL HE DOES IS SING!\nUSELESS >W>"}; self.waves = {"sheet_2"}; end
    if (self.turnNumberNormal == 4) then self.dialogue_override = {"AND YET YOU STILL\nSHIELD HIM FROM ME 3:<"}; self.waves = {"raven_4"}; end
    -- if (self.turnNumberNormal == 3) then self.dialogue_override = {""}; self.waves = {"lobera_1"}; end
    end

if (self.turnPhase == 4)
    then

    local randomNumber = love.math.random(1, 5);
    self.waves = {"lobera_b", "throw_2", "dustpawclaw_3", "raven_4"} -- throw 3 is easier than throw 2
    -- if (randomNumber == 1) then self.dialogue_override = {"LOOK, ..\nIT'S NOT\nCONTRJOVERSIAL.", "JUST., .\nLEAVE GOATGUY\nIN SOME\nDUMPSTER,."}; end
    -- if (randomNumber == 2) then self.dialogue_override = {"I. , L OVE\nTYPING\nLIKE THIS;"}; end
    -- if (randomNumber == 3) then self.dialogue_override = {"GOATGUY,, .\nHAVE YOU\nSEEN THE\nINTERNET?", "..YOU;LL NEED\nYOUR GUNS\nFOR THIS ."}; end
    -- if (randomNumber == 4) then self.dialogue_override = {"LOOKING FOR\nPOWER ?.", "OH.,\nH..H.H H.A \nHA.HA", "THAT'S\nFAN.FANTASTIC ."}; end
    -- if (randomNumber == 5) then self.dialogue_override = {",UNPLUG\nGLUE GUNS\nWHEN NOT\nIN USE ."}; end

    --"DO YOU LIKE\nHOW YOUR\nDARKNER LOOKS?", "IS HE JUST\nTOO ADORABLE\nTO LET GO??", "[speed:0.3]........", "LET ME\nSEW HIS FACE\nONTO MY HEAD!!"
    if (self.turnNumberNormal == 2) then self.dialogue_override = {"AM I REALLY\nSTILL THAT BAD?", "WEAKER THAN GOATGUY?", "RAHH!!! IF ONLY\nI HAD HIS FACE!!"}; self.waves = {"lobera_b"}; end
    if (self.turnNumberNormal == 3) then self.dialogue_override = {"I JUST\nDON'T GET IT.", "IT MAKES ME FEEL </3"};  self.waves = {"throw_2"}; end -- \"THE BONDS\nYOU BREAK,\nMAKE YOU\nSTRONGER.\"
    if (self.turnNumberNormal == 4) then self.waves = {"dustpawclaw_3"}; end
    -- Kristal.Console:log("random number " .. randomNumber);

    end

if (self.turnPhase == 5)
    then -- removed claw_b
    self.waves = {"sheet_2", "flowers_4", "lobera_b", "throw_4", "raven_3", "dustpawclaw_3"} -- throw 3 is easier than throw 2
    -- if (self.turnNumberNormal == 1) then self.dialogue_override = {"WHY?.,?", "WHY CAN;T YOU\nACCEPT ME?,..", "THE POWER\nI COULD\nGIVE YOU .", ",,.,.", "COMPARED TO\nGOATGUY,.,..", "[ps:wolf_what](OOC:\nI've got you\nmore flowers!)"}; self.waves = {"flowers_break"}; end
    if (self.turnNumberNormal == 1) then self.dialogue_override = {"BARK!!!\nI'M SO DONE!!", "DO YOU KNOW\nWHAT YOU'RE DOING\nTO ME?!?!?!", "YOU'RE\nMAKING ME\nFEEL SO...", "[ps:wolf_immperfect]IMPERFECT..."}; self.waves = {"flowers_break"}; end
    if (self.turnNumberNormal == 2) then self.dialogue_override = {"A HUMAN,\nA MONSTER,\nAND A DARKNER.", "DELTA WARRIORS.", "THE PROPHECY...", "FULFILL IT\nWITH WUFF!!!"}; self.waves = {"prophecybreaker"}; self.text = { "* Cyanosis imminent." } end
    if (self.turnNumberNormal == 3) then self.waves = {"dustpawclaw_3"}; self.text = { "* The air crackles with freedom." } end
    if (self.turnNumberNormal == 4) then self.waves = {"raven_3"}; end
    -- at turn number 2, do special big attack
    end -- phase 5 is finished with 80% at most

if (self.turnPhase == -666)
    then
    self.text = {" "};
    self.waves = {"dustpawclaw_2", "claw_4"} -- throw 3 is easier than throw 2
    if (self.turnNumberNormal == 1)
        then
            if (hitAmount <= 0)
            then
            self.dialogue_override = {"YO;U , STILL\nHAVE.NT TAKEN\nANY HITS !???", "H,A.H,.AHAHHA.HA...", "YOUR\nATTEMPT\nENDS HERE ."};
            else
            self.dialogue_override = {".,I WON;T\nGIVE UP .", "I CANT GIVE UP !!"};
            end
            self.waves = {"lobera_2"}
        end
    if (self.turnNumberNormal == 2) then self.dialogue_override = {"YOU;RE\nTOO TIRED\nTO FIGHT,..", ",..NEAT TRICK,\nRIGHT?", "IT'S' GOATGUY'S\nTYPE OF\nSPELL.'"}; self.waves = {"claw_4"}; end
    -- , "YOU'RE' STUCK !", "AT LEAST,..", "UNTIL YOU\nACCEPT ME.
    if (self.turnNumberNormal == 3) then self.dialogue_override = {"BUT DON;T WORRY. !!", "MY HEALING SPELL\nHAS BEEN\nPERFECTED .", "AREN'T YOU\nGRATEFUL;?'", "YOU ,. CAN\nTASTE THE\nPAIN. .\nFOREVER."}; self.waves = {"flowers_4"}; end
    if (self.turnNumberNormal == 4) then self.dialogue_override = {"AND,DD THE\nONLY WAY\nTO STOP THIS.,,", ",....", "., ,??", "CAN THESE.,\nFJCJKKING THREADS\nGET OFF ME??"}; self.waves = {"flowers_4"}; end
    -- ....,,, .,.,.NO;;!! I,M.M NOT DONE!! I CAN KEEP GOING!!,, I CANT TAKE A BREAK JUST YET .. .,
    -- PLEASEE;!! I DONT WANT TO TURN INTO STONE !! THE PROPHECY CAN SAVE ME ,,.,.!!!



    -- i feel like it talks way too much about wanting to be accepted. move on!!
    -- if (self.turnNumberNormal == 4) then self.dialogue_override = {"BUT DON;T WORRY. !!", "WITH,H.H MY\nPOWERFUL\nHEALING,,", "YOU ,. CAN\nTASTE THE\nPAIN. .\nFOREVER."}; self.waves = {"flowers_4"}; end
    if (Game.battle.state == "ACTIONSELECT")
        then
        Game.battle:setState("ACTIONSDONE");
        end

    local targets = Game.battle.party

    for _, target in ipairs(targets)
        do
    
        if (target.chara.health < 120 and target.chara.id ~= "ralsei")
            then
                target:heal(500);
            end
        end

    -- at turn number 2, do special big attack
    end -- phase 5 is finished with 80% at most

if (self.mercy >= 100 and self.unveiled == true) then self.dialogue_override = nil; self.waves = nil; end

    --self.dialogue_override = {"YOU WON;T\nKEEP ME\nBOXED\nFOREVER .."};
    -- "Am I really wrong?"
-- if (self.turnNumberNormal == 4) then self.dialogue_override = {"AH, .H.HH,\nHOW I MISS\nTRAINING EVERYONE .", "IT,.S A\nSHAME THAT\nTHEY'RE ALL GONE."}; self.waves = {"claw_2"}; end

                   --self.dialogue_override = {",..,..,,,"}; self.waves = {"throw_1"};
  

if (self.willSoundSlice == true)
    then
    self.willSoundSlice = false;
    -- Kristal.Console:log("sliced");
    Assets.playSound("darkclaw")
    end
if (Game.battle.willSoundStrike == true)
    then
    Game.battle.willSoundStrike = false;
    -- Kristal.Console:log("sliced");
    Assets.playSound("darkthorn")
    end
if (self.dustCount <= 0 and self.dustShield == true)
    then
    --self:setAnimation("unswirlquick")
    --self:setActor("maskaughtbattle");
    Assets.playSound("dustgone")
    self.dustShield = false;
    self:NewPhase();
    else
    end
if (Game.battle.shouldUnswirl == true)
    then
    Game.battle.shouldUnswirl = false;
    Kristal.Console:log("shouldunswirled");
    self:setActor("maskaughtcombat");
    self.overlay_sprite = nil;
    end
if (self.dustCount > 0)
    then
    Game.dustForm = true
    self.onAir = true;
    else
    Game.dustForm = false
    self.onAir = false;
    end

local targets = Game.battle.party
for _, target in ipairs(targets)
    do
    -- if Input.pressed("m", false) and target.chara.id ~= "kris" then target.isCursed = true end
    -- if (target.chara.health > 0)
    --     then
    --     if (target.chara.id == "ralsei") then Game.wolfTarget = 1 end
    --     if (target.chara.id == "susie") then Game.wolfTarget = 2 end
    --     if (target.chara.id == "kris") then Game.wolfTarget = 3 end
    --     end
    
    if (target.isCursed and target.chara.health > 0)
        then
        if (target.chara.originalColor == nil) 
            then 
            target.chara.originalColor = {0.55, 0.55, 0.55} ;
            target.chara.originalColor = target.chara.color;
            -- target.chara.originalhead_icons = target.chara.head_icons;
            end
        target.chara.color = {0.55, 0.55, 0.55}
        -- target.chara.head_icons = "party/kris/icon";
        if (target.curseVar == nil) 
        then -- apply cursed
        local dmg_sprite = Sprite("effects/attack/dusted")
                dmg_sprite:setOrigin(0.5, 0.5)
                dmg_sprite:setScale(2, 2)
                dmg_sprite:setPosition(target:getRelativePos(target.width/2, target.height/2))
                dmg_sprite.layer = target.layer + 0.01;
                -- dmg_sprite.timer = Timer();
                -- dmg_sprite:addChild(dmg_sprite.timer)
                -- dmg_sprite.timer:every(0.1, function()
                --         dmg_sprite.x = dmg_sprite.x + 15;
                --         -- Kristal.Console:log("sss");
                --     end, 50)
                dmg_sprite:play(1/2, false, function(s) s:remove(); end)
                target.parent:addChild(dmg_sprite)
        Assets.playSound("dustcurse")
        target.curseVar = 0
        -- local pillarSprite = Assets.getTexture("pillar")
        -- target:statusMessage("msg", "down", {0.55, 0.55, 0.55}, false)
        --DamageNumber("msg", "miss", target.x, target.y, {0.55, 0.55, 0.55})
        -- target:statusMessage("damage", "why", {0.55, 0.55, 0.55}, false)
        -- DamageNumber:init("msg", "down", target.x, target.y, {0.55, 0.55, 0.55})
        local curseText = DamageNumber("", "", target.x - 50, target.y - 70, {0.5, 0, 0.5}) curseText.kill_others = false curseText.width = 40 curseText.height = 40
        target.parent:addChild(curseText)
        curseText.texture = Assets.getTexture("dustcurse")
        -- curseText. 
        end
        target.curseVar = target.curseVar + DTMULT;
        if (target.curseVar % 3 == 0)
        then
            -- spawn dust below
            local dust_sprite = Sprite("effects/dusty")
                dust_sprite:setOrigin(0.5, 0.5)
                dust_sprite:setScale(2, 2)
                local halfWidth = target.width / 2;
                local halfHeight = target.height / 2;
                local halfWidth2 = target.width / 3;
                local halfHeight2 = target.height / 3;
                dust_sprite:setPosition(target:getRelativePos(halfWidth + love.math.random(halfWidth2 * -1, halfWidth2), halfHeight + love.math.random(halfHeight2 * -1, halfHeight2)))
                dust_sprite.layer = target.layer + 0.01;
                dust_sprite.timer = Timer();
                dust_sprite:addChild(dust_sprite.timer)
                dust_sprite.dustSpeed = Utils.pick({-1, 1, -0.5, 0.5});
                dust_sprite.timer:every(1/30, function()
                        dust_sprite.x = dust_sprite.x - dust_sprite.dustSpeed;
                        dust_sprite.alpha = dust_sprite.alpha - 0.04;
                        if (dust_sprite.alpha <= 0) then dust_sprite.timer:remove(); dust_sprite:remove(); return; end
                        -- Kristal.Console:log("sss");
                    end, 50)
                -- dust_sprite:play(1/2, false, function(s) s.timer:remove(); s:remove(); end)
                target.parent:addChild(dust_sprite)
            -- spawn dust above
        end
        if target.curseVar >= 4
            then -- slow curse damage
            target.curseVar = 0
            -- target.x = target.x + 20
            

            local shouldDust = true
            -- if (Game.battle.state == "DEFENDING" and target.chara.health <= 20 ) then shouldDust = false end
            -- Kristal.Console:log(Game.battle.state);
            if (Game.battle.state == "ENEMYDIALOGUE") then shouldDust = false end
            if (Game.battle.state == "CUTSCENE") then shouldDust = false end
            if (Game.battle.state == "ACTIONS") then shouldDust = false end
            if (Game.battle.state == "ACTIONSDONE") then shouldDust = false end
            if (Game.battle.state == "BATTLETEXT") then shouldDust = false end
            if (shouldDust == true and target.chara.health > 1)
                then -- hurt by 1
                target:removeHealth(1);

                if (Game.battle.state ~= "DEFENDING" or 1 == 1)
                    then
                    -- text below
                    -- target:statusMessage("damage", 1, {0.55, 0.55, 0.55}, true)
                    local halfWidth = target.width / 2;
                    local halfHeight = target.height / 2;
                    local halfWidth2 = target.width / 3;
                    local halfHeight2 = target.height / 3;
                    -- dust_sprite:setPosition(target:getRelativePos(halfWidth + love.math.random(halfWidth2 * -1, halfWidth2), halfHeight + love.math.random(halfHeight2 * -1, halfHeight2)))
                    local hurtText = DamageNumber("damage", 1, target.x - halfWidth + love.math.random(halfWidth * -2, halfWidth), target.y - halfHeight + love.math.random(halfHeight * -2, halfHeight), {0.9, 0.25, 0.85});
                    hurtText.kill_others = true;
                    -- hurtText.kill_timer = 50;
                    hurtText.do_once = true;
                    hurtText.physics.speed_x = 5
                    hurtText.physics.speed_y = (-5 - (love.math.random() * 2))
                    hurtText.start_speed_y = self.physics.speed_y
                    -- hurtText.delay = 2;
                    -- hurtText.start_speed_y = 0;
                    target.parent:addChild(hurtText)
                    -- text above
                    end
                end
            end
        else
        target.isCursed = false
        if (target.curseVar ~= nil) then target:shake(4) end
         target.curseVar = nil
        if (target.chara.originalColor ~= nil) then target.chara.color = target.chara.originalColor; end -- target.chara.head_icons = target.chara.originalhead_icons;
    end
end
-- if Input.pressed("v", false) then self:StartSwirl() end
-- if Input.pressed("b", false) then self:EndSwirl() end
-- if Input.pressed("n", false) then  self.y = 180 end
-- if Input.pressed("8", false) then self:setAnimation("raise") end
-- if Input.pressed("8", false) then Maskaught:CurseAll(); end
-- if Input.pressed("9", false) then Maskaught:UncurseAll(); end
-- if Input.pressed("8", false) then self:TrySetState("IDLE"); end
-- if Input.pressed("8", false) then self.sprite:PartSet(self.sprite.maskaughtArmleft, "enemies/MaskaughtBattle/armraise_1"); end

-- if Input.pressed("6", false) then self.sprite:PartSet(self.sprite.maskaughtArmleft, "enemies/MaskaughtBattle/armhigh"); end
-- if Input.pressed("7", false) then self.sprite:PartSet(self.sprite.maskaughtArmleft, "enemies/MaskaughtBattle/armraise_1"); end
-- if Input.pressed("8", false) then self.sprite:PartSet(self.sprite.maskaughtArmleft, "enemies/MaskaughtBattle/armraise_2"); end
-- if Input.pressed("9", false) then self.sprite:PartSet(self.sprite.maskaughtArmleft, "enemies/MaskaughtBattle/armraise_3"); end
-- if (Input.pressed("8", false)) then self:setActor("maskaught"); end
-- if (Input.pressed("9", false)) then self:setActor("maskaughtbattle"); self.overlay_sprite = nil; end
--if (Game.battle.soul ~= nil) then Game.battle:swapSoul(CloneSoul()); end

--battler.scale_x = 2*math.sin(2*math.pi*speed*DT)

self.endTurnLifetime = self.endTurnLifetime + 1 * DTMULT
if self.inSwirling == true 
    then 
    self.scale_x = math.cos(self.swirlLifetime / self.swirlStrength) * 2
    self.swirlLifetime = self.swirlLifetime + 1 * DTMULT
    self.swirlTimeVar = self.swirlTimeVar + 1 * DTMULT
    else
    self.scale_x = Utils.approach(self.scale_x, 2, 0.1 * DTMULT)
    end
if self.swirlTimeVar > 9
    then 
    self.swirlTimeVar = 0
    self:shake(4)


    --self.name = tostring(self.isFighting)

    end

-- if Input.pressed("8", false) then self:TrySetState("IDLE"); end
-- if (self.hurtMoment > 0) then self.hurtMoment = 0; self:TrySetState("HURT"); end

if self.isFighting == 0
    then
    -- self.y = self.y + 0.05
    if (self.sprite.anim == "raise")
        then
        --self:setAnimation("idle");
        end
    if self.x ~= originalWolfX and self.y ~= originalWolfY
        then
        self.x = Utils.ease(self.x, self.originalWolfX, self.endTurnLifetime / 40 * DTMULT, "in-out-quad")
        self.y = Utils.ease(self.y, self.originalWolfY, self.endTurnLifetime / 40 * DTMULT, "in-out-quad")
        end
    end


super.update(self) end

function Maskaught:TrySetState(theState)
    if (self.sprite.maskaughtAnimState ~= nil) then self.sprite:SetState(theState); end
    --if Input.pressed("8", false) then if (self.sprite.maskaughtAnimState ~= nil) then self.sprite:SetState("IDLE"); end end
end

function Maskaught:NewPhase()
    self.turnPhase = self.turnPhase + 1;
    self.turnNumberNormal = 1;
    self.turnNumberDust = 1;
    self:getEnemyDialogue();
    self:getNextWaves();
    -- Kristal.Console:log("newphased");
end
function Maskaught:onDefeat(damage, battler)
Kristal.Console:log("used ondefeat");



Game.battle:setState("CUTSCENE")
if (self.unveiled == false)
    then
    -- Kristal.Console:log(string(Game.battle:getCurrentAction()));
    --if (self.mercy > 0) then Game.battle:startActCutscene("maskaught", "maskaught_unveil"); end
    Game.battle:startCutscene("maskaught", "maskaught_unveil2", self); -- Game.battle:startCutscene("maskaught.maskaught_unveil", nil, self);
    -- self:startCutscene(group, self.party[1], "maskaught")
    Game.battle:resetAttackers();   
    --Game.battle:setState("ACTIONS", "CUTSCENE")
    ----Game.battle:infoText("");

Game.battle.processing_action = false

Game.battle.should_finish_action = false
Game.battle.on_finish_keep_animation = nil
Game.battle.on_finish_action = nil
    --self.dialogue_override = nil;
    self.unveiled = true;
    end
end

-- function Maskaught:onSpared()
-- if (self.unveiled == false)
--     then
--     Kristal.Console:log("really");
--     -- Kristal.Console:log(string(Game.battle:getCurrentAction()));
--     --if (self.mercy > 0) then Game.battle:startActCutscene("maskaught", "maskaught_unveil"); end
--     Game.battle:startCutscene("maskaught.maskaught_unveil", nil, self); --end--Game.battle:startActCutscene("maskaught.maskaught_unveil", nil, self); --end
--     -- self:startCutscene(group, self.party[1], "maskaught")
-- --    Game.battle:resetAttackers();   
--     --Game.battle:setState("ACTIONS", "CUTSCENE")
--     ----Game.battle:infoText("");
--     --self.dialogue_override = nil;
--     self.unveiled = true;
--     end
-- end
function Maskaught:init()
    super.init(self)
    --loneparade--local child = Loneparade(0, 0, 0, 0)
    --loneparade--Game.stage:addChild(child)

    self.hasLeash = true;

    local leashTarget = self;
    local theLeash = LeashLine(80, 0, 80, 0, 0, 0, 80, 0, leashTarget);
    Game.world.stage:addChild(theLeash)

    self.maskLeash = theLeash;

    Game.battle.maskaughtHits = 0;
    Game.battle.shouldUnswirl = false;
    self.swirlStrength = 6;
    self.turnNumberNormal = 1; -- self.turnNumberNormal = 4; -- can change
    self.turnNumberDust = 1;
    self.turnPhase = 1; -- can change for starter
    self.dustMax = 9;
    self.dustCount = 0;
    self.dustShield = false;
    self.swirlTimeVar = 0
    self.swirlLifetime = 0;
    self.unveiled = false;
    self.originalWolfX = self.x
    self.originalWolfY = self.y
    self.endTurnLifetime = 0
    self.isFighting = -1
    self.onAir = false;
    self.willSoundSlice = false;
    self.exit_on_defeat = false;
    Game.battle.willSoundStrike = false;
    if (Game.keepTrackParade ~= nil) then Game.keepTrackParade:startMove(); end
    self.paradefloatMoveX = 0;

    self.quizPhase = 1;

    

    self.timer = Timer()
    self:addChild(self.timer)

    --self.hurtMoment = 0;
    
    -- self.hurt_timer = 0;
    self:setLayer(-95);
    -- Enemy name
    self.name = "MASKAUGHT"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("maskaughtcombat");
    self.overlay_sprite = nil;
    -- Enemy health
    self.tired_percentage = 0.0;
    self.max_health = 6800
    self.health = self.max_health;

    -- self.health = 1; self.mercy = 100;

    if (not Game:getFlag("poisonmaskaught", false))
        then
        else
        self.health = self.health - 400;
        end

    --self.health = 1; --3800 -- 300 per full party hit, but + 200 when susie uses ability
    --self.mercy = 100;
    -- Enemy attack (determines bullet damage)
    self.attack = 12
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        -- "aiming",
       -- "claw_1",
       -- "dustpawclaw_2",
        -- "pawclaw_2",
        -- "dustpawclaw_1",
        -- "dustpawclaw_2",
        -- "aiming",
        -- "movingarena"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        -- "[ps:wolf_better]\"Is it really\nthat important?\"",
        -- "[ps:wolf_cmon]\"I beg you...[wait:15]\nLeave them alone...\"",
        -- "[ps:wolf_imperfect]\"Hey, it's an\nopportunity to learn...\"",
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {"Protects the leash.", "Borrows a Lightner's hopes and dreams.\n* Dark attacks inflict CURSE."}

    
    -- Text randomly displayed at the bottom of the screen each turn
    -- Text displayed at the bottom of the screen when the enemy has low health
    -- self.low_health_text = "* MASKAUGHT grows desperate."

    -- Register act called "Smile"
    self:registerAct("Uncurse", "Lifts\nCURSE\nfrom party")
    self:registerAct(" Mourn", "", {"susie", "ralsei"})
    
    -- self:registerAct(" DodgeAll", "Breaks shield")

    self:registerAct("QuizHeal", "Heals\nthe party", {"ralsei"})
    
    local victims = Game.battle.party
for _, victim in ipairs(victims)
    do
    -- self:registerActFor(victim, "Uncurse", "")
    Game.battle:registerXAction(victim.chara.id, "Uncurse", "Lifts\nCURSE\nfrom party", 0)
    end
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    -- self:registerAct("Tell Story", "", {"ralsei"})
end
-- onhit? maskaught:setAnimation("unswirlquick")
function Maskaught:newDust(amount)
    self.dustCount = self.dustCount + amount;
    if (self.dustCount < 0) then self.dustCount = 0 end
    if (self.dustCount > self.dustMax) then self.dustCount = self.dustMax; end
    if (amount < 0)
        then
        --self:setAnimation("unswirlattempt")
        self.sprite.shieldSprite:shake(10, 0);
        if (self.dustCount > 0) then Assets.playSound("dustdown") end
        for i = 1, (amount * -1), 1
            do

            if (i == 1) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {0.72, 0.6, 0.4}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            if (i == 2) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {0.72, 0.6, 0.4}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            if (i == 3) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {0.72, 0.6, 0.4}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            if (i == 4) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {0.72, 0.6, 0.4}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            -- if (i == 2) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {1, 1, 0.36}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            -- if (i == 3) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {0.33, 0.98, 0.10}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            -- if (i == 4) then local dustText = DamageNumber("", "", self.x - 0, self.y - 70 + (i * 30), {0.33, 0.98, 0.10}) dustText.kill_others = false dustText.width = 40 dustText.height = 40 self.parent:addChild(dustText) dustText.texture = Assets.getTexture("dusttext") end
            end
        end
end
function Maskaught:onAct(battler, name)
    if name == " Mourn" then
        -- Give the enemy 100% mercy
        if (self.dustCount > 0)
                 then
                 self:newDust(-3)
                 else
                 self:addMercy(10)
                 end
        -- Change this enemy's dialogue for 1 turn
        -- self.dialogue_override = "... ^^"
        -- Act text (since it's a list, multiple textboxes)
        local returnDialogue = { "", }
        if (self.dustCount <= 0)
            then
            self.returnDialogue = { "* Everyone mourned quietly." }
            else
            self.returnDialogue = { "* Everyone mourned quietly.[wait:5]\n* MASKAUGHT's dust settles a lot." }
            end
    if (self.mercy == 100)
        then
        self.returnDialogue = { "* It mourns with you." }
        end
        for i = 1, 8
            do
            local fadeThing = Sprite("bullets/flower"); 
            local randomMult = Utils.pick({-1});
            self:addChild(fadeThing);        
            fadeThing:setLayer(self.layer + 100);
            fadeThing:setOrigin(0.5, 0.5);
            fadeThing.alpha = 0.8;
            fadeThing:fadeTo(0, 1.5, function(spritething) fadeThing:remove(); end );
            fadeThing.physics.speed = Utils.random(15, 25) / 13;
            fadeThing.physics.direction = math.rad(90);
            fadeThing.x = Utils.random(-18, 18) + 20;
            fadeThing.y = Utils.random(-40, -45);
            fadeThing.timer = Timer();
            fadeThing:addChild(fadeThing.timer);
            fadeThing.rotation = math.rad(Utils.random(-30, 30)) + Utils.pick({0, 180});
            fadeThing.timer:tween(1.5, fadeThing, {rotation = fadeThing.rotation + math.rad(Utils.random(-50, 50))}, 'in-out-quad');
            end
        return self.returnDialogue

    
    
    elseif name == "QuizHeal" then
    Game.battle:startActCutscene("maskaught", "maskaught_quizheal");
    self.quizPhase = self.quizPhase + 1;
    --Game.battle:startCutscene("maskaught", "maskaught_quizheal", self); 
    elseif name == "Uncurse" then --X-Action
        -- Give the enemy 50% mercy
        if battler.chara.id == "ralsei" then
            -- R-Action text
            local personalDialogue = { "", } self.personalDialogue = { "* Ralsei scooped up some dust!"}
            if (Maskaught:UncurseAll())
             then
             
             self.personalDialogue = 
             { 
                 "* Ralsei fanned away the dust desperately![wait:5]\n(CURSE lifted!)"
             }
             else
             if (self.dustCount > 0)
                 then
                 self:newDust(-1)
                 else
                 self:addMercy(3)
                 end
             
             
             end
            return self.personalDialogue
        elseif battler.chara.id == "susie" then
            local personalDialogue = { "", } self.personalDialogue = { "* Susie ate some of the dust!"}
            if (Maskaught:UncurseAll())
             then
             self.personalDialogue = 
             { 
                 "* Susie lashed out at the dust![wait:5]\n(CURSE lifted!)"
             }
             else
             if (self.dustCount > 0)
                 then
                 self:newDust(-1)
                 else
                 self:addMercy(3)
                 end
             end
            return self.personalDialogue
        else
            local personalDialogue = { "", } self.personalDialogue = { "* " ..battler.chara:getName().. " captured some of the dust."}
            if (Maskaught:UncurseAll())
             then
                 self.personalDialogue = 
                 { 
                     "* " ..battler.chara:getName().. " weaved through the dust.[wait:5]\n(CURSE lifted!)"
                 }
                 else
                 if (self.dustCount > 0)
                     then
                     self:newDust(-1)
                     else
                     self:addMercy(3)
                     end
             end
            return self.personalDialogue
            -- Text for any other character (like Noelle)
            
        end
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Maskaught
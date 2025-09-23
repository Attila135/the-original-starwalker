local sheet_1, super = Class(Wave)
local angleChange = 1
local timeVar = 0
local initialX = 0
local initialY = 0
local randomX = 0
local randomY = 0
local attackAmount = 3

-- function sheet_1:onDamage(soul)
-- super.onDamage(self)
-- Kristal.Console:log("Cursed real!")
-- if Game:getConfig("targetSystem") then
-- 			local target = self:getTarget()
-- 
-- 			target:heal(amountHealed)
-- 		else
-- 			local target = Utils.pick(Game.party)
-- 			target:heal(amountHealed)
-- 		end
-- end

function sheet_1:onEnd()
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    -- attacker2.x = self.initialX
    -- attacker2.y = self.initialY
    end
end
function sheet_1:onStart()
    Game.battle:swapSoul(CloneSoul());
    self.time = 999.0
    self.randomX = love.math.random(0, 50)
    self.randomY = love.math.random(70, 90) * Utils.randomSign()
    self.randomPawNum = love.math.random(0, 360)
    self.attackAmount = 7
    self.timeVar = 0
    self.angleChange = 0
    self.spinSpeeder = 0
    self.spawnedClefs = false;
    self.clefSpawn1 = nil;
    self.clefSpawn2 = nil;
    -- self.spinSpeeder = Utils.pick({10, 8, -10, -8})
    local attackers2 = self:getAttackers()
    for _, attacker2 in ipairs(attackers2) do
    self.initialX = attacker2.x
    self.initialY = attacker2.y
    self.noteSpeed = 2;
    self.sheetNotes = 
    {
        --{{nil, 19, false, 1}, {"F5", 10}, {"F5", 10}, {"D5", 15}, {"B4", 15}, {"G4", 15}, {"E4", 15}},
        -- {{nil, 19, false, 1}, {"C4", 15}, {"D4", 15}, {"E4", 15}, {"F4", 15}, {"G4", 15}, {"A4", 15}, {"B4", 15}, {"C5", 15}, {"D5", 15}, {"E5", 15}, {"F5", 15}, {"G5", 15}},
        -- {{nil, 19, false, 1}, {"E2", 15}, {"F2", 15}, {"G2", 15}, {"A2", 15}, {"B2", 15}, {"C3", 15}, {"D3", 15}, {"E3", 15}, {"F3", 15}, {"G3", 15}, {"A3", 15}, {"B3", 15}},
        
        -- Maskaught motif
        {{nil, 19, false, 1}, {"F4", 10}, {"F4", 10}, {"F4", 10}, {"F4", 15}, {"G4", 15}, {"F4", 10}, {"E4", 10}, {"D4", 10}, {"B3", 10}, {"D4", 10} },
        
        {{nil, 19, false, 1}, {"A3", 10}, {"A3", 10}, {"G3", 10}, {"G3", 10}, {"G3", 10}, {"G3", 10}, {"G3", 10 }, {"G3", 10 }, {"G3", 10 }, {"G3", 10 } },
        {{nil, 19, false, 1}, {"F3", 10}, {"F3", 10}, {"E3", 10}, {"E3", 10}, {"D3", 10}, {"D3", 10}, {"D3", 10 }, {"D3", 10 }, {"D3", 10 }, {"D3", 10 } },
        {{nil, 19, false, 1}, {"C3", 10}, {"C3", 10}, {"C3", 10}, {"C3", 10}, {"C3", 10}, {"C3", 10}, {"B2", 10 }, {"B2", 10 }, {"B2", 10 }, {"B2", 10 } },
        -- above

        -- Sona motif
        -- {{nil, 19, false, 1}, {"G5", 6}, {"F5#", 6}, {"D5", 15}, {"C4#", 0}, {"D5", 6}, {"C5#", 6}, {"A4", 15}, {"F4#", 0}},
        -- {{nil, 19, false, 1}, {"G4", 6}, {"F4#", 6}, {"D4", 15}, {"C3#", 0}, {"D4", 6}, {"C4#", 6}, {"A3", 15}, {"F3#", 0}},
        -- {{nil, 19, false, 1}, {"D4", 6}, {"D4", 6},  {"A3", 15}, {"A3", 0},  {"A3", 6}, {"A3", 6},  {"F3#", 15}, {"D3", 0}},
        -- 
        -- {{nil, 19, false, 1}, {"00", 20}, {"B3", 6}, {"00", 6},  {"B3", 15}, {"00", 0},  {"F3#", 6}, {"00", 6}, {"F3#", 15}, {"00", 0}},
        -- {{nil, 19, false, 1}, {"00", 20}, {"G3", 6}, {"00", 6},  {"G3", 15}, {"00", 0},  {"D3", 6}, {"00", 6},  {"D3", 15}, {"00", 0}},
        -- {{nil, 19, false, 1}, {"00", 20}, {"D3", 6}, {"00", 6},  {"D3", 15}, {"00", 0},  {"B2", 6}, {"00", 6},  {"B2", 15}, {"00", 0}},
        -- above



       -- {{nil, 19, false, 1}, {"A3", 0}, {"G3", 0}, {"G3", 0}, {"G3", 0 } },
       -- {{nil, 19, false, 1}, {"F3", 0}, {"E3", 0}, {"D3", 0}, {"D3", 0 } },
       -- {{nil, 19, false, 1}, {"C3", 0}, {"C3", 0}, {"C3", 0}, {"B2", 0 } }

       

       -- {{nil, 19, false, 1}, {"A3", 0}, {"2", 0}, {"G3", 0}, {"2", 0}, {"G3", 0}, {"2", 0}, {"G3", 0 } },
       -- {{nil, 19, false, 1}, {"F3", 0}, {"2", 0}, {"E3", 0}, {"2", 0}, {"D3", 0}, {"2", 0}, {"D3", 0 } },
       -- {{nil, 19, false, 1}, {"C3", 0}, {"2", 0}, {"C3", 0}, {"2", 0}, {"C3", 0}, {"2", 0}, {"B2", 0 } }
        --{{nil, 19, false, 1}, {"E2", 0}, {"2", 0} },
        -- {{nil, 19, false, 1}, {"C4", 40}, {"D4", 5}, {"E4", 0}},
    };
    self.noteNumber = 1;
    self.sheetTurns = 3;
    self.ravenCount = 0;
    self.ravenAmmo = 4;
    -- attacker2:StartSwirl()
    end

    --maybe--self.timer = Timer()
self.timer:every(1/30, function()
-- FIXER MULT BEGIN
if (2 == -2 and self.timeVar % 80 == 0 and self.ravenAmmo > 0)
        then
            --self:spawnBullet("raven", Game.battle.arena.x, Game.battle.arena.y, 50, 0, math.rad(180), 0, 1, true);
            self.ravenAmmo = self.ravenAmmo - 1;
            -- if (self.ravenCount % 2 == 0)
            -- then
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 0, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 40, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 60, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 80, 50, 0, math.rad(180), 8, 1);
            -- else
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 0, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 40, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 60, 50, 0, math.rad(180), 8, 1);
            -- self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 80, 50, 0, math.rad(180), 8, 1);
            -- end
            local ravenSpeed = 16;
            --self:spawnBullet("raven", Game.battle.arena.x - 180, Game.battle.soul.y, -50, 0, math.rad(45), ravenSpeed, 1);
            if (self.ravenCount % 2 == 0)
            then
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 80, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 40, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 0, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 40, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 80, 50, 0, math.rad(180), ravenSpeed, 1, false);
            else
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 60, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 20, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 20, 50, 0, math.rad(180), ravenSpeed, 1, false);
            self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y - 60, 50, 0, math.rad(180), ravenSpeed, 1, false);
            --self:spawnBullet("raven", Game.battle.arena.x + 180, Game.battle.arena.y + 80, 50, 0, math.rad(180), 8, 1);
            end
        self.ravenCount = self.ravenCount + 1;
        end
    self.timeVar = self.timeVar + 1
    if (self.timeVar == 5)
        then
        self.clefSpawn1 = self:spawnBullet("clef", Game.battle.arena.x - 140, Game.battle.arena.y, 0, 0, 1, 1.2, 90.0, 0.0, 20.0, 95);
        self.clefSpawn2 = self:spawnBullet("clef", Game.battle.arena.x - 140, Game.battle.arena.y, 0, 0, 2, 1.2, 90.0, 0.0, 20.0, 60);
        -- self.clefSpawn1 = clefSpawn1;
        self.spawnedClefs = true;
        
        end

        local doReset = true;

                        for checkSelected = 1, #self.sheetNotes, 1
                            do
                            if (self.sheetNotes[checkSelected][1][3] == false) then doReset = false; end
                            end
                        if (doReset == true)
                            then
                            -- print("full reset");
                            self.sheetTurns = self.sheetTurns - 1;
                            if (self.sheetTurns <= 0 and self.sheetTurns > -5) then Game.battle.wave_timer = 998.0; self.sheetTurns = -10; end
                            for resetSelected = 1, #self.sheetNotes, 1
                                do
                                self.sheetNotes[resetSelected][1][2] = 19;
                                self.sheetNotes[resetSelected][1][3] = false;
                                self.sheetNotes[resetSelected][1][4] = 1;
                                end
                            end
                            -- print(Game.battle.wave_timer);
    for sheetSelected = 1, #self.sheetNotes, 1
    do
        self.sheetNotes[sheetSelected][1][2] = self.sheetNotes[sheetSelected][1][2] + 1;
        if (self.spawnedClefs == true and self.timeVar >= 12 and self.sheetNotes[sheetSelected][1][3] == false)
            then
                if (self.sheetNotes[sheetSelected][1][2]%20 == 0)
                then
            
                local selectedNote = nil
                local noteY = 0;
                selectedNote = "D5";
                selectedNote = self.sheetNotes[sheetSelected][self.sheetNotes[sheetSelected][1][4]][1];
                self.sheetNotes[sheetSelected][1][2] = self.sheetNotes[sheetSelected][1][2] + self.sheetNotes[sheetSelected][self.sheetNotes[sheetSelected][1][4]][2];

                if (self.sheetNotes[sheetSelected][1][4] >= #self.sheetNotes[sheetSelected])
                    then
                        self.sheetNotes[sheetSelected][1][3] = true;
                        -- print(tostring(sheetSelected) .. " reached the end")
                    else
                    self.sheetNotes[sheetSelected][1][4] = self.sheetNotes[sheetSelected][1][4] + 1;
                    -- print(tostring(sheetSelected) .. " incremented")
                    end
                local willDust = false;
                local targetClef = nil;
                targetClef = self.clefSpawn1;
                if (selectedNote ~= nil)
                    then
                    if (string.find(selectedNote, "#")) then willDust = true; selectedNote = string.sub(selectedNote, 1, 2); end
                    if (string.find(selectedNote, "2") or string.find(selectedNote, "3")) then targetClef = self.clefSpawn2; end
                    end
                if (selectedNote == "G5") then noteY = self.clefSpawn1.Line1Sprite.y - 3; end
                if (selectedNote == "F5") then noteY = self.clefSpawn1.Line1Sprite.y; end
                if (selectedNote == "E5") then noteY = self.clefSpawn1.Line2Sprite.y - 3; end
                if (selectedNote == "D5") then noteY = self.clefSpawn1.Line2Sprite.y; end
                if (selectedNote == "C5") then noteY = self.clefSpawn1.Line3Sprite.y - 3; end
                if (selectedNote == "B4") then noteY = self.clefSpawn1.Line3Sprite.y; end
                if (selectedNote == "A4") then noteY = self.clefSpawn1.Line4Sprite.y - 3; end
                if (selectedNote == "G4") then noteY = self.clefSpawn1.Line4Sprite.y; end
                if (selectedNote == "F4") then noteY = self.clefSpawn1.Line5Sprite.y - 3; end
                if (selectedNote == "E4") then noteY = self.clefSpawn1.Line5Sprite.y; end
                if (selectedNote == "D4") then noteY = self.clefSpawn1.Line5Sprite.y + 3; end
                if (selectedNote == "C4") then noteY = self.clefSpawn1.Line5Sprite.y + 6; end

                if (selectedNote == "B3") then noteY = self.clefSpawn1.Line1Sprite.y - 3; end
                if (selectedNote == "A3") then noteY = self.clefSpawn1.Line1Sprite.y; end
                if (selectedNote == "G3") then noteY = self.clefSpawn1.Line2Sprite.y - 3; end
                if (selectedNote == "F3") then noteY = self.clefSpawn1.Line2Sprite.y; end
                if (selectedNote == "E3") then noteY = self.clefSpawn1.Line3Sprite.y - 3; end
                if (selectedNote == "D3") then noteY = self.clefSpawn1.Line3Sprite.y; end
                if (selectedNote == "C3") then noteY = self.clefSpawn1.Line4Sprite.y - 3; end
                if (selectedNote == "B2") then noteY = self.clefSpawn1.Line4Sprite.y; end
                if (selectedNote == "A2") then noteY = self.clefSpawn1.Line5Sprite.y - 3; end
                if (selectedNote == "G2") then noteY = self.clefSpawn1.Line5Sprite.y; end
                if (selectedNote == "F2") then noteY = self.clefSpawn1.Line5Sprite.y + 3; end
                if (selectedNote == "E2") then noteY = self.clefSpawn1.Line5Sprite.y + 6; end
                if (selectedNote == "D2") then noteY = self.clefSpawn1.Line5Sprite.y + 9; end
                if (selectedNote == "C2") then noteY = self.clefSpawn1.Line5Sprite.y + 12; end
                if (selectedNote ~= nil)
                    then
                    if (string.find(selectedNote, "2") or string.find(selectedNote, "3")) then noteY = noteY - 11; end
                    end

                if (selectedNote ~= nil and self.sheetTurns > 0 and selectedNote ~= "00" and selectedNote ~= "000")
                    then
                        if (willDust == true)
                            then
                            local bullet = self:spawnBulletTo(targetClef, "dustclefnote", 200, noteY, 0, self.noteSpeed * -1)
                            bullet.layer = -1;
                            else
                            local bullet = self:spawnBulletTo(targetClef, "breakclefnote", 200, noteY, 0, self.noteSpeed * -1)
                            bullet.layer = -1;
                            end                    
                    end
            
                -- self.clefSpawn1.realX = self.clefSpawn1.realX + 5;
                
                end
            end
    end
-- FIXER END BELOW
    end)
-- FIXER MULT END
    
end

function sheet_1:update()
    -- Code here gets called every frame
    -- self.timer = self.timer + (1 * DTMULT)
    
    super.update(self)
    


end

return sheet_1
local QuizBox, super = Class(Object)




function QuizBox:init(spawnX, spawnY, qPhase)
    super.init(self, spawnX, spawnY)
    self.spawnX = spawnX;
    self.spawnY = spawnY;
    self.qPhase = qPhase;
    self.sprite = Sprite("quiz");
    self.sprite:setAnimation({"quiz", 1.0, true});
    if (self.qPhase >= 6)
        then
        self.sprite = Sprite("quizalt");
        end
    self:addChild(self.sprite);
    self.sprite:setOrigin(0.5, 0.5);
    self:setOrigin(0.5, 0.5);
    --Kristal.Console:log("quizer spawned")
    self.lifetime = 0;
    self.textSiner = 0;
    self.desY = 230;
    self.boxFont = Assets.getFont("plain")
    self.textAlpha = 0;
    self.textAsk = "";
    self.finished = false;
    self.answerTime = 0;
    self.answerCorrect = false;
    self.answerX = -32;
    self.timer = Timer()
    self:addChild(self.timer)
    -- Kristal.Console:log("initiated")
end



function QuizBox:ask(theText)
    self.textAsk = theText;
    self.textAlpha = 0;
end

function QuizBox:wrong()
    -- Assets.playSound("error")
    Assets.playSound("wolf_immperfect");
    local ralsei = Game.battle:getPartyBattler("ralsei");
    ralsei:hurt(80);
    self.answerTime = 1;
    self.answerCorrect = false;
end

function QuizBox:correct(kris, susie, ralsei)
    kris:heal(30);
    susie:heal(30);
    ralsei:heal(25);
    self.answerTime = 10;
    self.answerCorrect = true;
end

function QuizBox:finish()
    self.finished = true;
    self.lifetime = 0;
end

function QuizBox:update()
    super.update(self)
    self.lifetime = self.lifetime + 1 * DTMULT;
    self.textSiner = self.textSiner + 1 * DTMULT;
    if (self.answerTime > 0)
        then
        self.answerTime = self.answerTime - 1 * DTMULT;
        if (self.answerTime <= 0)
            then
            local answerType = ""; if (self.answerCorrect == true) then answerType = "qcorrect"; Assets.playSound("sparkle_gem"); else answerType = "qwrong"; Assets.playSound("error"); end
            local answerIcon = Sprite(answerType);
            answerIcon:setOrigin(0.5, 0.5);
            answerIcon.x = answerIcon.x + self.answerX;
            answerIcon.y = answerIcon.y + 32;
            answerIcon.alpha = 0.0;
            answerIcon:setScale(2, 2);
            self.timer:tween(1, answerIcon, {alpha = 1.0, scale_x = 1, scale_y = 1}, 'in-out-quad')
            self:addChild(answerIcon);
            self.answerX = self.answerX + 32;
            
            end
        end
    if (self.finished == false) 
        then 
        if (self.textAlpha < 1) then self.textAlpha = self.textAlpha + 0.02 * DTMULT; end
        self.y = Utils.ease(self.spawnY, self.desY, self.lifetime / 60, "in-out-quad")
        else
        --if (self.textAlpha < 1) then self.textAlpha = self.textAlpha + 0.02; end
        self.textAlpha = self.textAlpha - 0.02 * DTMULT;
        self.alpha = self.alpha - 0.02 * DTMULT;
        self.y = Utils.ease(self.desY, self.spawnY, self.lifetime / 60, "in-out-quad")
        if (self.alpha <= 0) then self:remove(); end
        end
    

end

function QuizBox:draw()
    super.draw(self)
    love.graphics.setFont(self.boxFont)
    if (self.qPhase >= 6) then Draw.setColor(0.247, 1.0, 0.235) end
    love.graphics.printf({{1.0, 1.0, 1.0, self.textAlpha}, self.textAsk}, 0 - self.sprite.width / 3.5 + (math.cos(self.textSiner / 30) * 4), self.sprite.height * -1 + 58, 100, "center", 0, 1.0, 1.0, 0.0, 0.0)
    
    -- self.x = self.x + 5
end

return QuizBox

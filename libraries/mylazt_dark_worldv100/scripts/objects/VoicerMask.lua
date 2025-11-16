local Voicermask, super = Class(Object)




function Voicermask:init()
    super.init(self, 0, 0)

    -- Kristal.Console:log("voicer spawned")
    

    -- Kristal.Console:log("initiated")
end

function Voicermask:update()
    super.update(self)
    if (self.focusActor ~= nil)
        then
        self.focusActor.bg.x = self.focusActor.bg.x + 1
        self.focusActor.bg.y = self.focusActor.bg.y + 0.5
        self.focusActor.mask:setSprite(self.focusActor:getTexture())
        self.focusActor.parent.alpha = 1 - self.focusActor.bg.alpha
        end
    if (Game.stage.wolfDuration ~= nil and Game.stage.wolfing ~= nil)
        then
        if (Game.stage.wolfDuration > 0)
            then
            Game.stage.wolfDuration = Game.stage.wolfDuration - 1
            if (self.focusActor.bg.alpha < 1 and Game.stage.wolfing == true) then self.focusActor.bg.alpha = self.focusActor.bg.alpha + 0.2 end
            -- Kristal.Console:log("AWOO")
            else
            if (self.focusActor.bg.alpha > 0 and Game.stage.wolfing == false) then self.focusActor.bg.alpha = self.focusActor.bg.alpha - 0.05 end
            end
        end
end

function Voicermask:draw()
    super.draw(self)
   
    
    -- self.x = self.x + 5
end

return Voicermask

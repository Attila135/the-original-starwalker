local Switch, super = Class(Event)

-- TO USE THIS EVENT, MAKE SURE THE EVENT HAS THE PROPERTY "amount" (integer) AND THE PROPERTY "puzzle" (string)
-- the property "amount" must be equal to the amount of required buttons to complete the puzzle
-- the property "puzzle" must be the name of the puzzle
function Switch:init(data)
    super.init(self, data)
    self:setSprite("world/events/switch_1")
    self:setOrigin(0.5, 1)
    self.pressed = false
end


function Switch:onInteract(player, dir)
    if not self.pressed then
        local number = DamageNumber("msg", "bonus", self:getRelativePos(0,40))
        self.parent:addChild(number)
        Assets.playSound("mercyadd")
        self.pressed = true
        Game:addFlag("tension_switches", 1)
        self:setSprite("world/events/switch_2")
        Assets.playSound("noise")
        Game.world.timer:after(0.5, function ()
            if Game:getFlag("tension_switches") == 5 then
                Assets.playSound("creepy_jingle")
                Game:setFlag("tension_chest", true)
            end
        end)
    end
end

return Switch
local Button, super = Class(Event)

-- TO USE THIS EVENT, MAKE SURE THE EVENT HAS THE PROPERTY "required" (boolean) AND THE PROPERTY "pressed" (boolean)
-- the property "required" must be set to true if you want it to be required to finish the puzzle
-- Keep the proptery "pressed" to false in the map file
function Button:init(data)
    super.init(self, data)
    local properties = data.properties or {}
    self.required = properties["required"] 
    -- Gets for the propety "required"
    self.pressed = properties["pressed"]
    -- Gets for the propety "pressed"
    self:setSprite("world/events/button_1")
    self.pressed = false
    local puzzle = Game:getFlag("PuzzleState")
    -- Gets for the propety "PuzzleState"
    
end


function Button:onEnter(player)
    local puzzle = Game:getFlag("PuzzleState")
    local flag = Game:getFlag("RequiredButtonsPressed")
    if puzzle == false then
        if self.pressed == false and self.required == false then
            -- If the  button is not pressed and not required, do this.
            self:setSprite("world/events/button_2")
            Assets.playSound("noise")
            self.pressed = true
            -- Sets button to pressed
            Game:setFlag("RequiredButtonsPressed", flag - 1)
        end
        if self.required == true and self.pressed == false then
            -- If the  button is not pressed and is required, do this.
            self:setSprite("world/events/button_2")
            Assets.playSound("noise")
            self.pressed = true
            -- Sets button to pressed
            Game:setFlag("RequiredButtonsPressed", flag + 1)
        end
    end
    if puzzle == true then
        if self.pressed == false then
        self:setSprite("world/events/button_2")
        Assets.playSound("noise")
        self.pressed = true
        end
        if self.pressed == true then
        end
    end
    return true
end
    -- Gets the value of required buttons pressed


function Button:update()
    local puzzle = Game:getFlag("PuzzleState")
    -- Extra Stuff
    if self.pressed == true  then
        self:setSprite("world/events/button_2")
    end
    if self.pressed == false  then
        self:setSprite("world/events/button_1")
    end
    -- Resets the butons when puzzle is being reset
    if puzzle == "reset" then
        self.pressed = false
        self:setSprite("world/events/button_1")
    end
    return true
end

return Button
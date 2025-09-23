local Button, super = Class(Event)

-- TO USE THIS EVENT, MAKE SURE THE EVENT HAS THE PROPERTY "required" (boolean) AND THE PROPERTY "pressed" (boolean)
-- the property "required" must be set to true if you want it to be required to finish the puzzle
-- Keep the proptery "pressed" to false in the map file
function Button:init(data)
    super.init(self, data)
    local properties = data.properties or {}
    self.hole = properties["hole"] 
    -- Gets for the propety "required"
    self.visible = properties["visible"]
    -- Gets for the propety "pressed"
    self:setSprite("world/events/no_hole")
    self.visible = false
end


function Button:onCollide(player)
    if self.hole == false then
        self:setSprite("world/events/no_hole")
    elseif self.hole == true then
        self:setSprite("world/events/hole")
        self.visible = true
    end
    return true
end

return Button
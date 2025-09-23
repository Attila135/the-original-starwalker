---@class LightItemMenu : LightItemMenu
---@overload fun(...) : LightItemMenu
local LightItemMenu, super = Class(LightItemMenu)

function LightItemMenu:draw()
    love.graphics.setFont(self.font)

    local inventory = Game.inventory:getStorage(self.storage)

    for index, item in ipairs(inventory) do
        if item.usable_in == "world" or item.usable_in == "all" then
            Draw.setColor(PALETTE["world_text"])
        else
            Draw.setColor(PALETTE["world_text_unusable"])
        end
        love.graphics.print(item:getName(), 20, -28 + (index * 32))
    end

    Draw.setColor(PALETTE["world_text"])
    love.graphics.print("USE" , 20 , 284)
    love.graphics.print("INFO", 116, 284)
    love.graphics.print("DROP", 230, 284)

    Draw.setColor(Game:getSoulColor())
    if self.state == "ITEMSELECT" then
        Draw.draw(self.heart_sprite, 5, -11 + (32 * self.item_selecting), Game:getSoulRotation(), 2, 2, 4.5, 4.5)
    else
        if self.option_selecting == 1 then
            Draw.draw(self.heart_sprite, 5, 301, Game:getSoulRotation(), 2, 2, 4.5, 4.5)
        elseif self.option_selecting == 2 then
            Draw.draw(self.heart_sprite, 100, 301, Game:getSoulRotation(), 2, 2, 4.5, 4.5)
        elseif self.option_selecting == 3 then
            Draw.draw(self.heart_sprite, 215, 301, Game:getSoulRotation(), 2, 2, 4.5, 4.5)
        end
    end

    super.super.draw(self)
end

return LightItemMenu
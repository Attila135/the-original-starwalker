---@class DarkMenu : DarkMenu
---@overload fun(...) : DarkMenu
local DarkMenu, super = Class(DarkMenu)

function DarkMenu:drawButton(index, x, y)
    local button = self.buttons[index]
    local sprite = button.sprite
    if index == self.selected_submenu then
        sprite = button.hovered_sprite
    end
    Draw.setColor(1, 1, 1)
    Draw.draw(sprite, x, y, 0, 2, 2)
    if index == self.selected_submenu and self.state == "MAIN" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, x + 15, y + 25, Game:getSoulRotation(), 2, 2, self.heart_sprite:getWidth() / 2, self.heart_sprite:getHeight() / 2)
    end
end

return DarkMenu

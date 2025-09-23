---@class LightCellMenu : LightCellMenu
---@overload fun(...) : LightCellMenu
local LightCellMenu, super = Class(LightCellMenu)

function LightCellMenu:draw()
    love.graphics.setFont(self.font)
    Draw.setColor(PALETTE["world_text"])

    for index, call in ipairs(Game.world.calls) do
        love.graphics.print(call[1], 20, -28 + (index * 32))
    end

    Draw.setColor(Game:getSoulColor())
    Draw.draw(self.heart_sprite, -4, -20 + (32 * self.current_selecting), Game:getSoulRotation(), 2, 2, 4.5, 4.5)

    super.super.draw(self)
end

return LightCellMenu
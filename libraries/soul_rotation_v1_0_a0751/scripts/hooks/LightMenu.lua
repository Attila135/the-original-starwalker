---@class LightMenu : LightMenu
---@overload fun(...) : LightMenu
local LightMenu, super = Class(LightMenu)

function LightMenu:draw()
    super.super.draw(self)

    local offset = 0
    if self.top then
        offset = 270
    end

    local chara = Game.party[1]

    love.graphics.setFont(self.font)
    Draw.setColor(PALETTE["world_text"])
    love.graphics.print(chara:getName(), 46, 60 + offset)

    love.graphics.setFont(self.font_small)
    love.graphics.print("LV  "..chara:getLightLV(), 46, 100 + offset)
    love.graphics.print("HP  "..chara:getHealth().."/"..chara:getStat("health"), 46, 118 + offset)
    love.graphics.print(Utils.padString(Game:getConfig("lightCurrencyShort"), 4)..Game.lw_money, 46, 136 + offset)

    love.graphics.setFont(self.font)
    if Game.inventory:getItemCount(self.storage, false) <= 0 then
        Draw.setColor(PALETTE["world_gray"])
    else
        Draw.setColor(PALETTE["world_text"])
    end
    love.graphics.print("ITEM", 84, 188 + (36 * 0))
    Draw.setColor(PALETTE["world_text"])
    love.graphics.print("STAT", 84, 188 + (36 * 1))
    if Game:getFlag("has_cell_phone", false) then
        if #Game.world.calls > 0 then
            Draw.setColor(PALETTE["world_text"])
        else
            Draw.setColor(PALETTE["world_gray"])
        end
        love.graphics.print("CELL", 84, 188 + (36 * 2))
    end

    if self.state == "MAIN" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 65, 169 + (36 * self.current_selecting), Game:getSoulRotation(), 2, 2, 4.5, 4.5)
    end
end

return LightMenu

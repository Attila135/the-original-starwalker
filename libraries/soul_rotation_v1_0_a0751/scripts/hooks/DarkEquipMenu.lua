---@class DarkEquipMenu : DarkEquipMenu
---@overload fun(...) : DarkEquipMenu
local DarkEquipMenu, super = Class(DarkEquipMenu)

function DarkEquipMenu:drawEquipped()
    local party = self.party:getSelected()
    Draw.setColor(1, 1, 1, 1)

    if self.state ~= "SLOTS" or self.selected_slot ~= 1 then
        local weapon_icon = Assets.getTexture(party:getWeaponIcon())
        if weapon_icon then
            Draw.draw(weapon_icon, 220, -4, 0, 2, 2)
        end
    end
    if self.state ~= "SLOTS" or self.selected_slot ~= 2 then Draw.draw(self.armor_icons[1], 220, 30, 0, 2, 2) end
    if self.state ~= "SLOTS" or self.selected_slot ~= 3 then Draw.draw(self.armor_icons[2], 220, 60, 0, 2, 2) end

    if self.state == "SLOTS" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, 234, 18 + ((self.selected_slot - 1) * 30), Game:getSoulRotation(), 1, 1, 8, 8)
    end

    for i = 1, 3 do
        self:drawEquippedItem(i, 261, 6 + ((i - 1) * 30))
    end
end

function DarkEquipMenu:drawItems()
    local type = self:getCurrentItemType()
    local party = self.party:getSelected()
    local items = Game.inventory:getStorage(type)

    local x, y = 282, 124

    local scroll = self.item_scroll[type]
    for i = scroll, math.min(items.max, scroll + 5) do
        local item = items[i]
        local offset = i - scroll

        if item then
            local usable = false
            if self.selected_slot == 1 then
                usable = party:canEquip(item, "weapon", self.selected_slot)
            else
                usable = party:canEquip(item, "armor", self.selected_slot - 1)
            end
            if usable then
                Draw.setColor(1, 1, 1)
            else
                Draw.setColor(0.5, 0.5, 0.5)
            end
            if item.icon and Assets.getTexture(item.icon) then
                Draw.draw(Assets.getTexture(item.icon), x, y + (offset * 27), 0, 2, 2)
            end
            love.graphics.print(item:getName(), x + 20, y + (offset * 27) - 6)
        else
            Draw.setColor(0.25, 0.25, 0.25)
            love.graphics.print("---------", x + 20, y + (offset * 27) - 6)
        end
    end

    if self.state == "ITEMS" then
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, x - 12, y + 10 + ((self.selected_item[type] - scroll) * 27), Game:getSoulRotation(), 1, 1, 8, 8)

        if items.max > 6 then
            Draw.setColor(1, 1, 1)
            local sine_off = math.sin((Kristal.getTime() * 30) / 12) * 3
            if scroll + 6 <= items.max then
                Draw.draw(self.arrow_sprite, x + 187, y + 149 + sine_off)
            end
            if scroll > 1 then
                Draw.draw(self.arrow_sprite, x + 187, y + 14 - sine_off, 0, 1, -1)
            end
        end
        if items.max <= 12 then
            Draw.setColor(1, 1, 1)
            for i = 1, items.max do
                local item = items[i]
                local percentage = (i - 1) / (items.max - 1)
                if self.selected_item[type] == i and item then
                    love.graphics.rectangle("fill", x + 188, y + 21 + percentage * 110, 10, 10)
                elseif self.selected_item[type] == i then
                    love.graphics.rectangle("fill", x + 189, y + 22 + percentage * 110, 8, 8)
                elseif item then
                    love.graphics.rectangle("fill", x + 191, y + 24 + percentage * 110, 4, 4)
                else
                    love.graphics.rectangle("fill", x + 192, y + 25 + percentage * 110, 2, 2)
                end
            end
        else
            Draw.setColor(0.25, 0.25, 0.25)
            love.graphics.rectangle("fill", x + 191, y + 24, 6, 119)
            local percent = (scroll - 1) / (items.max - 6)
            Draw.setColor(1, 1, 1)
            love.graphics.rectangle("fill", x + 191, y + 24 + math.floor(percent * (119 - 6)), 6, 6)
        end
    end
end

return DarkEquipMenu

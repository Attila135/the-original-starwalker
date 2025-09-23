---@class SaveMenu : SaveMenu
---@overload fun(...) : SaveMenu
local SaveMenu, super = Class(SaveMenu)

function SaveMenu:draw()
    love.graphics.setFont(self.font)
    if self.state == "MAIN" then
        local data = Game:getSavePreview()

        -- Header
        Draw.setColor(PALETTE["world_text"])
        love.graphics.print(data.name, 120, 120)
        love.graphics.print("LV "..data.level, 352, 120)

        local hours = math.floor(data.playtime / 3600)
        local minutes = math.floor(data.playtime / 60 % 60)
        local seconds = math.floor(data.playtime % 60)
        local time_text = string.format("%d:%02d:%02d", hours, minutes, seconds)
        love.graphics.print(time_text, 522 - self.font:getWidth(time_text), 120)

        -- Room name
        love.graphics.print(data.room_name, 319.5 - self.font:getWidth(data.room_name)/2, 170)

        -- Buttons
        love.graphics.print("Save", 170, 220)
        love.graphics.print("Return", 350, 220)
        if Game.inventory.storage_enabled then
            Draw.setColor(PALETTE["world_text"])
        else
            Draw.setColor(PALETTE["world_gray"])
        end
        love.graphics.print("Storage", 170, 260)
        
        if Game:getConfig("enableRecruits") and #Game:getRecruits(true) > 0 then
            Draw.setColor(PALETTE["world_text"])
        else
            Draw.setColor(PALETTE["world_gray"])
        end
        love.graphics.print("Recruits", 350, 260)

        -- Heart
        local heart_positions_x = {150, 330}
        local heart_positions_y = {236, 278}
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, heart_positions_x[self.selected_x], heart_positions_y[self.selected_y], Game:getSoulRotation(), 1, 1, 8, 8)
    elseif self.state == "SAVE" or self.state == "OVERWRITE" then
        self:drawSaveFile(0, Game:getSavePreview(), 74, 26, false, true)

        self:drawSaveFile(1, self.saves[1], 74, 138, self.selected_y == 1)
        Draw.draw(self.divider_sprite, 74, 208, 0, 493, 2)

        self:drawSaveFile(2, self.saves[2], 74, 222, self.selected_y == 2)
        Draw.draw(self.divider_sprite, 74, 292, 0, 493, 2)

        self:drawSaveFile(3, self.saves[3], 74, 306, self.selected_y == 3)
        Draw.draw(self.divider_sprite, 74, 376, 0, 493, 2)

        if self.selected_y == 4 then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 244, 410, Game:getSoulRotation(), 1, 1, 8, 8)

            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("Return", 278, 394)
    elseif self.state == "SAVED" then
        self:drawSaveFile(self.saved_file, self.saves[self.saved_file], 74, 26, false, true)

        self:drawSaveFile(1, self.saves[1], 74, 138, self.selected_y == 1)
        Draw.draw(self.divider_sprite, 74, 208, 0, 493, 2)

        self:drawSaveFile(2, self.saves[2], 74, 222, self.selected_y == 2)
        Draw.draw(self.divider_sprite, 74, 292, 0, 493, 2)

        self:drawSaveFile(3, self.saves[3], 74, 306, self.selected_y == 3)
    end

    super.super.draw(self)

    if self.state == "OVERWRITE" then
        Draw.setColor(PALETTE["world_text"])
        local overwrite_text = "Overwrite Slot "..self.selected_y.."?"
        love.graphics.print(overwrite_text, SCREEN_WIDTH/2 - self.font:getWidth(overwrite_text)/2, 123)

        local function drawOverwriteSave(data, x, y)
            local w = 478

            -- Header
            love.graphics.print(data.name, x + (w/2) - self.font:getWidth(data.name)/2, y)
            love.graphics.print("LV "..data.level, x, y)

            local minutes = math.floor(data.playtime / 60)
            local seconds = math.floor(data.playtime % 60)
            local time_text = string.format("%d:%02d", minutes, seconds)
            love.graphics.print(time_text, x + w - self.font:getWidth(time_text), y)

            -- Room name
            love.graphics.print(data.room_name, x + (w/2) - self.font:getWidth(data.room_name)/2, y+30)
        end

        Draw.setColor(PALETTE["world_text"])
        drawOverwriteSave(self.saves[self.selected_y], 80, 165)
        Draw.setColor(PALETTE["world_text_selected"])
        drawOverwriteSave(Game:getSavePreview(), 80, 235)

        if self.selected_x == 1 then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 150, 340, Game:getSoulRotation(), 1, 1, 8, 8)

            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("Save", 170, 324)

        if self.selected_x == 2 then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 330, 340, Game:getSoulRotation(), 1, 1, 8, 8)

            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("Return", 350, 324)
    end
end

function SaveMenu:drawSaveFile(index, data, x, y, selected, header)
    if self.saved_file then
        if self.saved_file == index then
            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_save_other"])
        end
    else
        if selected then
            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
    end
    if self.saved_file == index and not header then
        love.graphics.print("File Saved", x + 180, y + 22)
    elseif not data then
        love.graphics.print("New File", x + 193, y + 22)
        if selected then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, x + 169, y + 38, Game:getSoulRotation(), 1, 1, 8, 8)
        end
    else
        if self.saved_file or header then
            love.graphics.print("LV "..data.level, x + 26, y + 6)
        else
            love.graphics.print("LV "..data.level, x + 50, y + 6)
        end

        love.graphics.print(data.name, x + (493 / 2) - self.font:getWidth(data.name) / 2, y + 6)

        local minutes = math.floor(data.playtime / 60)
        local seconds = math.floor(data.playtime % 60)
        local time_text = string.format("%d:%02d", minutes, seconds)
        love.graphics.print(time_text, x + 467 - self.font:getWidth(time_text), y + 6)

        love.graphics.print(data.room_name, x + (493 / 2) - self.font:getWidth(data.room_name) / 2, y + 38)

        if selected and not header then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, x + 26, y + 20, Game:getSoulRotation(), 1, 1, 8, 8)
        end
    end
    Draw.setColor(1, 1, 1)
end

return SaveMenu
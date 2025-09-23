---@class SimpleSaveMenu : SimpleSaveMenu
---@overload fun(...) : SimpleSaveMenu
local SimpleSaveMenu, super = Class(SimpleSaveMenu)

function SimpleSaveMenu:draw()
    love.graphics.setFont(self.font)

    if self.state == "SAVED" then
        Draw.setColor(PALETTE["world_text_selected"])
    else
        Draw.setColor(PALETTE["world_text"])
    end

    local data = self.saved_file or {}
    local name      = data.name      or "[EMPTY]"
    local level     = data.level     or 0
    --local playtime  = data.playtime  or 0
    local room_name = data.room_name or ""

    -- POTENTIALLY a DR bug -- playtime ALWAYS uses the current time...?
    -- It's behind an `if (saved == 0)` check, but that variable never gets set to anything OTHER than 0...

    local playtime = Game.playtime

    love.graphics.print(name,         self.box.x,       self.box.y - 10 + 1)
    love.graphics.print("LV "..level, self.box.x + 210, self.box.y - 10 + 1)

    local hours = math.floor(playtime / 3600)
    local minutes = math.floor(playtime / 60 % 60)
    local seconds = math.floor(playtime % 60)
    local time_text = string.format("%d:%02d:%02d", hours, minutes, seconds)
    love.graphics.print(time_text, self.box.x + 280, self.box.y - 10 + 1)

    love.graphics.print(room_name, self.box.x, self.box.y + 30)

    if self.state == "MAIN" then
        love.graphics.print("Save",   self.box.x + 30,  self.box.y + 90 + 1)
        love.graphics.print("Return", self.box.x + 210, self.box.y + 90 + 1)

        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, self.box.x + 10 + (self.selected_x - 1) * 180, self.box.y + 104, Game:getSoulRotation(), 1, 1, 8, 8)
    elseif self.state == "SAVED" then
        love.graphics.print("File saved.", self.box.x + 30, self.box.y + 90 + 1)
    end

    Draw.setColor(1, 1, 1)

    super.super.draw(self)
end

return SimpleSaveMenu
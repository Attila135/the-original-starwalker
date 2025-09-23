local Choicebox, super = Class(Choicebox)

function Choicebox:draw()
    super.draw(self)
    love.graphics.setFont(self.font)
    if self.choices[1] then
        Draw.setColor(self.main_colors[1])
        if self.current_choice == 1 then Draw.setColor(self.hover_colors[1]) end
        love.graphics.print(self.choices[1], 36, 24)
    end
    if self.choices[2] then
        Draw.setColor(self.main_colors[2])
        if self.current_choice == 2 then Draw.setColor(self.hover_colors[2]) end
        love.graphics.print(self.choices[2], 528 - self.font:getWidth(self.choices[2]), 24)
    end
    if self.choices[3] then
        Draw.setColor(self.main_colors[3])
        if self.current_choice == 3 then Draw.setColor(self.hover_colors[3]) end
        love.graphics.print(self.choices[3], 17 + Utils.round(self.width / 2) - Utils.round(self.font:getWidth(self.choices[3]) / 2), -8)
    end
    if self.choices[4] then
        Draw.setColor(self.main_colors[4])
        if self.current_choice == 4 then Draw.setColor(self.hover_colors[4]) end
        love.graphics.print(self.choices[4], 17 + Utils.round(self.width / 2) - Utils.round(self.font:getWidth(self.choices[4]) / 2), 78)
    end

    local soul_positions = {
        --[[ Center: ]] {224, 38},
        --[[ Left:   ]] {4,   34},
        --[[ Right:  ]] {528 - self.font:getWidth(self.choices[2] or "") - 32, 34},
        --[[ Top:    ]] {17 + Utils.round(self.width / 2) - Utils.round(self.font:getWidth(self.choices[3] or "") / 2) - 32, -8 + 6},
        --[[ Bottom: ]] {17 + Utils.round(self.width / 2) - Utils.round(self.font:getWidth(self.choices[4] or "") / 2) - 32, 78 + 6}
    }

    local heart_x = soul_positions[self.current_choice + 1][1]
    local heart_y = soul_positions[self.current_choice + 1][2]
    local rotation = (Game:getSoulRotation())
	
    Draw.setColor(Game:getSoulColor())
    Draw.draw(self.heart, heart_x, heart_y, rotation, 2, 2)
end

return Choicebox
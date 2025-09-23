local TextChoicebox, super = Class(TextChoicebox)

function TextChoicebox:draw()
    super.draw(self)
    if not self.text:isTyping() then
        local x = 122 + (self.current_choice - 1) * 192
        local y = 76
		local r = (Game:getSoulRotation())
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart, x, y, r, 2, 2)
        Draw.setColor(1, 1, 1)
    end
end

return TextChoicebox
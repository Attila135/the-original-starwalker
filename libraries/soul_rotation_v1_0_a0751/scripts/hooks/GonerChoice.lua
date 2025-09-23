local GonerChoice, super = Class(GonerChoice)

function GonerChoice:init(x, y, choices, on_complete, on_select)
    super.super.init(self, x, y)

    self.choices = choices or {
        {{"YES",0,0},{"NO",80,0}}
    }

    self.on_select = on_select
    self.on_cancel = nil
    self.on_hover = nil
    self.on_complete = on_complete

    self.choice = nil
    self.choice_x = nil
    self.choice_y = nil

    self.done = false

    -- FADEIN, CHOICE, FADEOUT
    self.state = "FADEIN"

    self.alpha = 0

    self.font = Assets.getFont("main")

    self.soul = Sprite("player/heart_blur")
    self.soul:setScale(2, 2)
    self.soul:setColor(Kristal.getSoulColor())
    self.soul:setRotationOrigin(1.0, 1.0)
	self.soul.rotation = Game:getSoulRotation()
	if Kristal.getState() ~= Game and MainMenu.mod_list:getSelectedMod().soulColor then
		self.soul:setColor(unpack(MainMenu.mod_list:getSelectedMod().soulColor))
	end
    self.soul.alpha = 0.6
    self.soul.inherit_color = true
    self:addChild(self.soul)

    self.wrap_x = false
    self.wrap_y = false

    self.teleport = false
    self.cancel_repeat = false

    self.selected_x = 1
    self.selected_y = 1

    self.soul_offset_x = 0
    self.soul_offset_y = 0

    self.soul_target_x = 0
    self.soul_target_y = 0

    self.soul_align = "center"
    self.soul_speed = 0.3

    self:clampSelection()
    self:resetSize()
    self:resetSoulPosition()
end

return GonerChoice

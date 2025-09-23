local ActionBox, super = Class("ActionBox", true)

function ActionBox:init(...)
    super.init(self, ...)
    self.kr_sprite = Sprite("ui/kr", 188, 22)
    self.box:addChild(self.kr_sprite)
    self.kr_sprite.visible = false
end

function ActionBox:update()
    super.update(self)
    self.kr_sprite.y = 22 - self.data_offset
    local use = Game.battle.encounter.use_karma
    if use and (Kristal.getLibConfig("karma", "kr_display") == "text") then
        self.kr_sprite.visible = true
        if type(use) == "table" and not use[self.battler.chara.id] then
            self.kr_sprite.visible = false
        end
    else
        self.kr_sprite.visible = false
    end
end

return ActionBox
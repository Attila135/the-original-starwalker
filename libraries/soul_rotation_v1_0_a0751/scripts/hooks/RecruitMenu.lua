---@class RecruitMenu : RecruitMenu
---@overload fun(...) : RecruitMenu
local RecruitMenu, super = Class(RecruitMenu)

function RecruitMenu:init()
    super.super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self:setParallax(0, 0)

    self.draw_children_below = 0

    self.font = Assets.getFont("main")
    self.description_font = Assets.getFont("plain")

    self.heart = Sprite("player/heart", 58, 114)
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setColor(Game:getSoulColor())
	self.heart.rotation = Game:getSoulRotation()
    self.heart.layer = 100
    self:addChild(self.heart)

    self.arrow_left = Assets.getTexture("ui/flat_arrow_left")
    self.arrow_right = Assets.getTexture("ui/flat_arrow_right")

    self.recruits = Game:getRecruits(true)

    self.state = "SELECT"

    self.selected = 1
    self.selected_page = 1
    self.old_selection = self.selected

    self.recruit_box = Sprite("ui/menu/recruit/gradient_bright", 370, 75)
    self:addChild(self.recruit_box)

    self:setRecruitInBox(self.selected)
end

return RecruitMenu

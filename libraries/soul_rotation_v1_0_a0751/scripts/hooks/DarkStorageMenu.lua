---@class DarkStorageMenu : DarkStorageMenu
---@overload fun(...) : DarkStorageMenu
local DarkStorageMenu, super = Class(DarkStorageMenu)

function DarkStorageMenu:init(top_storage, bottom_storage)
    super.super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self:setParallax(0, 0)

    self.draw_children_below = 0

    self.font = Assets.getFont("plain")

    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")

    self.arrow_left = Assets.getTexture("ui/flat_arrow_left")
    self.arrow_right = Assets.getTexture("ui/flat_arrow_right")

    self.heart = Sprite("player/heart_menu")
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setColor(Game:getSoulColor())
	self.heart.rotation = Game:getSoulRotation()
    self.heart.layer = 100
    self:addChild(self.heart)

    self.description_box = Rectangle(0, 0, SCREEN_WIDTH, 121)
    self.description_box:setColor(0, 0, 0)
    self:addChild(self.description_box)

    self.description = Text("---", 20, 20, SCREEN_WIDTH - 20, 100)
    self.description_box:addChild(self.description)

    -- SELECT, SWAP
    self.state = "SELECT"

    self.list = 1

    self.storages = {top_storage or "items", bottom_storage or "storage"}

    self.selected_x = {1, 1}
    self.selected_y = {1, 1}
    self.selected_page = {1, 1}

    self.text_x = {155, 155}
    self.text_y = {144, 294}

    self.arrow_y = {188, 340}

    self.heart_target_x = self.text_x[1] - 10.5
    self.heart_target_y = self.text_y[1] + 8.5
    self.heart:setPosition(self.heart_target_x, self.heart_target_y)
end

return DarkStorageMenu
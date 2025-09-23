local GameOver, super = Class(GameOver)

function GameOver:init(x, y)
    super.super.init(self, 0, 0)

    self.font = Assets.getFont("main")
    self.soul_blur = Assets.getTexture("player/heart_blur")

    if not Game:isLight() then
        self.screenshot = love.graphics.newImage(SCREEN_CANVAS:newImageData())
    end

    self.music = Music()

    self.soul = Sprite("player/heart")
    self.soul:setOrigin(0.5, 0.5)
    self.soul:setRotationOrigin(0.5, 0.5)
	self.soul.rotation = Game:getSoulRotation()
    self.soul:setColor(Game:getSoulColor())
    self.soul.x = x
    self.soul.y = y

    self:addChild(self.soul)

    self.current_stage = 0
    self.fader_alpha = 0
    self.skipping = 0
    self.fade_white = false

    self.timer = 0

    if Game:isLight() then
        self.timer = 28 -- We only wanna show one frame if we're in Undertale mode
    end
end

return GameOver
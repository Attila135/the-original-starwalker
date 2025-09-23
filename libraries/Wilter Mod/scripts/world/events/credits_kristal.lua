local Eyespawner, super = Class(Event)

function Eyespawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)

    self.logo = love.graphics.newImage("assets/sprites/kristal/title_logo.png")

    self.w = self.logo:getWidth()
    self.h = self.logo:getHeight()

    self.font = love.graphics.newFont("assets/fonts/main.ttf", 32)

    self.siner = 0
    self.factor = 1
    self.factor2 = 0
    self.animation_phase = 0
    self.animation_phase_timer = 0
    self.animation_phase_plus = 0
    self.logo_alpha = 0
    self.logo_alpha_2 = 1
    self.skipped = false
    self.skiptimer = 0
    self.key_check = not Kristal.Args["wait"]

    self.fader_alpha = 0

    self.text_y = 240
    self.text_y2 = 280
    self.text_y_move = 5

    self.animation_phase = 0
end

function Eyespawner:drawScissor(image, left, top, width, height, x, y, alpha)
    love.graphics.push()

    local scissor_x = ((math.floor(x) >= 0) and math.floor(x) or 0)
    local scissor_y = ((math.floor(y) >= 0) and math.floor(y) or 0)
    love.graphics.setScissor(scissor_x, scissor_y, width, height)

    Draw.setColor(1, 1, 1, alpha)
    Draw.draw(image, math.floor(x) - left, math.floor(y) - top)
    Draw.setColor(1, 1, 1, 1)
    love.graphics.setScissor()
    love.graphics.pop()
end

function Eyespawner:drawSprite(image, x, y, alpha)
    love.graphics.push()
    love.graphics.setScissor()

    Draw.setColor(1, 1, 1, alpha)
    Draw.draw(image, math.floor(x), math.floor(y), 0, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
    Draw.setColor(1, 1, 1, 1)
    love.graphics.pop()
end

function Eyespawner:draw()

    local dt_mult = DT * 15

    love.graphics.setFont(self.font)

    -- We need to draw the logo on a canvas
    local logo_canvas = Draw.pushCanvas(320, 240)
    love.graphics.clear()

    love.graphics.print({{1, 1, 0, 1},"MADE"}, 40, 30)
    love.graphics.print({{1, 1, 0, 1},"IN"}, 120, 30)

    if (self.animation_phase == 1) then
        self.siner = self.siner + 1 * dt_mult
        self.factor = self.factor - (0.003 + (self.siner / 900)) * dt_mult
        if (self.factor < 0) then
            self.factor = 0
            self.animation_phase = 2
            self.siner = 0
        end
        for i = 0, self.h - 1 do
            self.ia = ((self.siner / 25) - (math.abs((i - (self.h / 2))) * 0.05))
            self.xoff = ((40 * math.sin(((self.siner / 5) + (i / 3)))) * self.factor)
            self.xoff2 = ((40 * math.sin((((self.siner / 5) + (i / 3)) + 0.6))) * self.factor)
            self.xoff3 = ((40 * math.sin((((self.siner / 5) + (i / 3)) + 1.2))) * self.factor)
            self:drawScissor(self.logo, 0, i, self.w, 2, (self.xoff)+15, (70 + i), ((1 - self.factor) / 2))
            self:drawScissor(self.logo, 0, i, self.w, 2, (self.xoff2)+15, (70 + i), ((1 - self.factor) / 2))
            self:drawScissor(self.logo, 0, i, self.w, 2, (self.xoff3)+15, (70 + i), ((1 - self.factor) / 2))
        end
    end
    if (self.animation_phase == 2) then  
        self:drawSprite(self.logo, (self.w / 2)+15, 70+(self.h / 2), 1)

        self.siner = self.siner + DT
        if self.siner >= 0.5 then
            self.siner = 0
        end
    end

    Draw.popCanvas()

    -- Draw the canvas on the screen scaled by 2x
    Draw.setColor(1, 1, 1, 1)
    Draw.draw(logo_canvas, 0, 0, 0, 2, 2)
end

return Eyespawner
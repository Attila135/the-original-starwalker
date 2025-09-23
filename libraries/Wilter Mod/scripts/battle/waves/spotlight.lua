local Dark, super = Class(Wave)
function Dark:init(alpha)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.alpha = 0
    self.overlap = Kristal.getLibConfig("darkness", "overlap")

    self.time = 15
    -- self.layer = BATTLE_LAYERS["soul"]
    --self.layer = BATTLE_LAYERS["above_arena"]
end

function Dark:onStart()
    --Purplesoul
    Game.battle:swapSoul(PurpleSoulSkerch())
    --Bullets
    self.timer:every(0.6, function()
        local x = Game.battle.arena.x +
        love.math.random(Game.battle.arena.width, SCREEN_WIDTH / 2 - 200) * Utils.randomSign()
        local y = SCREEN_HEIGHT

        local bullet = self:spawnBullet("flower_bomb", x, y)
        bullet.layer = BATTLE_LAYERS["soul"] - 1
        local angle = Utils.random(math.pi * 2)
        self.timer:after(bullet.time, function()
            local petals = {}
            for i = 1, 8 do 
                local petal = self:spawnBullet("pellet", bullet.x, bullet.y, angle + i * math.pi / 4, 6*Game:getFlag("bul_speed"))
                petal.layer = BATTLE_LAYERS["soul"] - 1

                petal:setScale(1.5, 1.5)
                table.insert(petals, petal)
            end
            Assets.playSound("bomb", 0.8)
            self.timer:after(0.7, function()
                bullet.sprite:remove()
            end)
            self.timer:after(0.7, function()
                bullet:remove()
          end)

        end)
    end)

    Game.stage.timer:tween(0.75, self, { alpha = 1 }, "linear")
    self.timer:after(14, function()
        Game.stage.timer:tween(0.25, self, { alpha = 0 }, "linear")
    end)
end

function Dark:draw()
    --LightSource
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1 - self.alpha, 1 - self.alpha, 1 - self.alpha)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    if self.overlap then
        love.graphics.setBlendMode("add")
    else
        love.graphics.setBlendMode("lighten", "premultiplied")
    end
    local soul = Game.battle.soul
    if soul:isFullyVisible() then
        local x, y = soul:getRelativePos(0, 0, self)
        local color = { 160, 32, 240 }
        local alpha = 1
        local radius = 100
        love.graphics.setColor(Utils.lerp({ 0, 0, 0 }, color, alpha))
        love.graphics.circle("fill", x, y, radius)
    end

    love.graphics.setBlendMode("alpha")
    Draw.popCanvas()

    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
end

return Dark

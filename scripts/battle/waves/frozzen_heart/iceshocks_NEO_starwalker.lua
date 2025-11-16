local IceShocks, super = Class(Wave)

function IceShocks:init()
    super.init(self)
    self.time=10
end

function IceShocks:onStart()
    self.use_karma = true
    self.double = #Game.battle.waves==2
    self.timer:every(self.double and 1.05 or 0.75, function()
        local x, y
        repeat
            x = Utils.random(30, SCREEN_WIDTH-30)
        until (x<Game.battle.arena.left or x>Game.battle.arena.right)
        repeat
            y = Utils.random(30, SCREEN_HEIGHT-30)
        until (y<Game.battle.arena.top or y>Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("secret/iceshock", x, y)
    end)
    self.noelle = Sprite("bullets/noelle/idle_1", 588, 159)
    self.noelle:setAnimation({"bullets/noelle/idle", 0.2, true})
        self.noelle:setOrigin(0.5, 0.5)
        self.noelle.scale_y = 2
        self.noelle.scale_x = 2
        self.noelle.alpha = 0
        self.noelle.layer=BATTLE_LAYERS["top"]+15
        Game.battle:addChild(self.noelle)

        self.timer:after(14, function()
            self.noelle:fadeOutAndRemove(1)
        end)
    -- Every 0.5 seconds...
    self.time = 15

    self.timer:every(0.9, function()
        ice = self:spawnBullet("ice_shock", x, y, angle, 0)
        ice:setScale(20)
    end)
end

function IceShocks:update()
    -- Code here gets called every frame

    super.update(self)
end

return IceShocks
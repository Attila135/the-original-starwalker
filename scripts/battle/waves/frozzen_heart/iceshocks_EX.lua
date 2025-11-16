local Iceshocks_EX, super = Class(Wave)

function Iceshocks_EX:init()
    super.init(self)
    self.time=5
end

function Iceshocks_EX:onStart()
    -- Every 0.5 seconds...
    self.time = 5
    self.aim = false
    
    self.noelle = Sprite("bullets/noelle/idle", 588, 159)
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

    self.timer:every(0.05, function()
        ice = self:spawnBullet("ice_shock", x, y, angle, 0)
        ice:setScale(20)
        ice.inv_timer = 1/5
    end)
end

function Iceshocks_EX:update()
    -- Code here gets called every frame

    super.update(self)
end

return Iceshocks_EX
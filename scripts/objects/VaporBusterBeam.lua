---@class VaporBusterBeam : Sprite
---@overload fun(...) : VaporBusterBeam
local VaporBusterBeam, super = Class(Sprite)

function VaporBusterBeam:init(a1, a2, a3, a4, a5, a6)
    -- Support two call signatures:
    -- 1) VaporBusterBeam(x, y, tx, ty, after)
    -- 2) VaporBusterBeam(flag, x, y, tx, ty, after)
    local x, y, tx, ty, after
    if type(a1) == "boolean" then
        x = a2
        y = a3
        tx = a4
        ty = a5
        after = a6
    else
        x = a1
        y = a2
        tx = a3
        ty = a4
        after = a5
    end

    super.init(self, "effects/vaporbuster/beam", x, y)

    self:setOrigin(0.5, 0.5)
    self:setScale(2)

    self:play(1/30, true)

    self.target_x = tx
    self.target_y = ty

    self.rotation = Utils.angle(x, y, tx, ty) + math.rad(20)
    self.physics.speed = 24
    self.physics.friction = -1.5
    self.physics.match_rotation = true

    self.alpha = 0

    self.pressed = false

    self.afterimg_timer = 0
    if type(after) == "function" then
        self.after_func = after
    else
        self.after_func = nil
    end
end

function VaporBusterBeam:update()
    self.alpha = Utils.approach(self.alpha, 1, 0.25 * DTMULT)

    local dir = Utils.angle(self.x, self.y, self.target_x, self.target_y)
    self.rotation = self.rotation + (Utils.angleDiff(dir, self.rotation) / 4) * DTMULT

    if Input.pressed("confirm") then
        self.pressed = true
    end

    if Utils.dist(self.x, self.y, self.target_x, self.target_y) <= 40 then
        if type(self.after_func) == "function" then
                local damage_bonus = self.pressed and 0 or nil
                local play_sound = self.pressed and true or false
                self.after_func(damage_bonus, play_sound)
            end
        Assets.playSound("Rudebuster_hit")
        for i = 1, 8 do
            local burst = VaporBusterBurst(self.target_x, self.target_y, math.rad(45 + ((i - 1) * 90)), i > 4)
            burst.layer = self.layer + (0.01 * i)
            self.parent:addChild(burst)
        end
        self:remove()
        return
    end

    self.afterimg_timer = self.afterimg_timer + DTMULT
    if self.afterimg_timer >= 1 then
        self.afterimg_timer = 0

        local sprite = Sprite("effects/vaporbuster/beam", self.x, self.y)
        sprite:fadeOutSpeedAndRemove()
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(2, 1.8)
        sprite.rotation = self.rotation
        sprite.alpha = self.alpha - 0.2
        sprite.layer = self.layer - 0.01
        sprite.graphics.grow_y = -0.1
        sprite.graphics.remove_shrunk = true
        sprite:play(1/15, true)
        self.parent:addChild(sprite)
    end

    super.update(self)
end

return VaporBusterBeam
local spell, super = Class(Spell, "vapor_buster")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Vapor Buster"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    if Game.chapter <= 3 then
        self.effect = "Vapor\nDamage"
    else
        self.effect = "Vapor\ndamage"
    end
    -- Menu description
    self.description = "Deals large Vapor-elemental damage to\none foe. Depends on Attack & Magic."

    -- TP cost
    self.cost = 55

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = { "Vapor", "damage" }
end

function spell:getCastMessage(user, target)
    return "* " .. user.chara:getName() .. " used " .. self:getCastName() .. "!"
end

function spell:onCast(user, target)
    local buster_finished = false
    local anim_finished = false
    local function finishAnim()
        anim_finished = true
        if buster_finished then
            Game.battle:finishAction()
        end
    end
    if not user:setAnimation("battle/rude_buster", finishAnim) then
        anim_finished = false
        user:setAnimation("battle/attack", finishAnim)
    end
    Game.battle.timer:after(15 / 30, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height / 2 - 10, Game.battle)
        local tx, ty = target:getRelativePos(target.width / 2, target.height / 2, Game.battle)
        local blast = VaporBusterBeam(true, x, y, tx, ty, function(damage_bonus, play_sound)
            local damage = self:getDamage(user, target, damage_bonus)
            if play_sound then
                Assets.playSound("scytheburst")
            end
            local flash = target:flash()
            flash.color_mask:setColor(1, 0, 0)
            target:hurt(damage, user)
            buster_finished = true
            if anim_finished then
                Game.battle:finishAction()
            end
        end)
        blast.layer = BATTLE_LAYERS["above_ui"]
        Game.battle:addChild(blast)

        Game.battle.timer:after(15 / 30, function()
            Assets.playSound("rudebuster_swing")
            local x, y = user:getRelativePos(user.width, user.height / 2 - 10, Game.battle)
            local tx, ty = target:getRelativePos(target.width / 2, target.height / 2, Game.battle)
            local blast = VaporBusterBeam(true, x, y, tx, ty, function(damage_bonus, play_sound)
                local damage = self:getDamage(user, target, damage_bonus)
                if play_sound then
                    Assets.playSound("scytheburst")
                end
                local flash = target:flash()
                flash.color_mask:setColor(0, 0, 1)
                target:hurt(damage, user)
                buster_finished = true
                if anim_finished then
                    Game.battle:finishAction()
                end
            end)
            blast.layer = BATTLE_LAYERS["above_ui"]
            Game.battle:addChild(blast)
        end)
        return false
    end)
end

function spell:getDamage(user, target, damage_bonus)
    -- Ensure damage_bonus is numeric or nil (some call sites may pass a boolean)
    if type(damage_bonus) == "boolean" then
        if damage_bonus then
            damage_bonus = 0
        else
            damage_bonus = nil
        end
    end

    local damage = math.ceil((user.chara:getStat("magic") * 5) + (user.chara:getStat("attack") * 11) -
    (target.defense * 3))
    if damage_bonus then
        damage = damage + 30 + damage_bonus
    end
    return damage
end

return spell

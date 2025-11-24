local spell, super = Class(Spell, "mercygrant")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "MercyGrant"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Pacify\n& Heal"
    -- Menu description
    self.description = "Grant MERCY to a tired enemy and heal yourself."

    -- TP cost
    self.cost = 20

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"spare_tired", "heal"}
end

function spell:getCastMessage(user, target)
    local message = super.getCastMessage(self, user, target)
    if target.tired then
        return "* Watercooler grant MERCY to the foe! [wait:0.25s]\n * It was effective!"
    elseif target.mercy < 100 then
        return "* Watercooler grant MERCY to the foe, [wait:0.25s]but the enemy wasn't [color:blue]TIRED[color:reset]..."
    else
        return "* Watercooler grant MERCY to the foe, [wait:0.25s]but the enemy wasn't [color:blue]TIRED[color:reset]... [wait:0.25s]\n try [color:yellow]SPARING[color:reset]!"
    end
end

function spell:onCast(user, target)
    if target.tired then
        Assets.playSound("spell_pacify")
        target:spare(true)

        local base_heal = user.chara:getStat("magic") * 3
        local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara)
        user:heal(heal_amount)
    else
        local recolor = target:addFX(RecolorFX())
        Game.battle.timer:during(8/30, function()
            recolor.color = Utils.lerp(recolor.color, {1, 1, 0}, 0.12 * DTMULT)
        end, function()
            Game.battle.timer:during(8/30, function()
                recolor.color = Utils.lerp(recolor.color, {1, 1, 1}, 0.16 * DTMULT)
            end, function()
                target:removeFX(recolor)
            end)
        end)
    end
end

return spell
local spell, super = Class(Spell, "weedkiller")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Weed Killer"
    -- Name displayed when cast (optional)
    self.cast_name = "WEED KILLER"

    -- Battle description
    self.effect = "Hurt Enemy\nand User."
    -- Menu description
    self.description = "Deals a load of damage to\nplant based enemies."

    -- TP cost
    self.cost = 65

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {}
end

function spell:onCast(user, target)
    local x, y = target:getRelativePos(target.width/2, target.height/2, Game.battle)

    local particles = {}
    Game.battle.timer:script(function(wait)
        wait(1/30)
        local vine1 = Game.battle:addChild(Sprite("bullets/world/vine_grow"), 68, 280)
        local vine2 = Game.battle:addChild(Sprite("bullets/world/vine_grow"), 460, 275)
        vine1:setLayer(BATTLE_LAYERS["above_battlers"])
        vine2:setLayer(BATTLE_LAYERS["above_battlers"])
        vine1:play(0.1, false)
        vine2:play(0.1, false)
        vine1:setScale(2)
        vine2:setScale(2)
        vine1:setPosition(44, 198)
        vine2:setPosition(426, 200)
        --vine1:setOrigin(0.5, 1)
        --vine2:setOrigin(0.5, 1)
        wait(0.4)
        Assets.playSound("heavydamage")
        target:hurt(70*user.chara:getStat("magic")+love.math.random(-5, 7))
        user:hurt(43+love.math.random(-3, 5), true)
        user:shake()
        wait(0.3)
        vine1:setAnimation({"bullets/world/vine_shrink", 0.1, false})
        vine2:setAnimation({"bullets/world/vine_shrink", 0.1, false})
        wait(0.6)
        vine1:remove()
        vine2:remove()
        Game.battle:finishActionBy(user)
    end)
    return false
end

return spell

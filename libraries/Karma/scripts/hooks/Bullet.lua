local Bullet, super = Class("Bullet", true)

function Bullet:init(...)
    super.init(self, ...)
    self.use_karma = nil -- can be overridden per bullet
    self.karma_damage = Game.battle.encounter.karma_damage
    self.karma_decay = 1
end

function Bullet:onAdd(...)
    super.onAdd(self, ...)
    self._orig_destroy_on_hit = self.destroy_on_hit
end

function Bullet:onCollide(soul)
    if (Game.battle.encounter.use_karma and self.use_karma ~= false) or self.use_karma then
        self.destroy_on_hit = false
    else
        self.destroy_on_hit = self._orig_destroy_on_hit
    end
    return super.onCollide(self, soul)
end

function Bullet:onDamage(soul)
    if not Game.battle.encounter.use_karma or self.use_karma == false then
        return super.onDamage(self, soul)
    end
    
    local targets = Game.battle:getKarmaTargets()
    local spread = Kristal.getLibConfig("karma", "kr_spread")
    for _,target in ipairs(targets) do
        if spread == "full" then
            Game.battle:applyKarma(target, self:getKarma()*DTMULT)
        else
            Game.battle:applyKarma(target, self:getKarma()*DTMULT/#targets)
        end
    end
    if self.karma_decay > 0 then
        self.karma_damage = Utils.approach(self.karma_damage, 1, self.karma_decay*DTMULT)
    end
    -- we aren't dealing karma damage to anyone, but the battle is still going...
    -- which means there must be remaining party members which can't be affected by karma
    -- under this situation, force the bullet to be a regular bullet again
    if #targets == 0 then
        self.use_karma = false
        self.destroy_on_hit = self._orig_destroy_on_hit
    end
    return targets
end

function Bullet:getKarma()
    return self.karma_damage
end

return Bullet
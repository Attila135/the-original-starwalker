local Bullet, super = Class("Bullet", true)

function Bullet:init(...)
    super.init(self, ...)
    self.use_karma = false -- can be overridden per bullet
    self.karma_damage = Game.battle.encounter.karma_damage
    self.karma_decay = 1
end

function Battle:getKarmaTargets()
    local targets = {}
    if not self.encounter or not self.encounter.use_karma then return targets end
    for _,party in ipairs(self.party) do
        if type(self.encounter.use_karma) == "boolean" or self.encounter.use_karma[party.chara.id] then
            table.insert(targets, party)
        end
    end
    return targets
end

function Battle:applyKarma(battler, amount)
    local chara = battler.chara
    local max = math.min(chara.max_karma, chara.health - 1)
    if self.karma_hp_timer == 0 then
        Assets.playSound("hurt")
        chara.health = Utils.approach(chara.health, 0, 1)
        self.karma_hp_timer = 1/30
    end
    if chara.karma < max then
        chara.karma = Utils.approach(chara.karma, max, amount)
    end
    chara.karma = math.min(chara.karma, chara.health - 1)
    battler:checkHealth()
end

function Bullet:onCollide(soul)
    if not Game.battle.encounter.use_karma and not self.use_karma then
        return super.onCollide(self, soul)
    end
    local style = Kristal.getLibConfig("karma", "damage_style")
    if style == "all" or style == "all_full" then
        local targets = Game.battle:getKarmaTargets()
        for _,target in ipairs(targets) do
            if style == "all_full" then
                Game.battle:applyKarma(target, self:getKarma()*DTMULT)
            else
                Game.battle:applyKarma(target, self:getKarma()*DTMULT/#targets)
            end
        end
    else
        Game.battle:applyKarma(Game.battle.kr_target, self:getKarma()*DTMULT)
    end
    if self.karma_decay > 0 then
        self.karma_damage = Utils.approach(self.karma_damage, 1, self.karma_decay*DTMULT)
    end
end

function Bullet:getKarma()
    return self.karma_damage
end

return Bullet
local spell, super = Class(Spell, "vaporizer")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Vaporizer"

    -- Battle description
    self.effect = "Vapor\nDamage"
    -- Menu description
    self.description = "Deals large vapor damage to 1 enemy."
    -- Check description
    self.check = "Deals large vapor damage to 1 enemy."

    -- TP cost
    self.cost = 40

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"Damage"}
end

function spell:getCastMessage(user, target)
    return "* Watercooler used "..self:getCastName().."!"
end

function spell:onCast(user, target)
	local damage = math.floor((((user.chara:getStat("attack") * 140) / 20) - 3 * (target.defense)) * 1.35)

	---@type XSlashSpell
	local spellobj = VaporBusterSpell(user,target)
	Game.battle:addChild(spellobj):setLayer(BATTLE_LAYERS["above_battlers"])

	spellobj.damage_callback = function(self, hit_action_command)
		local strikedmg = damage
		target:hurt(strikedmg, user)
	end
    return false
end

return spell
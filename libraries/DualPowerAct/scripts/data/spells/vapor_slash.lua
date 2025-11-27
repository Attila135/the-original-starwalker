local spell, super = Class(Spell, "vapor_slash")

function spell:init()
	super.init(self)

	-- Display name
	self.name = "Vapor Slash"
	-- Name displayed when cast (optional)
	self.cast_name = nil
	-- Battle description
	self.effect = "Physical\nVapor\nDamage"
	-- Menu description
	self.description = "Deals large physical and Vapor damage to 1 enemy."
	-- TP cost
	self.cost = 55
	-- Target mode (ally, party, enemy, enemies, or none)
	self.target = "enemy"
	-- Tags that apply to this spell
	self.tags = { "damage" }
end

function spell:getCastMessage(user, target)
	return "* " .. user.chara:getName() .. " used " .. self:getCastName() .. "!"
end

function spell:onStart(user, target, immediate, message)
	if not immediate then
		Game.battle:battleText(message or self:getCastMessage(user, target))
		user:setAnimation("battle/spell", function()
			Game.battle:clearActionIcon(user)
			local result = self:onCast(user, target, immediate)
			if result or result == nil then
				Game.battle:finishActionBy(user)
			end
		end)
	else
		Game.battle:finishActionBy(user)
		user:setAnimation("battle/spell", function()
			Game.battle:clearActionIcon(user)
			self:onCast(user, target, immediate)
		end)
	end
end

function spell:onCast(user, target, immediate)
	if user.chara.id == "watercooler" then
		local damage = math.floor((((user.chara:getStat("attack") * 150) / 20) - 3 * (target.defense)) * 1.3)
		local function generateSlash(scale_x)
			local cutAnim = Sprite("effects/attack/cut")
			Assets.playSound("scytheburst")
			Assets.playSound("criticalswing", 1.2, 1.3)
			local afterimage1 = AfterImage(user, 0.5)
			local afterimage2 = AfterImage(user, 0.6)
			afterimage1.physics.speed_x = 2.5
			afterimage2.physics.speed_x = 5
			afterimage2:setLayer(afterimage1.layer - 1)
			user:setAnimation("battle/attack", function()
				user:setAnimation("battle/idle")
			end)
			cutAnim:setOrigin(0.5, 0.5)
			cutAnim:setScale(2.5 * scale_x, 2.5)
			cutAnim:setPosition(target:getRelativePos(target.width / 2, target.height / 2))
			cutAnim.layer = target.layer + 0.01
			cutAnim:play(1 / 15, false, function(s) s:remove() end)
			user.parent:addChild(cutAnim)
			user.parent:addChild(afterimage1)
			user.parent:addChild(afterimage2)
		end


		Game.battle.timer:after(0.1 / 2, function()
			generateSlash(1)
			target:hurt(damage)
			Game.battle.timer:after(1 / 2, function()
				generateSlash(-1)
				target:hurt(damage)
			end)
		end)
	else
		local damage = math.floor((((user.chara:getStat("attack") * 140) / 20) - 3 * (target.defense)) * 1.35)

		---@type XSlashSpell
		local spellobj = VaporBusterSpell(user, target)
		Game.battle:addChild(spellobj):setLayer(BATTLE_LAYERS["above_battlers"])

		spellobj.damage_callback = function(self, hit_action_command)
			local strikedmg = damage
			target:hurt(strikedmg, user)
		end
	end
	--return false
end

return spell

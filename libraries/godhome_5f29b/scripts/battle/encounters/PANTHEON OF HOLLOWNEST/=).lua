local Dummy, super = Class("bossEncounter")

function Dummy:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text ="* Here they come!"

    -- Battle music ("battle" is rude buster)
    self.music ="battle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
	table.insert(self.bosses, self:addEnemy("p1/vengeflyking", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/gruzmother", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/falseknight", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/mosscharger", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/hornet", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/gorb", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/dungdefender", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/soulwarrior", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/broodingmawlek", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/mato", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/mato", 540, 220))
	table.insert(self.bosses, self:addEnemy("p1/oro", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/xero", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/crystalguardian", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/soulmaster", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/oblobble", 540, 220))
	table.insert(self.bosses, self:addEnemy("p5/sisterofbattle", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/marmu", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/flukemarm", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/brokenvessel", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/galien", 540, 220))
	table.insert(self.bosses, self:addEnemy("p2/sheo", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/hiveknight", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/elderhu", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/collector", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/godtamer", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/watcherknight", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/uumuu", 540, 220))
	table.insert(self.bosses, self:addEnemy("p5/wingednosk", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/sly", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/hornet2", 540, 220))
	table.insert(self.bosses, self:addEnemy("p5/kristalguardian", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/lostkin", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/noeyes", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/traitorlord", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/whitedefender", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/soultyrant", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/markoth", 540, 220))
	table.insert(self.bosses, self:addEnemy("p3/greyprince", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/failedchamp", 540, 220))
	table.insert(self.bosses, self:addEnemy("p5/nkg", 540, 220))
	table.insert(self.bosses, self:addEnemy("p4/purevessel", 540, 220))
	table.insert(self.bosses, self:addEnemy("p5/radiance", 540, 220))
end

function Dummy:createSoul(x, y, color)
	if Game.battle.party[1].chara.shock then
		return ShockSoul(x, y)
	end
    return Soul(x, y, color)
end

function Dummy:onBattleEnd()
	Game:setFlag("Result", Game:getFlag("kb", 0))
	if Game:getFlag("kb", 0) > 0 then
		Game.world.map:getEvent(15):remove()
		Game.world.map:getEvent(16):remove()
	end
	if Game:getFlag("kb", 0) == 7 then
		Game.world.map:getEvent(17):remove()
	end
end

return Dummy
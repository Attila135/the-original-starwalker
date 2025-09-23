local Dummy, super = Class(GroupEncounter)

function Dummy:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "*  IT`S WORKN`T!!!!!!!!!!!!!!"

    -- Battle music ("battle" is rude buster)
    self.music = nil
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
	self:addGroup({ "p1/vengeflyking", "p1/vengeflyking" }, "Text")
	
	self:addGroup({ "p1/gruzmother" }, "Text")
	self:addGroup({ "p1/falseknight" }, "Text")
	self:addGroup({ "p1/mosscharger" }, "Text")
	self:addGroup({ "p1/hornet" }, "Text")
	self:addGroup({ "p1/gorb" }, "Text")
	self:addGroup({ "p1/dungdefender" }, "Text")
	self:addGroup({ "p1/soulwarrior" }, "Text")
	self:addGroup({ "p1/broodingmawlek" }, "Text")
	self:addGroup({ "p1/mato" }, "Text")
	self:addGroup({ "p1/mato", "p1/oro" }, "Text")
	self:addGroup({ "p2/xero" }, "Text")
	self:addGroup({ "p2/crystalguardian" }, "Text")
	self:addGroup({ "p2/soulmaster" }, "Text")
	self:addGroup({ "p2/oblobble", "p2/oblobble" }, "Text")
	self:addGroup({ "p5/sisterofbattle" }, "Text")
	self:addGroup({ "p2/marmu" }, "Text")
	self:addGroup({ "p2/flukemarm" }, "Text")
	self:addGroup({ "p2/brokenvessel" }, "Text")
	self:addGroup({ "p3/galien" }, "Text")
	self:addGroup({ "p2/sheo" }, "Text")
	self:addGroup({ "p3/hiveknight" }, "Text")
	self:addGroup({ "p3/elderhu" }, "Text")
	self:addGroup({ "p3/collector" }, "Text")
	self:addGroup({ "p3/godtamer" }, "Text")
	self:addGroup({ "p4/watcherknight", "p4/watcherknight", "p4/watcherknight", "p4/watcherknight", "p4/watcherknight", "p4/watcherknight", "p4/watcherknight", "p4/watcherknight", "p4/watcherknight" }, "Text")
	self:addGroup({ "p3/uumuu" }, "Text")
	self:addGroup({ "p5/wingednosk" }, "Text")
	self:addGroup({ "p3/sly" }, "Text")
	self:addGroup({ "p3/hornet2" }, "Text")
	self:addGroup({ "p5/kristalguardian" }, "Text")
	self:addGroup({ "p4/lostkin" }, "Text")
	self:addGroup({ "p4/noeyes" }, "Text")
	self:addGroup({ "p4/traitorlord" }, "Text")
	self:addGroup({ "p4/whitedefender" }, "Text")
	self:addGroup({ "p4/soultyrant" }, "Text")
	self:addGroup({ "p4/markoth" }, "Text")
	self:addGroup({ "p3/greyprince" }, "Text")
	self:addGroup({ "p4/failedchamp" }, "Text")
	self:addGroup({ "p5/nkg" }, "Text")
	self:addGroup({ "p4/purevessel" }, "Text")
	self:addGroup({ "p5/radiance" }, "Text")
	
	--self.battleback = "cave"
end

return Dummy
local MyEncounter, super = Class(Encounter)

function MyEncounter:init()
    super:init(self)
	
    local enemy = self:addEnemy("noelle")
	enemy.y = enemy.y + enemy.height * .5
	
    self.text = "* Two musicians struggle for\ncontrol!"
end

return MyEncounter
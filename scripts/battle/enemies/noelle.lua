local MyEnemy, super = Class(EnemyBattler)

function MyEnemy:init()
    super.init(self)
	
    self.name = ("Air")
    self:setActor("noelle_enemy")
	
    self.path = "enemies/noelle_enemy/dark"
    self.noelle = Sprite("enemies/noelle_enemy/dark/idle", 588, 159)
    self.noelle:setAnimation({"enemies/noelle_enemy/dark/idle", 0.2, true})
	
    self.max_health = 451
    self.health = 451
    self.attack = 1
    self.defense = 35
    self.money = 0
	
    self.waves = {
		"frozzen_heart/iceshocks_EX",
	}

  self.progress = 0

  function MyEnemy:onAct(battler, name)
   if name == "Standard" then
        self:addMercy(-10000)
        if battler.chara.id == "ralsei" then
            return "* Ralsei AAAAAAA"
        elseif battler.chara.id == "susie" then
            return "* Susie AAAAAAA"
        elseif battler.chara.id == "noelle" then
            return "* Noelle AAAAAAA"
        end
    end
    return super.onAct(self, battler, name)
end

function MyEnemy:onTurnEnd()
    self.progress = self.progress + 1
end

function MyEnemy:getNextWaves()

  if (self.progress == 0) then
        return {"lonewolf_parade/masktutwave"}
    end

    return super.getNextWaves(self)
end
	
	self.prev_wave = nil
end

return MyEnemy
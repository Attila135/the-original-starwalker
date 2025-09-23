local BG1, super = Class(Object)

function BG1:init()
  super.init(self)


  local background = Sprite("bg/bg_battle", 0, 0)
  local kris = Game.battle:getPartyBattler("kris")
  local susie = Game.battle:getPartyBattler("susie")
  local ralsei = Game.battle:getPartyBattler("ralsei")
  local wilter = Game.battle:getEnemyBattler("wilter")

  self:addChild(background) -- add it to the object\\
  background:setScale(2)

  background.layer = 1

  kris.layer = 2
  ralsei.layer = 2
  susie.layer = 2
  wilter.layer = 2


end

return BG1
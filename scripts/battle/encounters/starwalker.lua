local Starwalker, super = Class(Encounter)

function Starwalker:init()
    super.init(self)

    self.text = "* Star walker has      changed forms"

    local enemy = self:addEnemy("noelle")
    self.starwalker = self:addEnemy("starwalker", 530, 238)

    self.background = true

    self.no_end_message = false

    self.timer = 0

    -- music by nyako! give credit if used!  this music isn't by nyako but i'm just lazy to remuve it >:3
    local kris = Game.battle:getPartyBattler("kris")
    if kris then
        self.music = "battle"
    else
        self.music = "battle_vapor"
    end
    

    --self.default_xactions = false

    --Game.battle:registerXAction("susie", "Snap")
    --Game.battle:registerXAction("susie", "Supercharge", "Charge\nfaster", 80)
end

function Starwalker:update()
    super.update(self)

    for _,enemy in pairs(Game.battle.enemy_world_characters) do
        enemy:remove()
    end
end

function Starwalker:createSoul(x, y, color)
    if self.starwalker.blue then
        return BlueSoul(x, y)
    end
    return Soul(x, y, color)
end

return Starwalker
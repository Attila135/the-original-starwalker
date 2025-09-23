local item, super = Class("s_poison", true)

function item:init()
    super.init(self)

    

    -- Character reactions
    self.reactions = {
        susie = "Ugh! ...tastes good?",
        ralsei = "Ow... er, thanks, Kris!",
        noelle = "(I'll... just pretend to drink it...)",
        maskaught = "MRR~ THE SMOOTH TASTE OF..."
    }

    -- Amount the poison damages in the world
    self.world_poison_amount = 20

    -- Amount the poison heals in battle
    self.battle_heal_amount = 40
    -- Amount the poison damages in battle
    self.battle_poison_amount = 60
end

function item:onWorldUse(target)
    if target.id == "maskaught" then
        target:setHealth(math.max(1, target:getHealth() - 400))
        Assets.playSound("hurt")
        Game:setFlag("poisonmaskaught", true)
        return true
    end
    target:setHealth(math.max(1, target:getHealth() - self.world_poison_amount))
    Assets.playSound("hurt")
    return true
end

return item
local character, super = Class("ralsei", true)

function character:init()
    super.init(self)
    self.health = 129;
    self.max_stats = { health = 219 }
    self.stats = {
            health = 219,
            attack = 16,
            defense = 2,
            magic = 10
        }
   
   
end

return character
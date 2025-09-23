local character, super = Class("susie", true)

function character:init()
    super.init(self)
    self.health = 295;
    self.max_stats = { health = 194 }
    self.stats = {
            health = 194,
            attack = 19,
            defense = 2,
            magic = 4
        }
   
   
end

return character
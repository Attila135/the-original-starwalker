local character, super = Class("susie", true)

function character:init()
    super.init(self)

	self.soul_rotation = math.pi
end

return character
local character, super = Class("noelle", true)

function character:init()
    super.init(self)

	self.soul_rotation = math.pi
end

return character
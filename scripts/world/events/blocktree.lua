local blocktree, super = Class(Event)

function blocktree:init(data)
	super:init(self, data.x, data.y, data.width, data.height)

	--self:setOrigin(0.5, 0.5)
	self.sprites=Assets.getFramesOrTexture("world/events/blocktree/part")

	--self.man = Interactable(37.5, 74, 20, 10, {cutscene="overworld.man"})
	--print(self.man)
	--self:addChild(self.man)

	self.width = self.sprites[1]:getWidth()
	self.height = self.sprites[1]:getHeight()
	self:setOrigin(0.35, 0.8)
	self:setScale(2)

	self.siner = love.math.random(600)
	self.blocktimer = 0
	self.image_speed = 0
	self.spec = 0
	self.remlayer = self.layer
end

function blocktree:update()
	local oo = 0
	if (self.spec < 2) then
	    self.blocktimer = self.blocktimer + DTMULT
	end
	if (Utils.round(self.blocktimer) == 20) then
	    if not self.spawned_block then
		    local xv = (((self.width / 4)) + love.math.random((self.width / 2)))
		    local yv = (((self.height / 4)) + love.math.random((self.height / 4)))
		    self.block = Sprite("world/events/blocktree/block", xv, yv)
		    self.block.alpha = 0
		    self.block.physics = {
		        speed_y = (0.4 + love.math.random(1)),
		        speed_x = (0.7 + love.math.random(1.5)),
		        gravity_direction = 0,
		        gravity = 0.1,
		        friction = -0.1
		    }
		    self.block.layer = (self.layer - 1)
		    self:addChild(self.block)
		    self.spawned_block = true
		end
		self.block:setColor((Utils.mergeColor(COLORS["white"], COLORS["black"], oo)))
	    if (oo >= 0.8) then
	        self.block:remove()
	    end
	end
	if (self.blocktimer >= 20 and self.blocktimer <= 30) then
        if (self.block.alpha < 1) then
            self.block.alpha = self.block.alpha + 0.2*DTMULT
        end
	end
	if (self.blocktimer >= 38) then
	    self.block.alpha = self.block.alpha - 0.1*DTMULT
	end
	if (self.blocktimer >= 48) then
	    self.blocktimer = 0
	    self.spawned_block = false
	    self.block:remove()
	end

	super:update(self)
end

function blocktree:draw()
	self.siner=self.siner+DTMULT
	love.graphics.draw(self.sprites[2], 0, 0, 0)
    love.graphics.draw(self.sprites[3], (math.sin((self.siner / 12)) * 2), (math.cos((self.siner / 20)) * 2), 0)
    love.graphics.draw(self.sprites[4], (math.sin((self.siner / 14)) * 1), (math.cos((self.siner / 24)) * 1), 0)

    super:draw(self)
end

return blocktree
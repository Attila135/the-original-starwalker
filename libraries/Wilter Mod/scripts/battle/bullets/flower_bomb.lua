local Bomb, super = Class(Bullet)

function Bomb:init(x,y)
    super.init(self, x, y, "bullets/flower_bomb")
    self.sprite:play(0.2,false)
    self.tempo = Utils.random(1.2,1.7)
    self.physics.speed_y = -self.tempo*10

end

function Bomb:onAdd(parent)
    super.onAdd(self, parent)
    Game.stage.timer:tween(1.5, self.physics, {speed_y = 0})
    self.time = self.tempo
--[[ 
function Bomb:draw()
--local bomby = light:getRelativePos(bomby.width/8, bomby.height/8)
local light = LightSource()
    light:getRelativePos(20, 20)
    --    bomby:addChild(light)
            if light:isFullyVisible() then
                local x, y = light:getRelativePos(0,0, self)
                local color = Utils.copy({160,32,240})
                local alpha = 1
                local radius = 10
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
                love.graphics.circle("fill", x, y, radius)
            end
        end]]  
end
return Bomb
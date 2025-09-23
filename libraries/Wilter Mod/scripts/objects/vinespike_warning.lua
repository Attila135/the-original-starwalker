local Warning, super = Class(Object)

function Warning:init(x, y)
    super.init(self, x, y)

    local sprite = Sprite("bullets/vinespike_warning", 0, 0)
    sprite:setScale(2)
    sprite:setAnimation({"bullets/vinespike_warning", 1/10, true})
    self:addChild(sprite)
    Game.battle.waves[1].timer:after(0.75, function ()
        self:remove()
    end)

end

return Warning
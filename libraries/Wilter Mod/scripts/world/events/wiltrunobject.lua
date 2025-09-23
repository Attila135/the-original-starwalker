local Wiltspawner, super = Class(Event)

function Wiltspawner:init(data)
    super.init(self, data.x, data.y, data.width, data.height, data)
end

function Wiltspawner:initiateTimer()
    local wilt = Sprite("objects/wiltholder", self.x+self.width/2, self.y+self.height/2)
    wilt:setScale(0.01)
    wilt.alpha = 0.4
    wilt:setOrigin(0.5)
    wilt:setAnimation({"enemies/dummy/run/down", 1/10, true})
    Game.world:spawnObject(wilt)
    wilt.layer = 0.7
    Game.stage.timer:tween(90, wilt, {scale_x = self.width/130, scale_y = self.height/130}, "in-quad")
    Game.stage.timer:tween(90, wilt, {alpha = 0.7})
end

return Wiltspawner
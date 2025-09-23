return {
    shine = function(cutscene, battler, enemy)
        local en = Game.battle.enemies[1]
        en:addMercy(12)
        en:setSprite("hurt")
        en:shake()
        local shine = Game.battle:addChild(Sprite("objects/spotlight_tree", 460, 0))
        shine:setScale(0, 1)
        shine.alpha = 0
        shine:setOrigin(0.5, 0)
        shine:setLayer(BATTLE_LAYERS["above_battlers"])
        shine:setPosition(460, 0)
        Game.battle.timer:tween(0.5, shine, {scale_x=1, alpha=1}, "out-quad")
        cutscene:text("* You,[wait:5] Susie,[wait:5] And Ralsei,[wait:5] shine your light on Wilter[wait:5]\n* He seems...[wait:5] sad.")

        Game.battle.timer:tween(0.5, shine, {scale_x=0, alpha=0}, "in-quad")
        Game.battle.timer:after(0.5, function ()
            shine:remove()
            en:setAnimation("battle")
        end)
    end
}
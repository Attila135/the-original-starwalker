---@class Battle : Battle
---@overload fun(...) : Battle
local Battle, super = Utils.hookScript(Battle)


function Battle:dualPowerAct(spell, battler, users, target)
    local user_battlers = {}
    local user_indices = {}

    -- Get battlers and indices for both users
    for i, user in ipairs(users) do
        local user_battler = self:getPartyBattler(user)
        if user_battler == nil then
            Kristal.Console:error("Invalid power act user: " .. tostring(user))
            return
        end
        user_battlers[i] = user_battler
        user_indices[i] = self:getPartyIndex(user)
    end

    if type(spell) == "string" then
        spell = Registry.createSpell(spell)
    end

    local menu_item = {
        data = spell,
        tp = 0
    }

    if target == nil then
        if spell.target == "ally" then
            target = user_battlers[1]
        elseif spell.target == "party" then
            target = self.party
        elseif spell.target == "enemy" then
            target = self:getActiveEnemies()[1]
        elseif spell.target == "enemies" then
            target = self:getActiveEnemies()
        end
    end

    -- Create combined names string
    local names = {}
    for _, user_battler in ipairs(user_battlers) do
        local name = user_battler.chara:getName()
        if name == "Ralsei" then
            name = "RALSEI"
        end
        table.insert(names, name)
    end
    local names_str = table.concat(names, " and ")
    
    self:setActText("* Your soul shined its power on\n" .. names_str .. "!", true)

    self.timer:after(7/30, function()
        Assets.playSound("boost")
        battler:flash()
        -- Flash both users
        for _, user_battler in ipairs(user_battlers) do
            user_battler:flash()
        end

        -- Create soul shine effect
        local bx, by = self:getSoulLocation()
        local soul = Sprite("effects/soulshine", bx, by)
        soul:play(1/30, false, function() soul:remove() end)
        soul:setOrigin(0.25, 0.25)
        soul:setScale(2.5, 2.5) -- Slightly larger for dual effect
        self:addChild(soul)
    end)

    self.timer:after(24/30, function()
        -- Push actions for both users
        for i, user_index in ipairs(user_indices) do
            self:pushAction("SPELL", target, menu_item, user_index, {
                immediate = i ~= #user_indices,
                message = '* ' .. names_str .. ' cast\n' .. spell.name .. '!'
            })
        end
        self:markAsFinished(nil, users)
    end)
end

function Battle:processAction(action)
    local battler = self.party[action.character_id]
    local party_member = battler.chara
    local enemy = action.target

    self.current_processing_action = action

    local next_enemy = self:retargetEnemy()
    if not next_enemy then
        return true
    end

    if enemy and enemy.done_state then
        enemy = next_enemy
        action.target = next_enemy
    end

    -- Call mod callbacks for onBattleAction to either add new behaviour for an action or override existing behaviour
    -- Note: non-immediate actions require explicit "return false"!
    local callback_result = Kristal.modCall("onBattleAction", action, action.action, battler, enemy)
    if callback_result ~= nil then
        return callback_result
    end
    for lib_id,_ in Kristal.iterLibraries() do
        callback_result = Kristal.libCall(lib_id, "onBattleAction", action, action.action, battler, enemy)
        if callback_result ~= nil then
            return callback_result
        end
    end

    if action.action == "SPARE" then
        local worked = enemy:canSpare()

        battler:setAnimation("battle/spare", function()
            enemy:onMercy(battler)
            if not worked then
                enemy:mercyFlash()
            end
            self:finishAction(action)
        end)

        local text = enemy:getSpareText(battler, worked)
        if text then
            self:battleText(text)
        end

        return false

    elseif action.action == "ATTACK" or action.action == "AUTOATTACK" then
        local attacksound = battler.chara:getWeapon():getAttackSound(battler, enemy, action.points) or battler.chara:getAttackSound()
        local attackpitch  = battler.chara:getWeapon():getAttackPitch(battler, enemy, action.points) or battler.chara:getAttackPitch()
        local src = Assets.stopAndPlaySound(attacksound or "laz_c")
        src:setPitch(attackpitch or 1)

        self.actions_done_timer = 1.2

        local crit = action.points == 150 and action.action ~= "AUTOATTACK"
        if crit then
            Assets.stopAndPlaySound("criticalswing")

            for i = 1, 3 do
                local sx, sy = battler:getRelativePos(battler.width, 0)
                local sparkle = Sprite("effects/criticalswing/sparkle", sx + Utils.random(50), sy + 30 + Utils.random(30))
                sparkle:play(4/30, true)
                sparkle:setScale(2)
                sparkle.layer = BATTLE_LAYERS["above_battlers"]
                sparkle.physics.speed_x = Utils.random(2, 6)
                sparkle.physics.friction = -0.25
                sparkle:fadeOutSpeedAndRemove()
                self:addChild(sparkle)
            end
        end

        battler:setAnimation("battle/attack", function()
            action.icon = nil

            if action.target and action.target.done_state then
                enemy = self:retargetEnemy()
                action.target = enemy
                if not enemy then
                    self.cancel_attack = true
                    self:finishAction(action)
                    return
                end
            end

            local damage = Utils.round(enemy:getAttackDamage(action.damage or 0, battler, action.points or 0))
            if damage < 0 then
                damage = 0
            end

            if damage > 0 then
                Game:giveTension(Utils.round(enemy:getAttackTension(action.points or 100)))

                local attacksprite = battler.chara:getWeapon():getAttackSprite(battler, enemy, action.points) or battler.chara:getAttackSprite()
                local dmg_sprite = Sprite(attacksprite or "effects/attack/cut")
                dmg_sprite:setOrigin(0.5, 0.5)
                if crit then
                    dmg_sprite:setScale(2.5, 2.5)
                else
                    dmg_sprite:setScale(2, 2)
                end
                local relative_pos_x, relative_pos_y = enemy:getRelativePos(enemy.width/2, enemy.height/2)
                dmg_sprite:setPosition(relative_pos_x + enemy.dmg_sprite_offset[1], relative_pos_y + enemy.dmg_sprite_offset[2])
                dmg_sprite.layer = enemy.layer + 0.01
                dmg_sprite.battler_id = action.character_id or nil
                table.insert(enemy.dmg_sprites, dmg_sprite)
                local dmg_anim_speed = 1/15
                if attacksprite == "effects/attack/shard" then
                    -- Ugly hardcoding BlackShard animation speed accuracy for now
                    dmg_anim_speed = 1/10
                end
                dmg_sprite:play(dmg_anim_speed, false, function(s) s:remove(); Utils.removeFromTable(enemy.dmg_sprites, dmg_sprite) end) -- Remove itself and Remove the dmg_sprite from the enemy's dmg_sprite table when its removed
                enemy.parent:addChild(dmg_sprite)

                local sound = enemy:getDamageSound() or "damage"
                if sound and type(sound) == "string" then
                    Assets.stopAndPlaySound(sound)
                end
                enemy:hurt(damage, battler)

                -- TODO: Call this even if damage is 0, will be a breaking change
                battler.chara:onAttackHit(enemy, damage)
            else
                enemy:hurt(0, battler, nil, nil, nil, action.points ~= 0)
            end

            for _,item in ipairs(battler.chara:getEquipment()) do
                item:onAttackHit(battler, enemy, damage)
            end

            self:finishAction(action)

            Utils.removeFromTable(self.normal_attackers, battler)
            Utils.removeFromTable(self.auto_attackers, battler)

            if not self:retargetEnemy() then
                self.cancel_attack = true
            elseif #self.normal_attackers == 0 and #self.auto_attackers > 0 then
                local next_attacker = self.auto_attackers[1]

                local next_action = self:getActionBy(next_attacker, true)
                if next_action then
                    self:beginAction(next_action)
                    self:processAction(next_action)
                end
            end
        end)

        return false

    elseif action.action == "ACT" then
        -- fun fact: this would have only been a single function call
        -- if stupid multi-acts didn't exist

        -- Check for other short acts
        local self_short = false
        self.short_actions = {}
        for _,iaction in ipairs(self.current_actions) do
            if iaction.action == "ACT" then
                local ibattler = self.party[iaction.character_id]
                local ienemy = iaction.target

                if ienemy then
                    local act = ienemy and ienemy:getAct(iaction.name)

                    if (act and act.short) or (ienemy:getXAction(ibattler) == iaction.name and ienemy:isXActionShort(ibattler)) then
                        table.insert(self.short_actions, iaction)
                        if ibattler == battler then
                            self_short = true
                        end
                    end
                end
            end
        end

        if self_short and #self.short_actions > 1 then
            local short_text = {}
            for _,iaction in ipairs(self.short_actions) do
                local ibattler = self.party[iaction.character_id]
                local ienemy = iaction.target

                local act_text = ienemy:onShortAct(ibattler, iaction.name)
                if act_text then
                    table.insert(short_text, act_text)
                end
            end

            self:shortActText(short_text)
        else
            local text = enemy:onAct(battler, action.name)
            if text then
                self:setActText(text)
            end
        end

        return false

    elseif action.action == "SKIP" then
        return true
        
    elseif action.action == "SPELL" then
        self.battle_ui:clearEncounterText()

        -- The spell itself handles the animation and finishing
        action.data:onStart(battler, action.target, action.immediate, action.message)

        return false

    elseif action.action == "ITEM" then
        local item = action.data
        if item.instant then
            self:finishAction(action)
        else
            local text = item:getBattleText(battler, action.target)
            if text then
                self:battleText(text)
            end
            battler:setAnimation("battle/item", function()
                local result = item:onBattleUse(battler, action.target)
                if result or result == nil then
                    self:finishAction(action)
                end
            end)
        end
        return false

    elseif action.action == "DEFEND" then
        battler:setAnimation("battle/defend")
        battler.defending = true
        return false

    else
        -- we don't know how to handle this...
        Kristal.Console:warn("Unhandled battle action: " .. tostring(action.action))
        return true
    end
end

return Battle
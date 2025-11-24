local character, super = Class(PartyMember, "watercooler")

function character:init()
    super.init(self)

    -- Display name
    self.name = "W.Cooler"

    -- Actor (handles sprites)
    self:setActor("watercooler")

    -- Display level (saved to the save file)
    self.love = 1
    self.level = self.love
    -- Default title / class (saved to the save file)
    self.title = "Cooler\nDominates thirst."

	self.icon_color = {0, 170/255, 1}
	
    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {0, 170/255, 1}
    -- In which direction will this character's soul face (optional, defaults to facing up)
    self.soul_facing = "down"

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "Cool-Action"

    -- Spells
    self:addSpell("mercygrant")
    self:addSpell("magicrefill")
    self:addSpell("vaporizer")

    -- Current health (saved to the save file)
    self.health = 180

    -- Base stats (saved to the save file)
    self.stats = {
        health = 180,
        attack = 14,
        defense = 5,
        magic = 14
    }
    -- Max stats from level-ups
    self.max_stats = {}

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/water"

    -- Equipment (saved to the save file)
    self:setWeapon("filled_cup")
    -- self:setArmor(1, "amber_card")
    -- self:setArmor(2, "amber_card")

    self.color = {0, 0.667, 1} 
    self.dmg_color = {0, 0.8, 1} 
    self.attack_bar_color = {0.333, 0.667, 1}
    self.attack_box_color = {0, 0.467, 0.7}
    self.xact_color = {0, 0.784, 0.863} 

    -- Head icon in the equip / power menu
    self.menu_icon = "party/watercooler/head"
    -- Path to head icons used in battle
    self.head_icons = "party/watercooler/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/watercooler/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/splash"
    -- Sound played when this character attacks
    self.attack_sound = "frypan"
    -- Pitch of the attack sound
    self.attack_pitch = 1.3
    -- Battle position offset (optional)
    self.battle_offset = {3, 1}
    -- Head icon position offset (optional)
    self.head_icon_offset = {-1, -2}
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end

function character:getGameOverMessage(main)
    return {
        "(You hear water \nslurping nearby.)",
        "(You feel like \nit's time to \nwake up.)"
    }
end

function character:canEquip(item, slot_type, slot_index)
    if item then
        return super.canEquip(self, item, slot_type, slot_index)
    else
        local item
        if slot_type == "weapon" then
            item = self:getWeapon()
        elseif slot_type == "armor" then
            item = self:getArmor(slot_index)
        else
            return true
        end
        return false
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/snow")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Coolness", x, y)
        if Game.chapter <= 3 then
            love.graphics.print("89", x+130, y)
        else
            love.graphics.print("87", x+130, y)
        end
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/water")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Buble", x, y)
        love.graphics.print("Yes", x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        local icon2 = Assets.getTexture("ui/menu/icon/water")
        Draw.draw(icon2, x+90, y+6, 0, 2, 2)
        Draw.draw(icon2, x+110, y+6, 0, 2, 2)
        return true
    end
end

return character

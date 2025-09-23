local preview = {}

-- whether to fade out the default background
preview.hide_background = false

function preview:init(mod, button)
    -- code here gets called when the mods are loaded
    self.particles = {}
    self.particle_timer = 0

    button:setColor(0.57, 0.81, 0.47)
    button:setFavoritedColor(0.57, 0.81, 0.47)
end

function preview:update()
    -- code here gets called every frame, before any draws
    -- to only update while the mod is selected, check self.selected (or self.fade)

    --notmine--local to_remove = {}
    --notmine--for _,particle in ipairs(self.particles) do
    --notmine--    particle.radius = particle.radius
    --notmine--    particle.radius = particle.radius - (DT * 4)
    --notmine--    particle.y = particle.y - particle.speed * (DTMULT * 2)
    --notmine--
    --notmine--    if particle.radius <= 0 then
    --notmine--        table.insert(to_remove, particle)
    --notmine--    end
    --notmine--end
    --notmine--
    --notmine--for _,particle in ipairs(to_remove) do
    --notmine--    Utils.removeFromTable(self.particles, particle)
    --notmine--end
    --notmine--
    --notmine--self.particle_timer = self.particle_timer + DT
    --notmine--if self.particle_timer >= 0.25 then
    --notmine--    self.particle_timer = 0
    --notmine--    local radius = Utils.random() * 48 + 16
    --notmine--    table.insert(self.particles, {radius = radius, x = Utils.random() * SCREEN_WIDTH, y = SCREEN_HEIGHT + radius, max_radius = radius, speed = Utils.random() * 0.5 + 0.5})
    --notmine--end
end

function preview:draw()
    -- code here gets drawn to the background every frame!!
    -- make sure to check  self.fade  or  self.selected  here

    --notmine--if self.fade > 0 then
    --notmine--    love.graphics.setBlendMode("add")
    --notmine--
    --notmine--    for _,particle in ipairs(self.particles) do
    --notmine--        local alpha = (particle.radius / particle.max_radius) * self.fade
    --notmine--
    --notmine--        Draw.setColor(1, 1, 0.5, alpha)
    --notmine--        love.graphics.circle("fill", particle.x, particle.y, particle.radius)
    --notmine--    end
    --notmine--
    --notmine--    love.graphics.setBlendMode("alpha")
    --notmine--end
end

function preview:drawOverlay()
    -- code here gets drawn above the menu every frame
    -- so u can make cool effects
    -- if u want
end

return preview
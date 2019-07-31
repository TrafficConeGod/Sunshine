local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local health = entity.health
    local model = entity.model
    if health and model then
        local startTick
        local lastInvulnerable = health.invulnerable
        local lastFlash = false
        Sunshine:update(function()
            if health.invulnerable and health.invulnerable ~= lastInvulnerable then
                if health.invulnerabilityFrames then
                    startTick = entity.core.tick
                else
                    health.invulnerable = false
                end
            end
            if health.invulnerable and health.invulnerabilityFrames then
                for _,p in pairs (model.model:GetDescendants()) do
                    if CollectionService:HasTag(p, "flashable") then
                        p.Transparency = lastFlash and 0 or 1
                    end
                end
                lastFlash = not lastFlash
            end
            if health.invulnerable and entity.core.tick - startTick > health.time and health.invulnerabilityFrames then
                health.invulnerable = false
                for _,p in pairs (model.model:GetDescendants()) do
                    if CollectionService:HasTag(p, "flashable") then
                        p.Transparency = 0
                    end
                end
            end
            lastInvulnerable = health.invulnerable
        end, entity)
    end
end
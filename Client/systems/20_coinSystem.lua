-- SuperMakerPlayer and TrafficConeGod

return function(Sunshine, entity)
	local coin = entity.coin
    local transform = entity.transform
    local collider = entity.collider
    local speaker = entity.speaker

    local stop = false

    if coin and transform and collider and speaker then
        local collected = false
        local info = coin.tweenInfo
        local startTick
        local size = transform.size
        Sunshine:update(function()
            if collected and entity.core.tick - startTick <= info.Time then
                transform.size = Sunshine:tween(entity.core.tick - startTick, info, size, Vector3.new(0, 0, 0))
            elseif collected then
                Sunshine:destroyEntity(entity)
            end
            local hitEntity = collider.hitEntity
            if hitEntity and ((hitEntity.head and hitEntity.head.character) or (hitEntity.character and hitEntity.character.player)) and not collected then
                local player
                if hitEntity.character then
                    player = Sunshine:getEntity(hitEntity.character.player, entity.core.scene)
                elseif hitEntity.head then
                    local character = Sunshine:getEntity(hitEntity.head.character, entity.core.scene)
                    player = Sunshine:getEntity(character.character.player, entity.core.scene)
                end                
                startTick = entity.core.tick
                collected = true
                player.stats.coins = player.stats.coins + 1
                speaker.playing = true
                stop = true
            end
            if startTick ~= nil and stop then
                if entity.core.tick - startTick > 0.6 then
                    stop = false
                end
            end
        end, entity)
    end
end
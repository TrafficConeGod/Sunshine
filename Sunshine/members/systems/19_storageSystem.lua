-- TrafficConeGod

return function(Sunshine, entity)
    local store = entity.store
    if store then
        Sunshine:addConnection(Sunshine:onClientEvent(function(save)
            store.save = save
        end), nil, entity)
        Sunshine:fireServer("loading", entity.core.id)
        local lastSaveTick = tick()
        Sunshine:update(function()
            if (tick() - lastSaveTick) > 1 then
                lastSaveTick = tick()
                Sunshine:fireServer("saving", entity.core.id, store.save)
            end
        end, entity)
    end
end
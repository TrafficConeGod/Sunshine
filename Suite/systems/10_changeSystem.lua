return function(Sunshine, entity)
    local change = entity.change
    if change then
        Sunshine:update(function()
            if change.entity then
                if not change.alreadyChangedOnEntity then
                    change.entity[change.componentName][change.propertyName] = change.propertyValue
                end
                if not change.entity.core.dataEntity[change.componentName] then
                    change.entity.core.dataEntity[change.componentName] = {}
                end
                change.entity.core.dataEntity[change.componentName][change.propertyName] = change.propertyValue
                change.entity.core.scene.instance.Source = "return " .. Sunshine:encodeTable(Sunshine.dataScenes
                [change.entity.core.scene.index])
                Sunshine.PluginNetworkClient:fireAllClients(change.entity.core.scene.instance, change.entity.core.id,
                change.componentName,
                change.propertyName, change.propertyValue)
                change.entity = nil
                change.componentName = nil
                change.propertyName = nil
                change.propertyValue = nil
                change.alreadyChangedOnEntity = nil
            end
        end, entity)
        local index = Sunshine.PluginNetworkClient:onClientEvent(function(client, sceneInstance, entityId, componentName, propertyName, propertyValue)
            print(client,sceneInstance,entityId,componentName,propertyName,propertyValue)
        end)
        Sunshine:entityDestroy(function()
            Sunshine.PluginNetworkClient:removeClientEvent(index)
        end, entity)
    end
end
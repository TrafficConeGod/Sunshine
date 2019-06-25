return function(Sunshine, entity)
    local player = entity.player
    if player then
        local lastCharacter
        Sunshine:update(function()
            local mainCharacter = Sunshine:getEntity(player.mainCharacter)
            local character = Sunshine:getEntity(player.character)
            local camera = Sunshine:getEntity(player.camera)
            if mainCharacter and character and camera then
                character.character.player = entity
                character.input.camera = camera
                camera.camera.subject = character
                if character ~= mainCharacter then
                    mainCharacter.transform.cFrame = CFrame.new(0, 100000, 0)
                    mainCharacter.physics.movable = false
                    mainCharacter.character.controllable = false
                    character.character.controllable = true
                    character.capture.active = true
                end
                if lastCharacter and lastCharacter.capture and lastCharacter ~= character and character == mainCharacter then
                    lastCharacter.capture.active = false
                    lastCharacter.character.controllable = false
                    character.physics.movable = true
                    character.character.controllable = true
                    character.character.state = "bounce"
                    character.transform.cFrame = lastCharacter.transform.cFrame + Vector3.new(0, 10, 0)
                end
                lastCharacter = character
            end
        end, entity)
    end
end
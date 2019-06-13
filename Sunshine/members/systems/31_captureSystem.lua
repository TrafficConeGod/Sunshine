return function(Sunshine, entity)
    local capture = entity.capture
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    if capture and character and input and transform then
        Sunshine:update(function()
            if capture.active then
                if input.shift then
                    capture.active = false
                    character.controllable = false
                    local character = Sunshine:getEntityById(capture.character)
                    character.physics.movable = true
                    character.character.controllable = true
                    character.transform.cFrame = transform.cFrame + Vector3.new(0, 10, 0)
                    Sunshine:getEntityById(input.camera).camera.subject = character.core.id
                end
            end
        end, entity)
    end
end
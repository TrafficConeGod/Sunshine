local state = "state"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and input and transform and physics and animator then
        local lastState = character.state
        Sunshine:update(function()
            if character.controllable then
                if character.state == state then
                    -- update
                    if --[[end criteria]] or (lastState == state and character.state ~= state) then
                        -- end
                        character.state = nil
                    end
                elseif --[[start criteria]] or (lastState ~= state and character.state == state) then
                    -- start
                    character.state = state
                end
            end
            lastState = character.state
        end)
    end
end
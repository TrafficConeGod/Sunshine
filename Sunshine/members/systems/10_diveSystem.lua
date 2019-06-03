-- TrafficConeGod

local state = "dive"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and input and transform and physics and animator then
        local lastState = character.state
        local horizontal
        Sunshine:update(function(step)
            if character.controllable then
                if character.state == state then
                    -- update
                    horizontal = horizontal:Lerp(transform.cFrame.LookVector * component.power, step * 3)
                    physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
                    if character.grounded or (lastState == state and character.state ~= state) then
                        -- end
                        character.state = nil
                        animator.action = 2794459258
                    end
                elseif character.state == "groundPound" and not character.grounded and input.e or (lastState ~= state and character.state == state) then
                    -- start
                    character.state = state
                    character.movable = true
                    horizontal = transform.cFrame.LookVector * component.power
                    physics.velocity = horizontal + Vector3.new(0, 30, 0)
                    animator.action = 1146922909
                end
            end
            lastState = character.state
        end)
    end
end
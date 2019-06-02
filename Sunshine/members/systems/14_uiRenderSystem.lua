-- TrafficConeGod

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player.PlayerGui

local gui = Instance.new("ScreenGui") -- because roblox is a meanie engine
gui.IgnoreGuiInset = true -- why does this property need to exist it should always be true
gui.ResetOnSpawn = false -- again should always be false
gui.Parent = playerGui -- ANGERY

return function(Sunshine, entity)
    local frame = entity.frame
    local uiTransform = entity.uiTransform
    local transparency = entity.transparency
    local label = entity.label
    if (frame or label) and uiTransform then
        if frame then
            frame.frame = frame.frame:Clone()
            Sunshine:addInstance(frame.frame)
            frame.frame.Parent = gui
            local originalSize = frame.frame.Size
            Sunshine:update(function()
                frame.frame.Position = uiTransform.position
                frame.frame.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset * uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset * uiTransform.size.Y)
                frame.frame.Rotation = uiTransform.rotation
                frame.frame.ZIndex = uiTransform.zIndex
                if transparency then
                    frame.frame.Transparency = transparency.transparency
                end
            end)
        end
        if label then
            local labelInstance = Instance.new("TextLabel")
            labelInstance.BackgroundTransparency = 1
            labelInstance.TextScaled = true
            Sunshine:addInstance(labelInstance)
            labelInstance.Parent = gui
            local originalSize = label.size
            Sunshine:update(function()
                labelInstance.Position = uiTransform.position
                labelInstance.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset * uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset * uiTransform.size.Y)
                labelInstance.Rotation = uiTransform.rotation
                labelInstance.ZIndex = uiTransform.zIndex
                labelInstance.Text = label.text
                if transparency then
                    labelInstance.Transparency = transparency.transparency
                end
            end)
        end
    end
end
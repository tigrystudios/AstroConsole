-- Create the Main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Title Bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "AstroWare V1.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextSize = 20
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Category Buttons
local function createCategoryButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 120, 0, 40)
    button.Position = position
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = mainFrame
    return button
end

local playerButton = createCategoryButton("Player", UDim2.new(0, 10, 0, 50))
local miscButton = createCategoryButton("Misc", UDim2.new(0, 140, 0, 50))
local emotesButton = createCategoryButton("Emotes", UDim2.new(0, 270, 0, 50))

-- Category Frames
local function createCategoryFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 1, -100)
    frame.Position = UDim2.new(0, 10, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.Visible = false
    frame.Parent = mainFrame
    return frame
end

local playerFrame = createCategoryFrame()
local miscFrame = createCategoryFrame()
local emotesFrame = createCategoryFrame()

-- Function to Switch Categories
local function showCategory(frameToShow)
    playerFrame.Visible = false
    miscFrame.Visible = false
    emotesFrame.Visible = false
    frameToShow.Visible = true
end

-- Button Click Events
playerButton.MouseButton1Click:Connect(function()
    showCategory(playerFrame)
end)

miscButton.MouseButton1Click:Connect(function()
    showCategory(miscFrame)
end)

emotesButton.MouseButton1Click:Connect(function()
    showCategory(emotesFrame)
end)

-- Show Player Frame by Default
showCategory(playerFrame)

-----------------------------------
-- PLAYER CATEGORY BUTTONS & INPUTS
-----------------------------------

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid")

-- Create a function for creating input fields
local function createInputField(parent, placeholder, yOffset)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 200, 0, 40)
    box.Position = UDim2.new(0.5, -100, 0, yOffset)
    box.Text = ""
    box.PlaceholderText = placeholder
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Parent = parent
    return box
end

-- Speed Input
local speedInput = createInputField(playerFrame, "Enter Speed", 10)

-- Speed Apply Button
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0, 200, 0, 40)
speedButton.Position = UDim2.new(0.5, -100, 0, 60)
speedButton.Text = "Set Speed"
speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Parent = playerFrame

speedButton.MouseButton1Click:Connect(function()
    local speedValue = tonumber(speedInput.Text)
    if speedValue and humanoid then
        humanoid.WalkSpeed = speedValue
    end
end)

-- JumpPower Input
local jumpInput = createInputField(playerFrame, "Enter JumpPower", 120)

-- JumpPower Apply Button
local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0, 200, 0, 40)
jumpButton.Position = UDim2.new(0.5, -100, 0, 170)
jumpButton.Text = "Set JumpPower"
jumpButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
jumpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
jumpButton.Parent = playerFrame

jumpButton.MouseButton1Click:Connect(function()
    local jumpValue = tonumber(jumpInput.Text)
    if jumpValue and humanoid then
        humanoid.JumpPower = jumpValue
    end
end)

-- Fly Button
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 200, 0, 40)
flyButton.Position = UDim2.new(0.5, -100, 0, 230)
flyButton.Text = "Fly"
flyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Parent = playerFrame

local flying = false

flyButton.MouseButton1Click:Connect(function()
    if not flying then
        flying = true
        local bodyVelocity = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)

        local flyLoop
        flyLoop = game:GetService("RunService").Heartbeat:Connect(function()
            if not flying then
                flyLoop:Disconnect()
                bodyVelocity:Destroy()
            end
        end)
    else
        flying = false
    end
end)

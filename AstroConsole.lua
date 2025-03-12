-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

-- Create Main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 650, 0, 400)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

local PlayerBool = Instance.new("BoolValue")
PlayerBool.Name = "PlayerBool"
PlayerBool.Parent = mainFrame

local MiscBool = Instance.new("BoolValue")
MiscBool.Name = "MiscBool"
MiscBool.Parent = mainFrame

local EmoteBool = Instance.new("BoolValue")
EmoteBool.Name = "EmoteBool"
EmoteBool.Parent = mainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = mainFrame
UIStroke.Color = Color3.fromRGB(60, 18, 49) -- Red outline
UIStroke.Thickness = 2

-- Title Bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Text = "AstroWare V1.0"
title.TextColor3 = Color3.fromRGB(250, 161, 66)
title.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
title.TextSize = 20
title.Parent = mainFrame

-- Collapse Button
local collapseButton = Instance.new("TextButton")
collapseButton.Size = UDim2.new(0, 40, 0, 40)
collapseButton.Position = UDim2.new(1, -40, 0, 0)
collapseButton.Text = "-"
collapseButton.TextColor3 = Color3.fromRGB(255, 129, 66)
collapseButton.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
collapseButton.Parent = mainFrame

-- Sidebar (Categories)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 120, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
sidebar.Parent = mainFrame

local function createCategoryButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = UDim2.new(0, 0, 0, position * 40)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = sidebar
    return button
end

local playerButton = createCategoryButton("Player", 0)
local miscButton = createCategoryButton("Misc", 1)
local emotesButton = createCategoryButton("Emotes", 2)

-- Category Frames
local function createCategoryFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -120, 1, -40)
    frame.Position = UDim2.new(0, 120, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
    frame.Visible = false
    frame.Parent = mainFrame
    return frame
end

local playerFrame = createCategoryFrame()
local miscFrame = createCategoryFrame()
local emotesFrame = createCategoryFrame()

-- Show Category Function
local function showCategory(frameToShow)
    playerFrame.Visible = false
    miscFrame.Visible = false
    emotesFrame.Visible = false
    frameToShow.Visible = true
end

playerButton.MouseButton1Click:Connect(function()
     showCategory(playerFrame) 
     PlayerBool.Value = true
     MiscBool.Value = false
     EmoteBool.Value = false
    end)
miscButton.MouseButton1Click:Connect(function() 
    showCategory(miscFrame) 
    PlayerBool.Value = false
     MiscBool.Value = true
     EmoteBool.Value = false
end)
emotesButton.MouseButton1Click:Connect(function() 
    showCategory(emotesFrame) 
    PlayerBool.Value = false
     MiscBool.Value = false
     EmoteBool.Value = true
end)

showCategory(playerFrame) -- Default category

-- Collapse Functionality
local collapsed = false
collapseButton.MouseButton1Click:Connect(function()
    collapsed = not collapsed
PlayerBool.Value = playerFrame.Visible
MiscBool.Value = miscFrame.Visible
EmoteBool.Value = emotesFrame.Visible
    if collapsed then
        -- Disable all category frames and sidebar
        playerFrame.Visible = false
        miscFrame.Visible = false
        emotesFrame.Visible = false
        sidebar.Visible = false
        mainFrame.Size = UDim2.new(0, 650, 0, 40)
        collapseButton.Text = "+"
    else
        -- Enable all category frames and sidebar
        playerFrame.Visible = PlayerBool.Value
        miscFrame.Visible = MiscBool.Value
        emotesFrame.Visible = EmoteBool.Value
        sidebar.Visible = true
        mainFrame.Size = UDim2.new(0, 650, 0, 400)
        collapseButton.Text = "-"
    end
end)


-- Player Category Features
local function createInputField(parent, placeholder, yOffset)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 200, 0, 40)
    box.Position = UDim2.new(0.5, -100, 0, yOffset)
    box.Text = ""
    box.PlaceholderText = placeholder
    box.BackgroundColor3 = Color3.fromRGB(91, 46, 102)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Parent = parent
    return box
end

-- Speed Input
local speedInput = createInputField(playerFrame, "Enter Speed", 10)
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0, 200, 0, 40)
speedButton.Position = UDim2.new(0.5, -100, 0, 60)
speedButton.Text = "Set Speed"
speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Parent = playerFrame

speedButton.MouseButton1Click:Connect(function()
    local speedValue = tonumber(speedInput.Text)
    if speedValue and Humanoid then
        Humanoid.WalkSpeed = speedValue
    end
end)

-- JumpPower Input
local jumpInput = createInputField(playerFrame, "Enter JumpPower", 120)
local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0, 200, 0, 40)
jumpButton.Position = UDim2.new(0.5, -100, 0, 170)
jumpButton.Text = "Set JumpPower"
jumpButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
jumpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
jumpButton.Parent = playerFrame

jumpButton.MouseButton1Click:Connect(function()
    local jumpValue = tonumber(jumpInput.Text)
    if jumpValue and Humanoid then
        Humanoid.JumpPower = jumpValue
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
        local bodyVelocity = Instance.new("BodyVelocity", Character.HumanoidRootPart)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)

        local flyLoop
        flyLoop = RunService.Heartbeat:Connect(function()
            if not flying then
                flyLoop:Disconnect()
                bodyVelocity:Destroy()
            end
        end)
    else
        flying = false
    end
end)

-- Noclip Button
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0, 200, 0, 40)
noclipButton.Position = UDim2.new(0.5, -100, 0, 290)
noclipButton.Text = "Toggle Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Parent = playerFrame

local noclip = false
noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    RunService.Stepped:Connect(function()
        if noclip then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

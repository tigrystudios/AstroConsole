-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- UI Corner (Rounded edges)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

-- UI Stroke (Red Outline)
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(180, 0, 0)
UIStroke.Thickness = 2

-- Top Bar (Title & Dragging)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TopBar.Parent = MainFrame

-- Title Text
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.Text = "AstroConsole"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Close Button (X Button)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 16
CloseButton.BackgroundTransparency = 1
CloseButton.Parent = TopBar

-- Close Button Functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Draggable Function
local dragging
local dragInput
local dragStart
local startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Sidebar Frame
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -30)
Sidebar.Position = UDim2.new(0, 0, 0, 30)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -120, 1, -30)
ContentFrame.Position = UDim2.new(0, 120, 0, 30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentFrame.Parent = MainFrame

-- Function to Create Sidebar Buttons
local function createSidebarButton(text, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.Position = UDim2.new(0, 0, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = Sidebar
    return button
end

-- Sidebar Buttons
local PlayerButton = createSidebarButton("Player", 0)
local MiscButton = createSidebarButton("Miscellaneous", 30)
local FunButton = createSidebarButton("Fun", 60)
local TeleportsButton = createSidebarButton("Teleports", 90)

-- Function to Create Buttons
local function createButton(text, posY, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 280, 0, 40)
    button.Position = UDim2.new(0.5, -140, 0, posY)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.BackgroundColor3 = color
    button.Parent = ContentFrame
    return button
end

-- Create Buttons
local FlyButton = createButton("Fly", 10, Color3.fromRGB(0, 0, 255))
local SpeedButton = createButton("Speed", 60, Color3.fromRGB(0, 255, 0))
local JumpPowerButton = createButton("JumpPower", 110, Color3.fromRGB(255, 255, 0))
local KickButton = createButton("Kick Player", 160, Color3.fromRGB(255, 0, 0))

-- Button Click Functions (Placeholders)
FlyButton.MouseButton1Click:Connect(function()
    print("Fly activated")
end)

SpeedButton.MouseButton1Click:Connect(function()
    print("Speed activated")
end)

JumpPowerButton.MouseButton1Click:Connect(function()
    print("JumpPower activated")
end)

-- Kick Player Functionality
KickButton.MouseButton1Click:Connect(function()
    local players = game.Players:GetPlayers()
    local playerMenu = Instance.new("Frame")
    playerMenu.Size = UDim2.new(0, 200, 0, 300)
    playerMenu.Position = UDim2.new(0.5, -100, 0.5, -150)
    playerMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    playerMenu.BackgroundTransparency = 0.5
    playerMenu.Parent = ScreenGui

    for i, player in ipairs(players) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, 0, 0, 40)
        playerButton.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
        playerButton.Text = player.Name
        playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        playerButton.Parent = playerMenu

        playerButton.MouseButton1Click:Connect(function()
            player:Kick("You have been kicked by Astro Console.")
            playerMenu:Destroy()
        end)
    end
end)

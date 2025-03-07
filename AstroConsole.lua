-- Ensure HttpService is enabled
local HttpService = game:GetService("HttpService")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main UI frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Draggable = true

-- Red outline
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(180, 0, 0)
UIStroke.Thickness = 2

-- Sidebar Frame
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.Position = UDim2.new(0, 0, 0, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -120, 1, 0)
ContentFrame.Position = UDim2.new(0, 120, 0, 0)
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

-- Highlight Selected Category
local function selectCategory(button)
    for _, v in pairs(Sidebar:GetChildren()) do
        if v:IsA("TextButton") then
            v.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    button.TextColor3 = Color3.fromRGB(180, 0, 0)
end

PlayerButton.MouseButton1Click:Connect(function() selectCategory(PlayerButton) end)
MiscButton.MouseButton1Click:Connect(function() selectCategory(MiscButton) end)
FunButton.MouseButton1Click:Connect(function() selectCategory(FunButton) end)
TeleportsButton.MouseButton1Click:Connect(function() selectCategory(TeleportsButton) end)

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
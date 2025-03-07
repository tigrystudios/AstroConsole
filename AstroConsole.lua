-- Ensure HttpService is enabled
local HttpService = game:GetService("HttpService")

-- Create the main UI frame
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.5
mainFrame.Parent = ScreenGui
mainFrame.Draggable = true

-- Add UI corner to the frame
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

-- Create the version label at the top
local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(1, 0, 0, 50)
versionLabel.Position = UDim2.new(0, 0, 0, 0)
versionLabel.Text = "Astro Console V1.0"
versionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
versionLabel.TextSize = 20
versionLabel.BackgroundTransparency = 1
versionLabel.Parent = mainFrame

-- Create the Fly button
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 280, 0, 50)
flyButton.Position = UDim2.new(0, 10, 0, 70)
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 18
flyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
flyButton.Parent = mainFrame

-- Create the Speed button
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0, 280, 0, 50)
speedButton.Position = UDim2.new(0, 10, 0, 130)
speedButton.Text = "Speed"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.TextSize = 18
speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedButton.Parent = mainFrame

-- Create the JumpPower button
local jumpPowerButton = Instance.new("TextButton")
jumpPowerButton.Size = UDim2.new(0, 280, 0, 50)
jumpPowerButton.Position = UDim2.new(0, 10, 0, 190)
jumpPowerButton.Text = "JumpPower"
jumpPowerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerButton.TextSize = 18
jumpPowerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
jumpPowerButton.Parent = mainFrame

-- Create the Kick button
local kickButton = Instance.new("TextButton")
kickButton.Size = UDim2.new(0, 280, 0, 50)
kickButton.Position = UDim2.new(0, 10, 0, 250)
kickButton.Text = "Kick Player"
kickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
kickButton.TextSize = 18
kickButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
kickButton.Parent = mainFrame

-- Add functionality for the buttons

-- Fly functionality (just a placeholder for actual flying script)
flyButton.MouseButton1Click:Connect(function()
    print("Fly functionality activated")
    -- Add actual fly code here
end)

-- Speed functionality (just a placeholder for actual speed script)
speedButton.MouseButton1Click:Connect(function()
    print("Speed functionality activated")
    -- Add actual speed code here
end)

-- JumpPower functionality (just a placeholder for actual jump power script)
jumpPowerButton.MouseButton1Click:Connect(function()
    print("JumpPower functionality activated")
    -- Add actual jump power code here
end)

-- Kick Player functionality
kickButton.MouseButton1Click:Connect(function()
    local players = game.Players:GetPlayers()
    local playerToKick = nil

    -- Create a simple menu of players to choose from
    local playerMenu = Instance.new("Frame")
    playerMenu.Size = UDim2.new(0, 200, 0, 300)
    playerMenu.Position = UDim2.new(0.5, -100, 0.5, -150)
    playerMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    playerMenu.BackgroundTransparency = 0.5
    playerMenu.Parent = ScreenGui

    -- Add a list of players to the menu
    for i, player in ipairs(players) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, 0, 0, 40)
        playerButton.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
        playerButton.Text = player.Name
        playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        playerButton.TextSize = 16
        playerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
        playerButton.Parent = playerMenu

        -- When a player is selected, kick them
        playerButton.MouseButton1Click:Connect(function()
            player:Kick("You have been kicked by Astro Console.")
            playerMenu:Destroy()  -- Close the player selection menu
        end)
    end
end)
